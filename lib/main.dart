import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/app.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/language_manager.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
    
  await Firebase.initializeApp();
  await initAppModule();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   FlutterError.dumpErrorToConsole(details);
  //   runApp(ErrorWidgetClass(details));
  // };
  runApp(EasyLocalization(
    supportedLocales: const  [englishLocale,arabicLocale],
    path: assetPathLocalizations,
    child: Phoenix(
      child: MyApp(),
    ),
  ));
}
