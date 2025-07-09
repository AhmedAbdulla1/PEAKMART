import 'dart:developer';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/error_ui/toast.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/hold_screen.dart';
import 'package:peakmart/features/auth/presentation/views/signup_for_bid/view.dart';
import 'package:peakmart/features/bid_owner/presentation/views/bid_owner_view.dart';
import 'package:peakmart/features/home/presentation/views/home_view.dart';
import 'package:peakmart/features/notifications/data/firebase_cloud_messaging_service.dart';
import 'package:peakmart/features/notifications/presentation/state_m/notifications_cubit.dart';
import 'package:peakmart/features/notifications/presentation/view/notifications_view.dart';
import 'package:peakmart/features/products/presentation/views/products_view.dart';
import 'package:peakmart/features/profile/presentation/views/profile/view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, this.currentPageIndex = 0});
  static const String routeName = '/main_view';
  final int currentPageIndex;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with TickerProviderStateMixin {
  int _currentIndex = 0;
  int? _selectedCategoryId;
  int notificationCount = 0;

  late final AnimationController _animationController;
  late final Animation<double> _shakeAnimation;

  bool _isNotificationAnimating = false;

  void listenNotificationStream() {
    FirebaseCloudMessagingService.streamController.stream.listen(
      (notificationMessage) async {
        final isNotificationsActive = context.read<NotificationsCubit>().state;
        if (!isNotificationsActive) {
          if (mounted) {
            Toast.show("Notifications are disabled.",
                backgroundColor: ColorManager.primary);
          }
          return;
        }

        log('Notification Received: ${notificationMessage.notification?.body}');

        setState(() {
          notificationCount++;
          _isNotificationAnimating = true;
        });

        _animationController.forward(from: 0);
        await Future.delayed(const Duration(seconds: 1));

        if (mounted) {
          setState(() => _isNotificationAnimating = false);
        }
      },
    );
  }

  @override
  void initState() {
    _currentIndex = widget.currentPageIndex;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        }
      });

    listenNotificationStream();
    super.initState();
  }

  @override
  void dispose() {
    FirebaseCloudMessagingService.streamController.close();
    _animationController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) _selectedCategoryId = null;
      if (index == 3) notificationCount = 0;
    });
  }

  void _onCategorySelected(int categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      _currentIndex = 1;
    });
  }

  void addProductSelection() {
    final prefs = instance<AppPreferences>();
    if (prefs.getCookie("HKH") != '') {
      Navigator.pushNamed(context, HoldScreen.routeName);
    } else if (prefs.getCookie("HKHN") != '') {
      Navigator.pushNamed(context, SignUpForBidView.routeName, arguments: 1);
    } else if (prefs.getCookie("PHONE") != '') {
      Navigator.pushNamed(context, OtpVerification.routeName, arguments: {
        'verificationType': VerificationType.watsApp,
      });
    } else {
      Navigator.pushNamed(context, SignUpForBidView.routeName, arguments: 0);
    }
  }

  Widget _buildNotificationIcon() {
    final isSelected = _currentIndex == 3;
    final isNotificationsActive = context.watch<NotificationsCubit>().state;

    Widget icon = Icon(
      isNotificationsActive
          ? Icons.notifications_active_outlined
          : Icons.notifications_off_outlined,
      size: 28,
      color: isSelected
          ? context.isDarkMode
              ? ColorManager.black
              : ColorManager.white
          : context.isDarkMode
              ? ColorManager.white
              : ColorManager.black,
    );

    if (_isNotificationAnimating) {
      icon = AnimatedBuilder(
        animation: _shakeAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_shakeAnimation.value, 0),
            child: child,
          );
        },
        child: icon,
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(child: icon),
        if (notificationCount > 0 && !isSelected)
          Positioned(
            right: -6,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$notificationCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  List<TabItem> get _navBarItems => [
        const TabItem(icon: Icons.home_outlined, title: AppStrings.home),
        const TabItem(
            icon: Icons.shopping_cart_outlined, title: AppStrings.product),
        const TabItem(icon: Icons.add, title: AppStrings.add),
        TabItem(icon: _buildNotificationIcon(), title: AppStrings.notification),
        const TabItem(icon: Icons.person_2_outlined, title: AppStrings.profile),
      ];

  List<Widget> getBottomNavigationBarBody() {
    return [
      HomeView(onCategorySelected: _onCategorySelected),
      ProductsView(categoryId: _selectedCategoryId),
      const BidOwnerView(),
      NotificationsView(message: const RemoteMessage()),
      const SummaryProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getBottomNavigationBarBody()[_currentIndex],
        bottomNavigationBar: ConvexAppBar(
          key: ValueKey(_currentIndex),
          height: 55,
          curve: Curves.easeInOut,
          style: TabStyle.custom,
          color: context.isDarkMode
              ? ColorManager.white
              : ColorManager.bottomNavBarSecondary,
          backgroundColor:
              context.isDarkMode ? ColorManager.black : ColorManager.white,
          elevation: 5,
          activeColor: context.primaryColor,
          items: _navBarItems,
          initialActiveIndex: _currentIndex,
          onTap: _onTabSelected,
        ),
      ),
    );
  }
}
