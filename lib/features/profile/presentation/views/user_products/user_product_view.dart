import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/profile/presentation/state_m/user_products/user_products_cubit.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/enrolled_products_tab.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/uploaded_products_tab.dart';

class UserProductsView extends StatelessWidget {
  static const String routeName = '/userProductsView';

  UserProductsView({super.key});

  final bool isSeller = instance<AppPreferences>().getCookie("HKH").isNotEmpty;

  @override
  Widget build(BuildContext context) {
    log("isSeller: $isSeller");

    return BlocProvider(
      create: (context) => UserProductsCubit(),
      child: DefaultTabController(
        length: isSeller ? 2 : 1,
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'Your Products',
            bottomWidget: TabBar(
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
              const EnrolledProductsTab(),
              if (isSeller) const UploadedProductsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
