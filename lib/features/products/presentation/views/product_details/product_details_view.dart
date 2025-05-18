import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/features/auth/presentation/shared_widgets/custom_appbar.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/cubit.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/state.dart';
import 'package:peakmart/features/products/presentation/state_m/top_bidders_cubit/top_bidder_cubit.dart';
import 'package:peakmart/features/products/presentation/views/product_details/widgets/product_details_view_body.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = '/product-details';
  final int productId;

  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit()..getProductById(id: widget.productId),
      child: Scaffold(
        appBar: const CustomAppBar(title: "Product Details"),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Skeletonizer(
                  enabled: true,
                  enableSwitchAnimation: true,
                  child: BlocProvider(
                    create: (context) =>
                        TopBidderCubit()..getTopBidders(productId: 1),
                    child: const ProductDetailsViewBody(
                        product: const ProductEntity(
                            id: 1,
                            name: 'name',
                            imageUrl: [''],
                            endDate: 'endDate',
                            status: 'status',
                            startingPrice: 'startingPrice',
                            expectedPrice: 'expectedPrice',
                            startDate: 'startDate',
                            createdAt: 'createdAt',
                            peopleRolledIn: 2,
                            periodOfBid: 5,
                            catId: 1,
                            userId: 299,
                            price: 25500,
                            isEnded: true,
                            description: 'description')),
                  ));
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;
              return BlocProvider(
                create: (context) =>
                    TopBidderCubit()..getTopBidders(productId: product.id),
                child: ProductDetailsViewBody(product: product),
              );
            } else if (state is ProductError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 80, color: Colors.red[400]),
                    20.vGap,
                    Text("Oops! Something went wrong",
                        style: getMediumStyle(fontSize: 22)),
                    10.vGap,
                    Text("Failed to load product details",
                        textAlign: TextAlign.center,
                        style: getRegularStyle(
                            fontSize: 18, color: ColorManager.greyColor)),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.refresh,
                        size: 25,
                      ),
                      label: const Text("Try Again"),
                      onPressed: () {
                        context
                            .read<ProductCubit>()
                            .getProductById(id: widget.productId);
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox(); // fallback
            }
          },
        ),
      ),
    );
  }
}
