import 'package:Bid_Mart/app/app_prefs.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/string_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/features/auth/presentation/views/otp_verification/otp_verification.dart';
import 'package:Bid_Mart/features/auth/presentation/views/signup_for_bid/hold_screen.dart';
import 'package:Bid_Mart/features/auth/presentation/views/signup_for_bid/view.dart';
import 'package:Bid_Mart/features/bid_owner/presentation/views/bid_owner_view.dart';
import 'package:Bid_Mart/features/home/presentation/views/home_view.dart';
import 'package:Bid_Mart/features/notifications/presentation/state_m/notification_cubit.dart';
import 'package:Bid_Mart/features/notifications/presentation/state_m/notification_state.dart';
import 'package:Bid_Mart/features/notifications/presentation/state_m/notifications_cubit.dart';
import 'package:Bid_Mart/features/notifications/presentation/view/notification_view.dart';
import 'package:Bid_Mart/features/products/presentation/views/products_view.dart';
import 'package:Bid_Mart/features/profile/presentation/views/profile/profile_view.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, this.currentPageIndex = 0});
  static const String routeName = '/main_view';
  final int currentPageIndex;

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  int? _selectedCategoryId;
  int _unseenCount = 0;

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.currentPageIndex;

    final notificationCubit = context.read<NotificationCubit>();
    notificationCubit.fetchNotifications();

    notificationCubit.stream.listen((state) {
      if (state is NotificationsLoaded) {
        setState(() {
          _unseenCount = state.unseenCount;
        });
      }
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) _selectedCategoryId = null;
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(child: icon),
        if (_unseenCount > 0 && !isSelected)
          if (_unseenCount > 0 && !isSelected)
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
                  '$_unseenCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
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
      const NotificationsView(),
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
          height: 55.h,
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
