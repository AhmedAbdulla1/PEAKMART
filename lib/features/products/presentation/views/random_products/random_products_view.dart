import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/home/presentation/state_m/random_products_cubit/random_products_cubit.dart';
import 'package:peakmart/features/products/presentation/views/random_products/random_products_view_body.dart';

class RandomProductsView extends StatelessWidget {
  const RandomProductsView({super.key, required this.allProducts});
  final List<ProductEntity> allProducts;
  static const String routeName = "/random_products_view";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.recommendedProducts,
      ),
      body: BlocProvider(
        create: (context) =>
            RandomProductsCubit()..showRandomProducts(allProducts: allProducts),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
          child: RandomProductsViewBody(),
        ),
      ),
    ));
  }
}
