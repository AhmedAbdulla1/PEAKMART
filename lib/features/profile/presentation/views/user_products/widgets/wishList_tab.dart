import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/main/main_view.dart';
import 'package:peakmart/features/profile/presentation/state_m/user_products/user_products_cubit.dart';
import 'package:peakmart/features/profile/presentation/state_m/user_products/user_products_states.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/no_products_founded_widget.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/product_uploaded_item_widget.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/wishList_item.dart';

class WishListTap extends StatefulWidget {
  const WishListTap({super.key});

  @override
  State<WishListTap> createState() => _UploadedProductsTabState();
}

class _UploadedProductsTabState extends State<WishListTap>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<UserProductsCubit>();
    cubit.getWishListProducts();
  }

  Widget buildNoProductsView() {
    return NoProductsFoundedWidget(
      title: 'No products uploaded yet.',
      buttonText: 'Upload a product',
      onButtonPressed: () {
        Navigator.pushNamed(context, MainView.routeName, arguments: 3);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<UserProductsCubit, UserProductsStates>(
      buildWhen: (previous, current) =>
          current is WishListLoading ||
          current is WishListLoaded ||
          current is WishlistError,
      builder: (context, state) {
        if (state is WishListLoading) {
          return const WaitingWidget();
        } else if (state is WishlistError) {
          return buildNoProductsView();
        } else if (state is WishListLoaded) {
          final products = state.products;
          return products.isEmpty
              ? buildNoProductsView()
              : RefreshIndicator(
                  onRefresh: () async {
                    final cubit = context.read<UserProductsCubit>();
                    cubit.restWishListPram();
                    await cubit.getWishListProducts();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return WishlistItemWidget(
                        product: products[index],
                        index: index + 1,
                      );
                    },
                  ),
                );
        } else {
          return const Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}
