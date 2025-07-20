import 'package:Bid_Mart/core/widgets/waiting_widget.dart';
import 'package:Bid_Mart/features/main/main_view.dart';
import 'package:Bid_Mart/features/profile/presentation/state_m/user_products/user_products_cubit.dart';
import 'package:Bid_Mart/features/profile/presentation/state_m/user_products/user_products_states.dart';
import 'package:Bid_Mart/features/profile/presentation/views/user_products/widgets/no_products_founded_widget.dart';
import 'package:Bid_Mart/features/profile/presentation/views/user_products/widgets/wishlist_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListTab extends StatefulWidget {
  const WishListTab({super.key});

  @override
  State<WishListTab> createState() => _UploadedProductsTabState();
}

class _UploadedProductsTabState extends State<WishListTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<UserProductsCubit>().loadCachedWishlistProductsIfAny();
  }

  Widget buildNoProductsView() {
    return NoProductsFoundedWidget(
      title: 'No products in wishlist',
      buttonText: 'Explore products',
      onRefresh: ()async {
         context.read<UserProductsCubit>().restWishListPram();
        await context.read<UserProductsCubit>().getWishListProducts();
      },
      onButtonPressed: () {
        Navigator.pushNamed(context, MainView.routeName, arguments: 1);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProductsCubit, UserProductsStates>(
      buildWhen: (previous, current) =>
          current is WishListLoading ||
          current is WishListLoaded ||
          current is WishlistError,
      builder: (context, state) {
        final cubit = context.read<UserProductsCubit>();

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
        }

        /// ➕ هنا الحل الأهم: تعامل مع الحالة غير المتوقعة بحكمة
        if (cubit.wishListProducts.isNotEmpty) {
          // في حالة رجعت والشاشة كانت مبنية فعليًا
          return RefreshIndicator(
            onRefresh: () async {
              cubit.restWishListPram();
              await cubit.getWishListProducts();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: cubit.wishListProducts.length,
              itemBuilder: (context, index) {
                return WishlistItemWidget(
                  product: cubit.wishListProducts[index],
                  index: index + 1,
                );
              },
            ),
          );
        }

        return buildNoProductsView();
      },
    );
  }
}
