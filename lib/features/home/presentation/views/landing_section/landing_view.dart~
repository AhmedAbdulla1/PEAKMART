import 'package:flutter/material.dart';
import 'package:peakmart/app/resources/assets_manager.dart';
import 'package:peakmart/app/resources/values_manager.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  final String title = "Get the deal of a lifetime...";
  final String subtitle = "Join and start bidding!";
  final String buttonText = "join now";

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppPadding.p20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 4.0,

      child: Container(
        margin:EdgeInsetsDirectional.only(start: 16.0,top: 16.0,bottom: 13),
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.landingBg), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            Text(
              subtitle,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                buttonText,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
