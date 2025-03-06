import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/bid_owner/presentation/views/bid_owner_view.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/cubit.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/state.dart';
import 'package:peakmart/features/profile/presentation/cart/product_item_widget.dart';

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
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Products",
        isNotShowArrowBack: true,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, BidOwnerView.routeName);
            },
            tooltip: "Add Product",
            icon: const Center(
              child: Icon(
                Icons.add,
                color: ColorManager.white,
                size: AppSize.s20,
              ),
            ),
            style: IconButton.styleFrom(backgroundColor: ColorManager.primary),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p8, vertical: AppPadding.p12),
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: WaitingWidget());
            }

            if (state is ProductError) {
              return Center(
                child: ErrorViewer.showError(
                  context: context,
                  error: state.error,
                  callback: () {
                    context.read<ProductCubit>().fetchProducts();
                  },
                ),
              );
            }

            if (state is ProductLoaded) {
              List<ProductEntity> products = state.products;

              if (products.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart_outlined,
                          size: AppSize.s80, color: Colors.grey.shade400),
                      const SizedBox(height: 10),
                      Text("No products added yet!",
                          style: getBoldStyle(
                              fontSize: FontSize.s16,
                              color: ColorManager.grey)),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ItemWidget(product: products[index], index: index);
                },
              );
            }

            return const Center(child: WaitingWidget());
          },
        ),
      ),
    );
  }
}
