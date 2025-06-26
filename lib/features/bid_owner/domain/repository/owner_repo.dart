import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/domain/entity/check_is_seller_entity.dart';
import 'package:peakmart/features/home/domain/entity/category_entity.dart';

abstract class OwnerRepo {
  Future<Result<AppErrors, EmptyEntity>> addProduct(
      AddProductRequest addProductRequest);
  Future<Result<AppErrors, CheckIsSellerEntity>> checkIsASeller();

  Future<Result<AppErrors, CategoriesEntity>> getCategories();
}
