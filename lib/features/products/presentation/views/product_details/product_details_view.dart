import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/shared_widgets/full_screen_unknown_error.dart';
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
                    child: ProductDetailsViewBody(product: dummyProduct(1)),
                  ));
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;
              return BlocProvider(
                create: (context) =>
                    TopBidderCubit()..getTopBidders(productId: product.id),
                child: ProductDetailsViewBody(product: product),
              );
            } else if (state is ProductError) {
              return FullScreenUnknownError(
                  message: 'Failed to load product details',
                  onRetry: () {
                    context
                        .read<ProductCubit>()
                        .getProductById(id: widget.productId);
                  });
            } else {
              return const SizedBox(); // fallback
            }
          },
        ),
      ),
    );
  }
}

ProductEntity dummyProduct(int id) => const ProductEntity(
      id: 0,
      name: 'Loading...',
      imageUrl: [''],
      endDate: '',
      status: '',
      startingPrice: '',
      expectedPrice: '',
      startDate: '',
      createdAt: '',
      peopleRolledIn: 0,
      periodOfBid: 0,
      catId: 0,
      userId: 0,
      price: 0.0,
      isEnded: true,
      description: 'Loading...',
    );
