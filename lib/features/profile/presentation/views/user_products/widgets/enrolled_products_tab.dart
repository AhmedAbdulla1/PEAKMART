import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/home/presentation/views/home_view.dart';
import 'package:peakmart/features/profile/presentation/state_m/cart/user_products_cubit.dart';
import 'package:peakmart/features/profile/presentation/state_m/cart/user_products_states.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/no_products_founded_widget.dart';
import 'package:peakmart/features/profile/presentation/views/user_products/widgets/product_enrolled_item_widget.dart';

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
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<UserProductsCubit, UserProductsStates>(
      buildWhen: (previous, current) =>
          current is ProductsEnrolledLoading ||
          current is ProductsEnrolledLoaded ||
          current is UserProductsError,
      builder: (context, state) {
        if (state is ProductsEnrolledLoading) {
          return const WaitingWidget();
        }
        if (state is UserProductsError) {
          return ErrorViewer.showError(
            context: context,
            error: state.error,
            callback: () {
              context.read<UserProductsCubit>().getEnrolledProducts();
            },
          );
        }
        if (state is ProductsEnrolledLoaded) {
          final products = state.products;
          return products.isEmpty
              ?  NoProductsFoundedWidget(
                  title: 'No products enrolled yet.',
                  buttonText: 'Explore products',
                  onButtonPressed: () {
                    Navigator.pushNamed(context, HomeView.routeName);
                  },
                )
              :  ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductEnrolledItemWidget(
                product: products[index],
                index: index + 1,
              );
            },
          );
        }
        return const WaitingWidget();
      },
    );
  }
}
