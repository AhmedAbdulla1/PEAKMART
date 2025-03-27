import 'dart:developer';

import 'package:peakmart/core/entities/base_entity.dart';
import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/features/bid_owner/domain/entity/add_product_entity.dart';
import 'package:peakmart/features/bid_owner/domain/entity/check_is_seller_entity.dart';

class CheckIsSellerResponse extends BaseResponse<BaseEntity> {
  final bool adminActivation;

  CheckIsSellerResponse({
    required super.status,
    required super.message,
    required this.adminActivation,
    required super.code,
  });

  factory CheckIsSellerResponse.fromJson(Map<String, dynamic> json) {
    return CheckIsSellerResponse(
        status: json['status'] ?? "",
        message: json['message'] ?? "any",
        code: json['status_code'] ?? 200,
        adminActivation: json['admin_activation'] ?? false);
  }

  @override
  CheckIsSellerEntity toEntity() {
    return CheckIsSellerEntity(
      isSeller: adminActivation,
    );
  }
}
