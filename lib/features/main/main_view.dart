import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/bid_owner/presentation/views/bid_owner_view.dart';
import 'package:peakmart/features/home/presentation/views/home_view.dart';
import 'package:peakmart/features/products/presentation/views/products_view.dart';
import 'package:peakmart/features/profile/presentation/profile_view.dart';
import 'package:peakmart/features/profile/presentation/views/profile/view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String routeName = '/main_view';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentPageIndex = 0;
  int? _selectedCategoryId; // Store the selected category ID

  final List<TabItem> _navBarItems = const [
    TabItem(icon: Icons.home_outlined, title: AppStrings.home),
    TabItem(icon: Icons.shopping_cart_outlined, title: AppStrings.product),
    TabItem(
        icon: Icons.notifications_active_outlined,
        title: AppStrings.notification),
    TabItem(icon: Icons.add, title: 'add'),
    TabItem(icon: Icons.person_2_outlined, title: AppStrings.profile),
  ];

  void _onCategorySelected(int categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      _currentPageIndex = 1; // Switch to the Products tab (index 1)
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentPageIndex = index;
      if (index == 1) {
        _selectedCategoryId = null; // Reset category ID when manually switching to Products tab
      }
    });
  }

  List<Widget> getBottomNavigationBarBody() {
    return [
      HomeView(onCategorySelected: _onCategorySelected),
      ProductsView(categoryId: _selectedCategoryId),
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
          key: ValueKey(_currentPageIndex), // Force rebuild when _currentPageIndex changes
          height: 55,
          curve: Curves.easeInOut,
          style: TabStyle.custom,
          color: ColorManager.bottomNavBarSecondary,
          backgroundColor: ColorManager.white,
          elevation: 5,
          activeColor: ColorManager.primary,
          items: _navBarItems,
          initialActiveIndex: _currentPageIndex, // Update the selected tab
          onTap: _onTabSelected,
        ),
      ),
    );
  }
}