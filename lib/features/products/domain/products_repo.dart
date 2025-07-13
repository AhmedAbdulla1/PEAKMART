import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/products/data/models/request/bid_request.dart';
import 'package:Bid_Mart/features/products/data/models/request/enroll_request.dart';
import 'package:Bid_Mart/features/products/data/models/request/pagination_request.dart';
import 'package:Bid_Mart/features/products/domain/entity/in_wishlist_entity.dart';
import 'package:Bid_Mart/features/products/domain/entity/prodcuts_entity.dart';
import 'package:Bid_Mart/features/products/domain/entity/top_bidders_entity.dart';

abstract class ProductsRepo {
  Future<Result<AppErrors, ProductsEntity>> getProducts({
    required PaginationRequest getProductsPaginationRequest,
  });
  Future<Result<AppErrors, ProductsEntity>> getProductById(int productId);
  Future<Result<AppErrors, CheckWishlistEntity>> checkProductInWishList(int productId);
  Future<Result<AppErrors,EmptyEntity>>addToWishlist(int productId);
  Future<Result<AppErrors,EmptyEntity>>removeFromWishlist(int productId);
  Future<Result<AppErrors, ProductsEntity>> getProductsByCategory(
      int catId, PaginationRequest getProductsPaginationRequest);
  Future<Result<AppErrors, TopBiddersEntity>> getTopBidders(int productId);
  Future<Result<AppErrors,EmptyEntity>>enrollProduct(EnrollRequest enrollRequest);
  Future<Result<AppErrors,EmptyEntity>>bidProduct(BidRequest bidRequest);
}
