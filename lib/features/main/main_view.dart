import 'package:flutter/material.dart';
import 'package:peakmart/core/resources/assets_manager.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/home/presentation/views/home_view.dart';
import 'package:peakmart/features/main/main_view_model.dart';
import 'package:peakmart/features/main/widget/custom_nav_bar.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final MainViewModel _viewModel = MainViewModel();

  final List<NavBarItem> _navBarItems = [
    NavBarItem(iconPath: IconsAssets.home, label: 'Home'),
    NavBarItem(iconPath: IconsAssets.products, label: 'Products'),
    NavBarItem(iconPath: IconsAssets.notification, label: 'Notification'),
    NavBarItem(iconPath: IconsAssets.profile, label: 'Profile'),
  ];

  void _onNavItemTapped(int index) {
    _viewModel.onNavItemTapped(index);
  }

  Widget _buildBodyScreens(index) => [
        HomeView(),
        Text('Products',
            style: getBoldStyle(color: ColorManager.primary, fontSize: 20)),
        Text('Notification',
            style: getBoldStyle(color: ColorManager.primary, fontSize: 20)),
        Text('Profile',
            style: getBoldStyle(color: ColorManager.primary, fontSize: 20)),
      ][index];

  Widget _buildAppBarTitle(int index) => [
    const Text('Bids'),
    const Text('Products'),
    const Text('Notification'),
    const Text('Profile'),
  ][index];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _viewModel.currentIndexOutput,
      builder: (context, snapshot) {
        int currentIndex = snapshot.data ?? 0;
        return SafeArea(
          child: Scaffold(
            appBar:currentIndex == 0? null : AppBar(
              title: _buildAppBarTitle(currentIndex),
            ),
            body: Center(
              child: _buildBodyScreens(snapshot.data ?? 0),
            ),
            bottomNavigationBar: CustomNavigationBar(
              items: _navBarItems,
              initialIndex: currentIndex,
              onTap: _onNavItemTapped,
              indicatorHeight: 6,
            ),
          ),
        );
      }
    );
  }
}
