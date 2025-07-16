import 'package:Bid_Mart/core/models/base_model.dart';
import 'package:Bid_Mart/features/products/domain/entity/top_bidders_entity.dart';
import 'package:flutter/material.dart';

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
    debugPrint('json $json');
    return TopBiddersResponse(
        data: List<TopBiddersDataResponse>.from(json["data"]
            .map((bidder) => TopBiddersDataResponse.fromJson(bidder))),
        message: json["message"],
        status: json["status"],
        code: int.tryParse(json["status_code"].toString()) ?? 0,
        totalBidders: int.tryParse(json['total_bidders'].toString()) ?? 0,
        totalEnrolled: int.tryParse(json['total_enrolled'].toString()) ?? 0,
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

  final int productId;
  final double bidderId, bidAmount;
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
      bidderId: json['BIDDER_ID'] is double
          ? json['BIDDER_ID']
          : double.tryParse(json['BIDDER_ID'].toString()) ?? 0,
      bidAmount: json['BID_AMOUNT'] is double
          ? json['BID_AMOUNT']
          : double.tryParse(json['BID_AMOUNT'].toString())?.toDouble() ?? 0,
      productId: json['I_ID'] is int
          ? json['I_ID']
          : int.tryParse(json['I_ID'].toString()) ?? 0,
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
