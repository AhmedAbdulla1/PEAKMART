import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:peakmart/features/profile/presentation/state_m/profile/cubit.dart';
import 'package:peakmart/features/profile/presentation/views/Information%20Center/about_us_view.dart';
import 'package:peakmart/features/profile/presentation/views/Information%20Center/contact_us_view.dart';
import 'package:peakmart/features/profile/presentation/views/Information%20Center/exchange__return_policy_view.dart';
import 'package:peakmart/features/profile/presentation/views/Information%20Center/privacy_policy_view.dart';
import 'package:peakmart/features/profile/presentation/views/balance/balance_view.dart';
import 'package:peakmart/features/profile/presentation/views/personal_inof/personal_inof_screen.dart';
import 'package:peakmart/features/profile/presentation/views/profile/profile_menu_item.dart';
import 'package:peakmart/features/profile/presentation/views/settings/settings_view.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/user_product_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userinfo});

  final UserInfoEntity userinfo;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        height: double.infinity,
        color: const Color(0xFF8B4513),
        child: Stack(
          children: [
            _buildHeader(context),
            Positioned(
              top: (screenHeight * 0.20).clamp(80, double.infinity),
              left: 0,
              right: 0,
              bottom: 0,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  _buildCard(context, screenWidth),
                  _buildAvatar(screenWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 30),
          Text(
            'Profile',
            style: getBoldStyle(
              fontSize: FontSize.s22,
              color: ColorManager.white,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined,
                size: 30, color: Colors.white),
            onPressed: () =>
                Navigator.pushNamed(context, SettingsView.routeName),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, double screenWidth) {
    return Positioned(
      top: screenWidth * 0.15,
      left: 0,
      right: 0,
      bottom: 0,
      child: Card(
        color: context.isDarkMode ? Colors.black : Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.only(
              top: screenWidth * 0.15 + 10, left: 16, right: 16),
          child: Column(
            children: [
              _buildUserInfo(screenWidth),
              const SizedBox(height: 8),
              _buildPointsCard(screenWidth),
              const SizedBox(height: 8),
              Expanded(child: _buildMenuItems(context, screenWidth)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(double screenWidth) {
    return Column(
      children: [
        Text(
          userinfo.userName,
          style: TextStyle(
              fontSize: screenWidth * 0.055, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          userinfo.email,
          style: TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPointsCard(double screenWidth) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
        color: ColorManager.grey,
        child: Center(
          child: Text(
            'POINTS: ${userinfo.loyaltyPoint}',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, double screenWidth) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileMenuItem(
            icon: Icons.person,
            title: 'Personal Information',
            iconColor: Colors.blue,
            onTap: () async {
              final result = await Navigator.pushNamed(
                  context, PersonalInformationView.routeName);
              if (result == true) {
                BlocProvider.of<ProfileCubit>(context).fetchProfileIfNeeded();
              }
            },
          ),
          ProfileMenuItem(
            icon: Icons.production_quantity_limits_outlined,
            title: 'Your Products',
            iconColor: Colors.teal,
            onTap: () =>
                Navigator.pushNamed(context, UserProductsView.routeName),
          ),
          ProfileMenuItem(
            icon: Icons.account_balance_wallet_outlined,
            title: 'Payment',
            iconColor: Colors.green,
            onTap: () => Navigator.pushNamed(context, BalanceView.routeName,
                arguments: userinfo),
          ),
          ProfileMenuItem(
            icon: Icons.support_agent_outlined,
            title: 'Contact Us',
            iconColor: Colors.indigo,
            onTap: () => Navigator.pushNamed(context, ContactUsView.routeName),
          ),
          ProfileMenuItem(
            icon: Icons.info_outline,
            title: 'About Us',
            iconColor: Colors.orange,
            onTap: () => Navigator.pushNamed(context, AboutUsView.routeName),
          ),
          ProfileMenuItem(
            icon: Icons.verified_user_outlined,
            title: 'Privacy & Policy',
            iconColor: Colors.purple,
            onTap: () =>
                Navigator.pushNamed(context, PrivacyPolicyView.routeName),
          ),
          ProfileMenuItem(
            icon: Icons.swap_horizontal_circle_outlined,
            title: 'Exchange & Return Policy',
            iconColor: Colors.cyan,
            onTap: () => Navigator.pushNamed(
                context, ExchangeReturnPolicyView.routeName),
          ),
          Divider(
              color: ColorManager.grey,
              thickness: 3,
              endIndent: screenWidth * 0.06,
              indent: screenWidth * 0.06),
          ProfileMenuItem(
            icon: Icons.logout,
            title: 'Logout',
            iconColor: Colors.red,
            onTap: () => showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(double screenWidth) {
    return CircleAvatar(
      radius: screenWidth * 0.15,
      backgroundColor: ColorManager.white,
      child: CircleAvatar(
        radius: screenWidth * 0.15 - 5,
        backgroundColor: ColorManager.primary,
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: userinfo.photo,
            placeholder: (context, url) => const WaitingWidget(),
            errorWidget: (context, url, error) => Icon(
              Icons.person,
              size: screenWidth * 0.15,
              color: Colors.white,
            ),
            fit: BoxFit.cover,
            width: screenWidth * 0.3,
            height: screenWidth * 0.3,
          ),
        ),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.spaceBetween,
          title: const Text(
            'Logout',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'You’ll need to enter your username\n  and password next time\n you want to login',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel',
                  style: getRegularStyle(fontSize: 20, color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Container(
              width: 3,
              height: 30,
              color: ColorManager.grey,
            ),
            TextButton(
              child: Text('Logout',
                  style:
                      getRegularStyle(fontSize: 20, color: ColorManager.red)),
              onPressed: () {
                Navigator.of(context).pop();
                ProfileCubit().logout(onSuccess: () {
                  Navigator.pushReplacementNamed(context, LogInView.routeName);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
