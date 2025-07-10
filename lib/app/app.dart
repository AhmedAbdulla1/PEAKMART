import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart' as di;
import 'package:peakmart/core/resources/routes_manager.dart';
import 'package:peakmart/core/resources/theme/app_theming_cubit/app_theme_cubit.dart';
import 'package:peakmart/core/resources/theme/dark_theme_data.dart';
import 'package:peakmart/core/resources/theme/light_theme_data.dart';
import 'package:peakmart/features/main/main_view.dart';
import 'package:peakmart/features/notifications/data/firebase_cloud_messaging_service.dart';
import 'package:peakmart/features/notifications/domain/notification_repository.dart';
import 'package:peakmart/features/notifications/presentation/state_m/notifications_cubit.dart';
import 'package:peakmart/features/products/presentation/views/product_details/product_details_view.dart';
import 'package:peakmart/features/notifications/presentation/state_m/notification_cubit.dart';
class MyApp extends StatefulWidget {
  const MyApp._internal();
  static final navigatorKey = GlobalKey<NavigatorState>();
  static MyApp instance = const MyApp._internal();
  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = di.instance<AppPreferences>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _appPreferences.getLocale().then((value) {
      context.setLocale(value);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final msg = FirebaseCloudMessagingService.initialMessage;
      if (msg != null) {
        FirebaseCloudMessagingService.initialMessage = null;

        final productIdString = msg.data['product_id'];
        final productId = int.tryParse(productIdString ?? '') ?? 0;

        // أول حاجة نروح للـ MainView (لو التطبيق لسه مفتوحش)
        MyApp.navigatorKey.currentState?.pushNamed(MainView.routeName, arguments: 0);

        // بعدين نفتح صفحة التفاصيل
        Future.delayed(const Duration(milliseconds: 300), () {
         MyApp.navigatorKey.currentState?.pushNamed(
            ProductDetails.routeName,
            arguments: productId,
          );
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AppThemeCubit(),),
          BlocProvider(create: (context) => NotificationsCubit()),
          BlocProvider(create: (context) => NotificationCubit(di.instance<NotificationRepo>() )),
        ],
        child: BlocBuilder<AppThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: context.locale,
              navigatorKey:MyApp.navigatorKey,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              themeMode: themeMode,
              theme: getLightTheme(),
              darkTheme: getDarkTheme(),
              title: 'Bid Mart',
              initialRoute: Routes.root,
              onGenerateRoute: RouteGenerator.getRoute,
            );
          },
        ),
      ),
    );
  }
}
