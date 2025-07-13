import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Bid_Mart/core/entities/prodcut_entity.dart';
import 'package:Bid_Mart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:Bid_Mart/core/resources/color_manager.dart';
import 'package:Bid_Mart/core/resources/font_manager.dart';
import 'package:Bid_Mart/core/resources/style_manager.dart';
import 'package:Bid_Mart/core/resources/theme/extentaions/app_theme_ext.dart';
import 'package:Bid_Mart/core/resources/values_manager.dart';
import 'package:Bid_Mart/features/home/presentation/state_m/category_cubit/category_cubit.dart';
import 'package:Bid_Mart/features/home/presentation/views/bid_section/widgets/custom_bid_item.dart';
import 'package:Bid_Mart/features/home/presentation/views/category_section/catrgory_view.dart';
import 'package:Bid_Mart/features/products/presentation/state_m/product_cubit/cubit.dart';
import 'package:Bid_Mart/features/products/presentation/state_m/product_cubit/state.dart';
import 'package:Bid_Mart/features/products/presentation/widgets/products_view_search_bar.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
  int productPaginationPage = 1;
  int categoryPaginationPage = 1;

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
      productCubit.fetchProducts(page: productPaginationPage);
    } else {
      productCubit.fetchProductsByCategory(
          catId: widget.categoryId!, page: categoryPaginationPage);
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
      if (currentCategoryId == null) {
        productPaginationPage++;
        productCubit.fetchProducts(page: productPaginationPage).then((_) {
          isLoadingMore = false;
          hasErrorWhilePaginating = false;
        }).catchError((e) {
          isLoadingMore = false;
          hasErrorWhilePaginating = true;
          productPaginationPage--;
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed to load more products, please try again"),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
      } else {
        categoryPaginationPage++;
        productCubit
            .fetchProductsByCategory(
          catId: currentCategoryId!,
          page: categoryPaginationPage,
        )
            .then((_) {
          isLoadingMore = false;
          hasErrorWhilePaginating = false;
        }).catchError((e) {
          isLoadingMore = false;
          hasErrorWhilePaginating = true;
          categoryPaginationPage--;
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Failed to load more products, please try again"),
                backgroundColor: Colors.red,
              ),
            );
          }
        });
      }
    }
  }

  void onCategorySelected(int categoryId) {
    setState(() {
      currentCategoryId = categoryId;
      productPaginationPage = 1;
      categoryPaginationPage = 1;
      allProducts.clear();
    });
    productCubit.fetchProductsByCategory(
        catId: categoryId, page: categoryPaginationPage);
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
      productPaginationPage = 1;
      categoryPaginationPage = 1;
      allProducts.clear();
      currentCategoryId = null;
    });
    await productCubit.fetchProducts(page: productPaginationPage);
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
                  : ColorManager.grey.withAlpha(128),
              shadowColor: context.isDarkMode
                  ? ColorManager.black
                  : ColorManager.grey.withAlpha(128),
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
                    if (currentCategoryId == null) {
                      productPaginationPage--;
                    } else {
                      categoryPaginationPage--;
                    }

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
                    return Skeletonizer(child: FakeProductsGridView());
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
            context
                .read<ProductCubit>()
                .fetchProducts(page: productPaginationPage);
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

class FakeProductsGridView extends StatelessWidget {
  FakeProductsGridView({
    super.key,
  });

  final List<ProductEntity> filteredProducts = List.generate(
      10,
      (index) => ProductEntity(
            id: index,
            name: 'Product $index',
            description: 'Description $index',
            imageUrl: const [],
            endDate: DateTime.now().toString(),
            peopleRolledIn: 0,
            price: 0,
            isEnded: false,
            startDate: "33", status: '',
            startingPrice: '0',
            expectedPrice: '0',
            periodOfBid: 0,
            catId: 0,
            userId: 0, createdAt: '',
  
            
          ));

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
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
