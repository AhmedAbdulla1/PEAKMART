import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/main/main_view.dart';
import 'package:peakmart/features/profile/presentation/state_m/user_products/user_products_cubit.dart';
import 'package:peakmart/features/profile/presentation/state_m/user_products/user_products_states.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/no_products_founded_widget.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/product_uploaded_item_widget.dart';

class UploadedProductsTab extends StatefulWidget {
  const UploadedProductsTab({super.key});

  @override
  State<UploadedProductsTab> createState() => _UploadedProductsTabState();
}

class _UploadedProductsTabState extends State<UploadedProductsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<UserProductsCubit>().getUploadedProducts();
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
          current is ProductUploadedLoading ||
          current is UserProductsLoaded ||
          current is UserProductsError,
      builder: (context, state) {
        if (state is ProductUploadedLoading) {
          return const WaitingWidget();
        } else if (state is UserProductsError) {
          return buildNoProductsView();
        } else if (state is UserProductsLoaded) {
          final products = state.products;
          return products.isEmpty
              ? buildNoProductsView()
              : RefreshIndicator(
                  onRefresh: () async {
                    await context
                        .read<UserProductsCubit>()
                        .getUploadedProducts();
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductsUploadedItemWidget(
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
