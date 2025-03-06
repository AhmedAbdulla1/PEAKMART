import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/resources/string_manager.dart';
import 'package:peakmart/features/home/presentation/state_m/random_products_cubit/random_products_cubit.dart';
import 'package:peakmart/features/home/presentation/state_m/random_products_cubit/random_products_states.dart';
import 'package:peakmart/features/products/presentation/widgets/product_item_widget.dart';

class RandomProductsViewBody extends StatelessWidget {
  const RandomProductsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RandomProductsCubit, RandomProductsState>(
      builder: (context, state) {
        if (state is RandomProductsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RandomProductsSuccessState) {
          List randomProducts = state.randomProducts;
          return ListView.builder(
            itemCount: state.randomProducts.length,
            itemBuilder: (context, index) {
              return ItemWidget(
                product: randomProducts[index],
                index: index,
                isUsingWithRandomProducts: true,
              );
            },
          );
        } else if (state is RandomProductsFailureState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.errors.toString()),
                ElevatedButton(
                  onPressed: state.onRetry,
                  child: const Text(AppStrings.retry),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
