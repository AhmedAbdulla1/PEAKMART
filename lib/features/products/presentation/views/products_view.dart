import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/core/error_ui/error_viewer/error_viewer.dart';
import 'package:peakmart/core/resources/color_manager.dart';
import 'package:peakmart/core/resources/extentions.dart';
import 'package:peakmart/core/resources/font_manager.dart';
import 'package:peakmart/core/resources/style_manager.dart';
import 'package:peakmart/core/widgets/waiting_widget.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/cubit.dart';
import 'package:peakmart/features/products/presentation/state_m/product_cubit/state.dart';
import 'package:peakmart/features/products/presentation/views/product_details.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({super.key});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => ProductCubit()..fetchProducts(),
        child:
            BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
          if (state is ProductLoading) {
            return const WaitingWidget();
          }
          if (state is ProductError) {
            return ErrorViewer.showError(
                context: context, error: state.error, callback: () {});
          }
          if (state is ProductLoaded) {
            List<Product> products = state.products;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ItemWidget(product: product, index: index);
              },
            );
          }
          return const WaitingWidget();
        }),
      ),
    );
  }
}

// Model
class Product {
  final int id;
  final String name;
  final String imageUrl;
  final String endDate;
  final int peopleRolledIn;
  final double price;
  final bool isEnded;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.endDate,
    required this.peopleRolledIn,
    required this.price,
    required this.isEnded,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      endDate: json['endDate'],
      peopleRolledIn: json['peopleRolledIn'],
      price: json['price'].toDouble(),
      isEnded: json['isEnded'],
    );
  }
}

// Cubit
class ItemWidget extends StatelessWidget {
  const ItemWidget({super.key, required this.product, required this.index});

  final int index;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // splashColor: ColorManager.white,
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: product);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Text(
              "${index.toString()}.",
              style: getBoldStyle(
                fontSize: FontSize.s20,
                color: ColorManager.primary,
              ),
            ),
            10.hGap,
            Image.asset(product.imageUrl, width: 50, height: 50),
            10.hGap,
            SizedBox(
              width: 250.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.black,
                    ),
                    maxLines: 1,
                    // softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Auction End Date: ${product.endDate}',
                    maxLines: 1,
                  ),
                  Text('*${product.peopleRolledIn} people rolled in'),
                  Visibility(
                    visible: !product.isEnded,
                    child: Text('\$${product.price}',
                        style: getBoldStyle(
                            fontSize: FontSize.s16,
                            color: ColorManager.primary)),
                  ),
                  product.isEnded
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              Text('\$${product.price}',
                                  style: getBoldStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.primary)),
                              Text('Ended',
                                  style: getBoldStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.primary)),
                            ])
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              SizedBox(
                                height: 35.h,
                                width: 100.w,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'End',
                                    style: getBoldStyle(
                                        fontSize: FontSize.s14,
                                        color: ColorManager.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35.h,
                                width: 100.w,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Cancel',
                                    style: getBoldStyle(
                                        fontSize: FontSize.s14,
                                        color: ColorManager.primary),
                                  ),
                                ),
                              ),
                            ]),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
