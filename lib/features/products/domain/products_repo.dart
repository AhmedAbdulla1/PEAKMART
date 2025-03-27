import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';
import 'package:peakmart/features/products/domain/entity/prodcuts_entity.dart';

abstract class ProductsRepo  {

  Future<Result<AppErrors, ProductsEntity>> getProducts();

  Future<Result<AppErrors,ProductsEntity>> getProductsByCategory(int catId );
}