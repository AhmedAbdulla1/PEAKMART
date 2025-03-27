import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/profile/presentation/cart/product_item_widget.dart';
import 'package:peakmart/features/profile/presentation/state_m/cart/cubit.dart';
import 'package:peakmart/features/profile/presentation/state_m/cart/state.dart';

class CartView extends StatelessWidget {
  static const String routeName = '/cart';

  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..fetchProducts(),
      child: const ProductsBody(),
    );
  }
}

class ProductsBody extends StatelessWidget {
  const ProductsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const WaitingWidget();
            }
            if (state is CartError) {
              return ErrorViewer.showError(
                context: context,
                error: state.error,
                callback: () {
                  context.read<CartCubit>().fetchProducts();
                },
              );
            }
            if (state is CartLoaded) {
              List<ProductEntity> products = state.products;
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductItemWidget(
                      product: state.products[index], index: index + 1);
                },
              );
            }
            return const WaitingWidget();
          },
        ),
      ),
    );
  }
}
