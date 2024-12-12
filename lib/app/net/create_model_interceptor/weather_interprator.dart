

import 'package:peakmart/app/net/create_model_interceptor/create_model.interceptor.dart';

class WeatherInterceptor extends CreateModelInterceptor {
  const WeatherInterceptor();
  @override
  T getModel<T>(dynamic Function(dynamic) modelCreator, dynamic json) {
    return modelCreator(json);
  }
}
