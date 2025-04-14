import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/entities/prodcut_entity.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/resources/theme/extentaions/app_theme_ext.dart';
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
  final ScrollController _scrollController = ScrollController();

  late ProductCubit productCubit;
  List<ProductEntity> filteredProducts = [];
  List<ProductEntity> allProducts = [];
  int? currentCategoryId;
  int page = 1;
  bool isLoadingMore = false;
  String searchQuery = '';
  bool hasErrorWhilePaginating = false;

  @override
  void initState() {
    productCubit = ProductCubit();
    currentCategoryId = widget.categoryId;
    super.initState();
    _scrollController.addListener(_scrollListener);

    if (widget.categoryId == null) {
      productCubit.fetchProducts(page: page);
    } else {
      productCubit.fetchProductsByCategory(widget.categoryId!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_scrollController.position.outOfRange &&
        !isLoadingMore &&
        !hasErrorWhilePaginating) {
      log("loading more products ...");
      isLoadingMore = true;
      page++;

      productCubit.fetchProducts(page: page).then((_) {
        isLoadingMore = false;
        hasErrorWhilePaginating = false;
      }).catchError((e) {
        isLoadingMore = false;
        hasErrorWhilePaginating = true;

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Failed to load more products, please try again"),
              backgroundColor: Colors.red,
            ),
          );
        }
        page--;
      });
    }
  }

  void onCategorySelected(int categoryId) {
    setState(() {
      currentCategoryId = categoryId;
      page = 1;
      allProducts.clear();
    });
    productCubit.fetchProductsByCategory(categoryId);
  }

  void onSearch(String query) {
    setState(() {
      searchQuery = query;
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
      page = 1;
      allProducts.clear();
      currentCategoryId = null;
    });
    await productCubit.fetchProducts(page: page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => productCubit,
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: context.isDarkMode
                  ? ColorManager.black
                  : ColorManager.grey.withValues(alpha: .5),

              shadowColor: context.isDarkMode
                  ? ColorManager.black
                  : ColorManager.grey.withValues(alpha: .5),
              // automaticallyImplyLeading: false,
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
                        selectedCategoryId: currentCategoryId,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BlocConsumer<ProductCubit, ProductState>(
                listener: (context, state) {
                  if (state is ProductLoaded) {
                    final newProducts = state.products.where((newItem) {
                      return !allProducts
                          .any((oldItem) => oldItem.id == newItem.id);
                    }).toList();

                    setState(() {
                      allProducts.addAll(newProducts);
                      filteredProducts = searchQuery.isEmpty
                          ? List.from(allProducts)
                          : allProducts
                              .where((product) => product.name
                                  .toLowerCase()
                                  .contains(searchQuery.toLowerCase()))
                              .toList();
                    });
                  } else if (state is ProductError && isLoadingMore) {
                    hasErrorWhilePaginating = true;
                    isLoadingMore = false;
                    page--;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                            "Failed to load more products, please try again"),
                        backgroundColor: ColorManager.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ProductLoading && allProducts.isEmpty) {
                    return const SizedBox(
                      height: 300,
                      child: Center(child: WaitingWidget()),
                    );
                  }

                  if (state is ProductError) {
                    return GetProductFailure(context, state);
                  }

                  if (filteredProducts.isEmpty) {
                    return const NoProductsWidget();
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p8,
                      vertical: AppPadding.p12,
                    ),
                    child: Column(
                      children: [
                        GetProductsGridView(filteredProducts: filteredProducts),
                        if (isLoadingMore)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox GetProductFailure(BuildContext context, ProductError state) {
    return SizedBox(
      height: 300,
      child: Center(
        child: ErrorViewer.showError(
          context: context,
          error: state.error,
          callback: () {
            context.read<ProductCubit>().fetchProducts(page: page);
          },
        ),
      ),
    );
  }
}

class NoProductsWidget extends StatelessWidget {
  const NoProductsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
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
}

class GetProductsGridView extends StatelessWidget {
  const GetProductsGridView({
    super.key,
    required this.filteredProducts,
  });

  final List<ProductEntity> filteredProducts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
