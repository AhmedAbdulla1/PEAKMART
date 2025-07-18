import 'package:Bid_Mart/core/widgets/waiting_widget.dart';
import 'package:Bid_Mart/features/profile/presentation/state_m/user_products/user_products_cubit.dart';
import 'package:Bid_Mart/features/profile/presentation/state_m/user_products/user_products_states.dart';
import 'package:Bid_Mart/features/profile/presentation/views/user_products/widgets/no_products_founded_widget.dart';
import 'package:Bid_Mart/features/profile/presentation/views/user_products/widgets/product_enrolled_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EnrolledProductsTab extends StatefulWidget {
  const EnrolledProductsTab({super.key});

  @override
  State<EnrolledProductsTab> createState() => _EnrolledProductsTabState();
}

class _EnrolledProductsTabState extends State<EnrolledProductsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<UserProductsCubit>().loadCachedEnrolledProductsIfAny();
  }

  Widget buildNoProductsView() {
    return NoProductsFoundedWidget(
      title: 'No products enrolled yet.',
      buttonText: 'Retry',
      onButtonPressed: () {
        // Navigator.pushNamed(context, MainView.routeName, arguments: 1);
        final cubit = context.read<UserProductsCubit>();
        cubit.getEnrolledProducts();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<UserProductsCubit, UserProductsStates>(
      buildWhen: (previous, current) =>
          current is ProductsEnrolledLoading ||
          current is ProductsEnrolledLoaded ||
          current is ProductEnrolledError,
      builder: (context, state) {
        if (state is ProductsEnrolledLoading) {
          return const WaitingWidget();
        } else if (state is ProductEnrolledError) {
          return buildNoProductsView();
        } else if (state is ProductsEnrolledLoaded) {
          final products = state.products;
          return products.isEmpty
              ? buildNoProductsView()
              : RefreshIndicator(
                  onRefresh: () async {
                    final cubit = context.read<UserProductsCubit>();
                    cubit.resetEnrolledProducts();
                    await cubit.getEnrolledProducts();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductEnrolledItemWidget(
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
