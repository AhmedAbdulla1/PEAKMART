import 'package:peakmart/core/models/base_model.dart';
import 'package:peakmart/features/home/domain/entity/Trending_bids_entity.dart';

class TrendingBidsResponse extends BaseResponse<TrendingBidsEntity> {
  final List<TrendingDataResponse> data;

  TrendingBidsResponse(
      {required this.data,
      required super.message,
      required super.status,
      required super.code});

  factory TrendingBidsResponse.fromJson(Map<String, dynamic> json) {
    return TrendingBidsResponse(
      data: List<TrendingDataResponse>.from(json["data"]
          .map((trendingData) => TrendingDataResponse.fromJson(trendingData))),
      message: json["message"],
      status: json["status"],
      code: 200,
    );
  }

  @override
  TrendingBidsEntity toEntity() {
    return TrendingBidsEntity(
      data: data.map((trendingData) => trendingData.toEntity()).toList(),
    );
  }
}

class TrendingDataResponse {
  final String itemName, description, startDate, status;
  final String? itemImage;
  const TrendingDataResponse({
    this.itemImage,
    required this.itemName,
    required this.description,
    required this.startDate,
    required this.status,
  });

  factory TrendingDataResponse.fromJson(Map<String, dynamic> json) {
    return TrendingDataResponse(
        itemName: json["ITEM_NAME"],
        description: json["DESCRIPTION"],
        itemImage: json["PHOTO"],
        startDate: json["START_DATE"],
        status: json["STATUS"]);
  }

  TrendingBidsData toEntity() {
    return TrendingBidsData(
        itemName: itemName,
        description: description,
        itemImage: itemImage,
        startDate: startDate,
        status: status);
  }
}
