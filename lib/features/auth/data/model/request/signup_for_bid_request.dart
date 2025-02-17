import 'dart:developer';

import 'package:peakmart/core/requests/base_request.dart';


class RegisterAsSellerRequest extends BaseRequest {
  final String displayName;
  final String governmentName;
  final String cityName;
  final String address;
  final String country;


  RegisterAsSellerRequest(
      {required this.displayName, required this.governmentName, required this.cityName, required this.address, required this.country});

  @override
  void printRequest() {
    log("display name: $displayName, government name: $governmentName, city name: $cityName, address: $address, country: $country");
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "display_username": displayName,
      "government_name": governmentName,
      "city_name": cityName,
      "address": address,
      "country":country ,
    };
  }
}
