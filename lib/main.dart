import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peakmart/app/app.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/language_manager.dart';
import 'package:peakmart/features/notifications/data/firebase_cloud_messaging_service.dart';
import 'package:peakmart/firebase_options.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  intNotificationModule();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseCloudMessagingService.initialize();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await initAppModule();
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  // Enable WebView for Android
  if (Platform.isAndroid && WebViewPlatform.instance == null) {
    WebViewPlatform.instance = AndroidWebViewPlatform();
  }

  // Handle Flutter framework errors (build/render exceptions)
  // ErrorWidget.builder = (FlutterErrorDetails details) {
  //   return const Center(
  //     child: Text(
  //       'Oops! Something went wrong.',
  //       style: TextStyle(color: Colors.red, fontSize: 18),
  //     ),
  //   );
  // };

  // Handle all uncaught errors globally
  // FlutterError.onError = (FlutterErrorDetails details) async {
  //   FlutterError.presentError(details);
  //   runApp(
  //     EasyLocalization(
  //       supportedLocales: const [englishLocale, arabicLocale],
  //       path: assetPathLocalizations,
  //       child: Phoenix(
  //         child: MaterialApp(
  //           debugShowCheckedModeBanner: false,
  //           home: ErrorScreenHandler(errorDetails: details),
  //         ),
  //       ),
  //     ),
  //   );
  // };

  runApp(
    EasyLocalization(
      supportedLocales: const [englishLocale, arabicLocale],
      path: assetPathLocalizations,
      child: Phoenix(child: MyApp()),
    ),
  );
}
