import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';
import 'package:peakmart/features/profile/domain/enitiy/user_info_entity.dart';
import 'package:peakmart/features/profile/presentation/state_m/profile/cubit.dart';
import 'package:peakmart/features/profile/presentation/user_products/cart_view.dart';

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
        color: const Color(0xFF8B4513), // Brown color from the image
        child: Stack(
          children: [
            // Header
            SizedBox(
              width: screenWidth,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   const SizedBox(
                      width:30,),
                    Text(
                      'Profile',
                      style:
                          getBoldStyle(fontSize: FontSize.s22, color: ColorManager.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings_outlined,
                          size: 30, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            // Main content with avatar and card
            Positioned(
              top: (screenHeight * 0.20).clamp(80, double.infinity),
              left: 0,
              right: 0,
              bottom: 0,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // Card starting below the avatar
                  Positioned(
                    top: screenWidth * 0.15,
                    // Dynamic based on avatar size
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: screenWidth * 0.15 + 10, left: 16, right: 16),
                        child: Column(
                          children: [
                            Text(
                              userinfo.userName,
                              style: TextStyle(
                                fontSize: screenWidth * 0.055,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              userinfo.email,
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p12),
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
                            ),
                            const SizedBox(height: 8),
                            ProfileMenuItem(
                              icon: Icons.person,
                              title: 'Personal Information',
                              iconColor: Colors.blue,
                              onTap: () {},
                            ),
                            ProfileMenuItem(
                              icon: Icons.production_quantity_limits_outlined,
                              title: 'Your Products',
                              iconColor: Colors.blueGrey,
                              onTap: () {
                                    Navigator.pushNamed(context, UserProductsView.routeName);
                              },
                            ),
                            ProfileMenuItem(
                              icon: Icons.payment,
                              title: 'Payment',
                              iconColor: Colors.red,
                              onTap: () {},
                            ),
                            SizedBox(
                              width: screenWidth * 0.75,
                              child: Divider(
                                color: ColorManager.grey,
                                thickness: 3,
                              ),
                            ),
                            ProfileMenuItem(
                              icon: Icons.logout,
                              title: 'logout',
                              iconColor: Colors.red,
                              onTap: () {
                                showLogoutDialog(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Avatar positioned to overlap the card
                  Positioned(
                    top: 0,
                    child: CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundColor: ColorManager.white,
                      child: CircleAvatar(
                        radius: screenWidth * 0.15 - 5,
                        backgroundImage: NetworkImage(userinfo.photo),
                        backgroundColor: ColorManager.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
          title: const Text('Logout',textAlign: TextAlign.center,),
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
              child:  Text('Logout',
                  style: getRegularStyle(fontSize: 20, color: ColorManager.red)
              ),
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

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15)),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      onTap: onTap,
    );
  }
}
