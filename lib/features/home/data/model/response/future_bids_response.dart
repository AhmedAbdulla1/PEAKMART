import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/core/responses/product_response.dart';
import 'package:peakmart/features/home/domain/entity/future_bids_entity.dart';

class FutureBidsResponse extends BaseResponse<FutureBidsEntity> {
  final List<ProductResponse> data;

  FutureBidsResponse(
      {required this.data,
      required super.message,
      required super.status,
      required super.code});

  factory FutureBidsResponse.fromJson(Map<String, dynamic> json) {
    return FutureBidsResponse(
      data: List<ProductResponse>.from(json["data"]
          .map((futureData) => ProductResponse.fromJson(futureData))),
      message: json["message"],
      status: json["status"],
      code: 200,
    );
  }

  @override
  FutureBidsEntity toEntity() {
    return FutureBidsEntity(
      data: data.map((futureData) => futureData.toEntity()).toList(),
    );
  }
}

// class FutureDataResponse {
//   final String itemName, description, startDate, status;
//   final String? itemImage;
//   const FutureDataResponse({
//     this.itemImage,
//     required this.itemName,
//     required this.description,
//     required this.startDate,
//     required this.status,
//   });
//
//   factory FutureDataResponse.fromJson(Map<String, dynamic> json) {
//     return FutureDataResponse(
//         itemName: json["ITEM_NAME"],
//         description: json["DESCRIPTION"],
//         itemImage: json["PHOTO"],
//         startDate: json["START_DATE"],
//         status: json["STATUS"]);
//   }
//
//   FutureBidsData toEntity() {
//     return FutureBidsData(
//         itemName: itemName,
//         description: description,
//         itemImage: itemImage,
//         startDate: startDate,
//         status: status);
//   }
// }
