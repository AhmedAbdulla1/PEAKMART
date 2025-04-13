import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/values_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/home/presentation/state_m/category_cubit/category_cubit.dart';
import 'package:peakmart/features/home/presentation/views/bid_section/widgets/custom_bid_item.dart';
import 'package:peakmart/features/home/presentation/views/category_section/catrgory_view.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/cubit.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/state.dart';
import 'package:peakmart/features/products/presentation/widgets/products_view_search_bar.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key, required this.categoryId});

  final int? categoryId;

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  late ProductCubit productCubit;
  List<ProductEntity> filteredProducts = [];
  List<ProductEntity> allProducts = [];
  int? currentCategoryId;

  @override
  void initState() {
    productCubit = ProductCubit();
    currentCategoryId = widget.categoryId;
    super.initState();
    if (widget.categoryId == null) {
      productCubit.fetchProducts();
    } else {
      productCubit.fetchProductsByCategory(widget.categoryId!);
    }
  }

  void onCategorySelected(int categoryId) {
    setState(() {
      currentCategoryId = categoryId;
    });
    productCubit.fetchProductsByCategory(categoryId);
  }

  void onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = List.from(allProducts);
      } else {
        filteredProducts = allProducts
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Future<void> onRefresh() async {
    setState(() {
      currentCategoryId = null;
    });
    await productCubit.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => productCubit,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          slivers: [
            // SliverAppBar for SearchBar and CategorySection
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: false,
              expandedHeight: 130.0.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    ProductsViewSearchBar(onSearch: onSearch),
                    SizedBox(height: 10.h),
                    BlocProvider(
                      create: (context) => CategoryCubit()..getCategory(),
                      child: CategorySection(
                        showTitle: false,
                        onCategorySelected: onCategorySelected,
                        selectedCategoryId:
                            currentCategoryId, // Pass the currentCategoryId
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Sliver for the Products Grid, Loading, or Empty State
            SliverToBoxAdapter(
              child: BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ProductLoaded) {
                    setState(() {
                      allProducts = state.products;
                      filteredProducts = List.from(allProducts);
                    });
                  }
                },
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const SizedBox(
                      height:
                          300, // Ensure enough height to allow pull-to-refresh
                      child: Center(child: WaitingWidget()),
                    );
                  }

                  if (state is ProductError) {
                    return SizedBox(
                      height:
                          300, // Ensure enough height to allow pull-to-refresh
                      child: Center(
                        child: ErrorViewer.showError(
                          context: context,
                          error: state.error,
                          callback: () {
                            context.read<ProductCubit>().fetchProducts();
                          },
                        ),
                      ),
                    );
                  }

                  if (state is ProductLoaded) {
                    if (filteredProducts.isEmpty) {
                      return SizedBox(
                        height:
                            300, // Ensure enough height to allow pull-to-refresh
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.hourglass_empty_outlined,
                                size: AppSize.s100,
                                color: ColorManager.greyColor,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "No products found!",
                                style: getBoldStyle(
                                  fontSize: FontSize.s28,
                                  color: ColorManager.greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p8,
                        vertical: AppPadding.p12,
                      ),
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: AppSize.s12,
                              mainAxisSpacing: AppSize.s12,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              return CustomBidItem(
                                bidItem: filteredProducts[index],
                              );
                            },
                          ),
                          // SizedBox(height: 55.h), // Padding for ConvexAppBar
                        ],
                      ),
                    );
                  }

                  return const SizedBox(
                    height:
                        300, // Ensure enough height to allow pull-to-refresh
                    child: Center(child: WaitingWidget()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
