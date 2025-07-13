import 'package:Bid_Mart/core/entities/empty_entity.dart';
import 'package:Bid_Mart/core/errors/app_errors.dart';
import 'package:Bid_Mart/core/results/result.dart';
import 'package:Bid_Mart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:Bid_Mart/features/bid_owner/domain/entity/check_is_seller_entity.dart';
import 'package:Bid_Mart/features/home/domain/entity/category_entity.dart';

abstract class OwnerRepo {
  Future<Result<AppErrors, EmptyEntity>> addProduct(
      AddProductRequest addProductRequest);
  Future<Result<AppErrors, CheckIsSellerEntity>> checkIsASeller();

  Future<Result<AppErrors, CategoriesEntity>> getCategories();
}
