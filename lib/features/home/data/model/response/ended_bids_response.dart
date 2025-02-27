import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/core/responses/product_response.dart';
import 'package:peakmart/features/home/domain/entity/ended_bids_entity.dart';

class EndedBidsResponse extends BaseResponse<EndedBidsEntity> {
  final List<ProductResponse> data;

  EndedBidsResponse(
      {required this.data,
      required super.message,
      required super.status,
      required super.code});

  factory EndedBidsResponse.fromJson(Map<String, dynamic> json) {
    return EndedBidsResponse(
      data: List<ProductResponse>.from(json["data"].map(
          (endedBidsData) => ProductResponse.fromJson(endedBidsData))),
      message: json["message"],
      status: json["status"],
      code: 200,
    );
  }

  @override
  EndedBidsEntity toEntity() {
    return EndedBidsEntity(
      data: data.map((endedBidsData) => endedBidsData.toEntity()).toList(),
    );
  }
}

// class EndedBidsDataResponse {
//   final String itemName, description, startDate, status;
//   final String? itemImage;
//   const EndedBidsDataResponse({
//     required this.itemName,
//     required this.description,
//     this.itemImage,
//     required this.startDate,
//     required this.status,
//   });
//
//   factory EndedBidsDataResponse.fromJson(Map<String, dynamic> json) {
//     return EndedBidsDataResponse(
//         itemName: json["ITEM_NAME"],
//         description: json["DESCRIPTION"],
//         itemImage: json["PHOTO"],
//         startDate: json["START_DATE"],
//         status: json["STATUS"]);
//   }
//
//   EndedBidsData toEntity() {
//     return EndedBidsData(
//         itemName: itemName,
//         description: description,
//         itemImage: itemImage,
//         startDate: startDate,
//         status: status);
//   }
// }
