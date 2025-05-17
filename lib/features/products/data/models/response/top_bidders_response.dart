import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/features/products/domain/entity/top_bidders_entity.dart';

class TopBiddersResponse extends BaseResponse<TopBiddersEntity> {
  final List<TopBiddersDataResponse> data;
  final int totalBidders, totalEnrolled;
  final bool userStatus;
  TopBiddersResponse(
      {required this.data,
      required super.message,
      required super.status,
      required super.code,
      required this.totalBidders,
      required this.totalEnrolled,
      required this.userStatus});

  factory TopBiddersResponse.fromJson(Map<String, dynamic> json) {
    print('json $json');
    return TopBiddersResponse(
        data: List<TopBiddersDataResponse>.from(json["data"]
            .map((bidder) => TopBiddersDataResponse.fromJson(bidder))),
        message: json["message"],
        status: json["status"],
        code: int.tryParse(json["status_code"])??0,
        totalBidders: int.tryParse(json['total_bidders'].toString())??0,
        totalEnrolled: int.tryParse(json['total_enrolled'].toString())??0,
        userStatus: json['user_status']);
  }

  @override
  TopBiddersEntity toEntity() {
    return TopBiddersEntity(
      data: data.map((bidderData) => bidderData.toEntity()).toList(),
      totalBidders: totalBidders,
      totalEnrolled: totalEnrolled,
      userStatus: userStatus,
    );
  }
}

@override
class TopBiddersDataResponse {
  final String userName, userPhoto;

  final int bidderId, bidAmount, productId;
  TopBiddersDataResponse(
      {required this.userName,
      required this.userPhoto,
      required this.bidderId,
      required this.bidAmount,
      required this.productId});

  factory TopBiddersDataResponse.fromJson(Map<String, dynamic> json) {
    return TopBiddersDataResponse(
      userName: json['USER_NAME'] ?? "",
      userPhoto: json['PHOTO'] ?? "",
      bidderId: int.tryParse(json['BIDDER_ID']) ?? 0,
      bidAmount: int.tryParse(json['BID_AMOUNT']) ?? 0,
      productId: int.tryParse(json['I_ID']) ?? 0,
    );
  }

  TopBiddersData toEntity() {
    return TopBiddersData(
      userName: userName,
      bidderId: bidderId,
      bidAmount: bidAmount,
      productId: productId,
      userPhoto: userPhoto,
    );
  }
}
