import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/products/data/models/request/pagination_request.dart';
import 'package:peakmart/features/products/domain/entity/prodcuts_entity.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';

abstract class ProductsRepo {
  Future<Result<AppErrors, ProductsEntity>> getProducts({
    required PaginationRequest getProductsPaginationRequest,
  });
  Future<Result<AppErrors, ProductsEntity>> getProductById(int productId);
  Future<Result<AppErrors, ProductsEntity>> getProductsByCategory(
      int catId, PaginationRequest getProductsPaginationRequest);
  Future<Result<AppErrors, TopBiddersEntity>> getTopBidders(int productId);
}
