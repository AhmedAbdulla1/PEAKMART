import 'package:Bid_Mart/app/app_prefs.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/extentions.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/features/auth/presentation/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool onBoardingSwitch = false;
  bool reLoginSwitch = false;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Profile',
              style: getBoldStyle(color: ColorManager.primary, fontSize: 20)),
          20.vGap,

          // Show Onboarding Switch
          SwitchListTile(
            title:
                const Text('Show OnBoarding', style: TextStyle(fontSize: 18)),
            value: onBoardingSwitch,
            onChanged: (value) {
              setState(() {
                onBoardingSwitch = value;
              });
              _appPreferences.remove(pressKeyOnBoardingScreen);
            },
          ),

          // Re-Login Switch
          SwitchListTile(
            title: const Text('Re login', style: TextStyle(fontSize: 18)),
            value: reLoginSwitch,
            onChanged: (value) {
              setState(() {
                reLoginSwitch = value;
              });
              _appPreferences.remove(pressKeyLoginScreen);
              _appPreferences.remove(userIdKey);
            },
          ),

          // Logout Button
          ListTile(
            title: const Text('Logout', style: TextStyle(fontSize: 18)),
            trailing: ElevatedButton(
              onPressed: () async {
                await _appPreferences.logout();
                if (!mounted) return;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LogInView.routeName,
                  (_) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ),

          20.vGap,

          // Re-start app (Phoenix)
          ElevatedButton(
            onPressed: () {
              Phoenix.rebirth(context);
            },
            child: const Text('Re start'),
          ),
        ],
      ),
    );
  }
}
