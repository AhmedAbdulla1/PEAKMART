import 'dart:developer';

import 'package:peakmart/core/requests/base_request.dart';

class NewsRequest extends BaseRequest {
  final int page;

  final int limit;

  NewsRequest({required this.page, required this.limit});

  @override
  void printRequest() {
    log(toJson().toString());
  }

  @override
  Map<String, dynamic> toJson() {
    return {'page': page, 'limit': limit};
  }
}
