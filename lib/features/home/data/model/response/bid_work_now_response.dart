import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/core/responses/product_response.dart';
import 'package:peakmart/features/home/domain/entity/bid_work_now_entity.dart';

class BidWorkNowResponse extends BaseResponse<BidWorkNowEntity> {
  final List<ProductResponse> data;

  BidWorkNowResponse(
      {required this.data,
      required super.message,
      required super.status,
      required super.code});

  factory BidWorkNowResponse.fromJson(Map<String, dynamic> json) {
    return BidWorkNowResponse(
      data: List<ProductResponse>.from(json["data"].map(
          (bidWorkNowData) => ProductResponse.fromJson(bidWorkNowData))),
      message: json["message"],
      status: json["status"],
      code: 200,
    );
  }

  @override
  BidWorkNowEntity toEntity() {
    return BidWorkNowEntity(
      data: data.map((bidWorkNowData) => bidWorkNowData.toEntity()).toList(),
    );
  }
}

// class BidWorkNowDataResponse {
//   final String itemName, description, startDate, status;
// final String? itemImage;
//   const BidWorkNowDataResponse( {this.itemImage,
//     required this.itemName,
//     required this.description,
//     required this.startDate,
//     required this.status,
//   });
//
//   factory BidWorkNowDataResponse.fromJson(Map<String, dynamic> json) {
//     return BidWorkNowDataResponse(
//         itemName: json["ITEM_NAME"],
//         description: json["DESCRIPTION"],
//         itemImage: json["PHOTO"],
//         startDate: json["START_DATE"],
//         status: json["STATUS"]);
//   }
//
//    toEntity() {
//     return BidWorkNowData(
//         itemName: itemName,
//         description: description,
//         itemImage: itemImage,
//         startDate: startDate,
//         status: status);
//   }
// }
