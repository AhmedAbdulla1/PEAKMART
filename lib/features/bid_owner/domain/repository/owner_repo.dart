import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/domain/entity/add_product_entity.dart';

abstract class OwnerRepo {
  Future<Result<AppErrors, AddProductEntity>> addProduct(
      AddProductRequest addProductRequest);
}
