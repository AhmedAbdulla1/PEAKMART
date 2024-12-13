import 'dart:developer';

import 'package:peakmart/core/net/create_model_interceptor/create_model.interceptor.dart';

class DefaultCreateModelInterceptor extends CreateModelInterceptor {
  const DefaultCreateModelInterceptor();
  @override
  T getModel<T>(dynamic Function(dynamic) modelCreator, dynamic json) {
    log('on create model interceptor');
    return modelCreator(json);
  }
}
