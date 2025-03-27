import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/bid_owner/presentation/views/add_product_details.dart';
import 'package:peakmart/features/bid_owner/presentation/views/bid_owner_view.dart';
import 'package:peakmart/features/home/presentation/views/home_view.dart';
import 'package:peakmart/features/products/presentation/views/products_view.dart';
import 'package:peakmart/features/profile/presentation/profile_view.dart';
import 'package:peakmart/features/profile/presentation/profile/view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String routeName = '/main_view';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentPageIndex = 0;
  final List<TabItem> _navBarItems =  [
    const TabItem(icon: Icons.home_outlined, title: AppStrings.home),
    TabItem(icon: Icons.shopping_cart_outlined, title: AppStrings.product),
    const TabItem(
        icon: Icons.notifications_active_outlined,
        title: AppStrings.notification),
    const TabItem(icon: Icons.add, title: 'add'),
    const TabItem(icon: Icons.person_2_outlined, title: AppStrings.profile),
  ];

  List<Widget> getBottomNavigationBarBody() {
    return [
      const HomeView(),
      const ProductsView(),
      const ProfileView(),
      const BidOwnerView(),
      const SummaryProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: getBottomNavigationBarBody()[_currentPageIndex],
        bottomNavigationBar: ConvexAppBar(
          height: 55,
          curve: Curves.easeInOut,
          style: TabStyle.custom,
          color: ColorManager.bottomNavBarSecondary,
          backgroundColor: ColorManager.white,
          elevation: 5,
          activeColor: ColorManager.primary,
          items: _navBarItems,
          initialActiveIndex: _currentPageIndex,
          onTap: (index) {
            setState(() => _currentPageIndex = index);
          },
        ),
      ),
    );
  }
}
