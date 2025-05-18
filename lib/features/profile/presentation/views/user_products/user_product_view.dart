import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:peakmart/features/profile/presentation/state_m/cart/user_products_cubit.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/enrolled_products_tab.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/uploaded_products_tab.dart';

class UserProductsView extends StatelessWidget {
  static const String routeName = '/userProductsView';

  UserProductsView({super.key});

  final bool isSeller = instance<AppPreferences>().getCookie("HKH").isNotEmpty;

  @override
  Widget build(BuildContext context) {
    log("isSeller: $isSeller");
    return DefaultTabController(
      length: isSeller ? 2 : 1,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: context.colorScheme.surface,
          title: Text(
            'Your Products',
            style: getSemiBoldStyle(
                fontSize: FontSize.s20, color: ColorManager.primary),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorWeight: 2,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 40),
            splashBorderRadius: BorderRadius.circular(15),
            tabs: [
              const Tab(text: 'Enrolled'),
              if (isSeller) const Tab(text: 'Uploaded'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (context) => UserProductsCubit()..getEnrolledProducts(),
              child: const EnrolledProductsTab(),
            ),
            if (isSeller)
              BlocProvider(
                create: (context) => UserProductsCubit()..getUploadedProducts(),
                child: const UploadedProductsTab(),
              ),
          ],
        ),
      ),
    );
  }
}
