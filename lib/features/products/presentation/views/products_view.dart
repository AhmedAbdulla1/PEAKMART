import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/products/data/models/product_model.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/cubit.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/state.dart';
import 'package:peakmart/features/products/presentation/widgets/product_item_widget.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..fetchProducts(),
      child: const ProductsBody(),
    );
  }
}

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const WaitingWidget();
          }
          if (state is ProductError) {
            return ErrorViewer.showError(
              context: context,
              error: state.error,
              callback: () {
                context.read<ProductCubit>().fetchProducts();
              },
            );
          }
          if (state is ProductLoaded) {
            List<Product> products = state.products;
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                return ItemWidget(product: state.products[index], index: index);
              },
            );
          }
          return const WaitingWidget();
        },
      ),
    );
  }
}
