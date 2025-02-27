import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/bid_owner/presentation/views/add_product_details.dart';
import 'package:peakmart/features/bid_owner/presentation/views/bid_owner_view.dart';
import 'package:peakmart/features/home/presentation/views/home_view.dart';
import 'package:peakmart/features/products/presentation/views/products_view.dart';
import 'package:peakmart/features/profile/presentation/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String routeName = '/main_view';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentPageIndex = 0;
  final List<TabItem> _navBarItems = const [
    TabItem(icon: Icons.home, title: AppStrings.home),
    TabItem(icon: Icons.shopping_cart, title: AppStrings.product),
    TabItem(icon: Icons.notifications, title: AppStrings.notification),
    TabItem(icon: Icons.add, title: 'add'),
    TabItem(icon: Icons.people, title: AppStrings.profile),
  ];
  List<Widget> getBottomNavigationBarBody() {
    return [
      const HomeView(),
      const ProductsView(),
      const Center(child: Text(AppStrings.notification)),
      const BidOwnerView(),
      const ProfileView(),
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
