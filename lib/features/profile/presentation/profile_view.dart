import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/auth/presentation/views/login/login_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool onBoardingSwitch = false;
  bool reLoginSwitch = false;
  bool logoutSwitch = false;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Show OnBoarding',
                style: const TextStyle(fontSize: 20),
              ),
              Switch(
                  value: onBoardingSwitch,
                  onChanged: (value) {
                    setState(() {
                      onBoardingSwitch = value;
                    });
                    _appPreferences.remove(pressKeyOnBoardingScreen);
                  }),
            ],
          ),
          20.vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Re login',
                style: const TextStyle(fontSize: 20),
              ),
              Switch(
                  value: reLoginSwitch,
                  onChanged: (value) {
                    setState(() {
                      reLoginSwitch = value;
                    });
                    _appPreferences.remove(pressKeyLoginScreen);
                    _appPreferences.remove(userIdKey);
                  }),
            ],
          ),
          20.vGap,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Logout',
                style: const TextStyle(fontSize: 20),
              ),
              Switch(
                  value: logoutSwitch,
                  onChanged: (value) async {
                    setState(() {
                      logoutSwitch = value;
                    });
                    await _appPreferences.logout();
                    print('logout');
                    print(_appPreferences.getCookiesKey());
                    Navigator.pushNamed(context, LogInView.routeName);
                  }),
            ],
          ),
          20.vGap,
          ElevatedButton(
              onPressed: () {
                Phoenix.rebirth(context);
              },
              child: const Text('Re start'))
        ],
      ),
    );
  }
}
