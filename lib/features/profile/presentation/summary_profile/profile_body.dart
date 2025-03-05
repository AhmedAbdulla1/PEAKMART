import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/profile/presentation/state_m/summary_profile/cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.model});

  final SummaryProfileModel model;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // if (state.isLoggedOut) {
          //   showDialog(
          //     context: context,
          //     builder: (context) => AlertDialog(
          //       title: const Text('Logged Out'),
          //       content: const Text('You have been logged out successfully.'),
          //       actions: [
          //         TextButton(
          //           onPressed: () => Navigator.of(context).pop(),
          //           child: const Text('OK'),
          //         ),
          //       ],
          //     ),
          //   );
          // }
        },
        child: SafeArea(
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
                        IconButton(
                          icon: const Icon(Icons.shopping_cart_outlined,
                              size: 30, color: Colors.white),
                          onPressed: () {},
                        ),
                        Text(
                          'Profile',
                          style: getBoldStyle(
                              fontSize: 20, color: ColorManager.white),
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
                            padding:
                                EdgeInsets.only(top: screenWidth * 0.15 + 10, left: 16,right: 16),
                            child: Column(
                              children: [
                                Text(
                                  model.name,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.055,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  model.email,
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
                                        'POINTS: ${model.points}',
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
                                    context.read<ProfileCubit>().logout();
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
                            backgroundColor: Colors.purple,
                            child: Icon(
                              Icons.person,
                              size: screenWidth * 0.15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
