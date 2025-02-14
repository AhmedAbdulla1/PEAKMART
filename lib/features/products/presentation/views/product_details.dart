import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:peakmart/features/products/presentation/views/products_view.dart';

class ProductDetails extends StatelessWidget {
  static const String routeName = '/product-details';
  final Product product ;
  const ProductDetails({super.key,required this.product}) ;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: Column(
        children: [
          Container(
            height: 250.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  product.endDate,
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
