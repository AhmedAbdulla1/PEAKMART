import 'dart:developer';

import 'package:Bid_Mart/core/requests/base_request.dart';

class CancelUserProductRequest extends BaseRequest {
  final int productId;
  final String password, status;

  CancelUserProductRequest(
      {required this.productId, required this.password, required this.status});

  @override
  void printRequest() {
    log("product Id: $productId, password: $password, status: $status");
  }

  @override
  Map<String, dynamic> toJson() {
    return {"I_ID": productId, "PASSWORD": password, "STATUS": status};
  }
}
