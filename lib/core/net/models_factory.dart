import 'dart:developer';

import 'package:Bid_Mart/core/models/base_model.dart';
import 'package:Bid_Mart/core/net/create_model_interceptor/create_model.interceptor.dart';

/// Singleton class used to create models from JSON responses.
class ModelsFactory {
  static const _fromJsonKey = "FROM_JSON";
  static const _interceptorKey = "CREATE_MODEL_INTERCEPTOR";

  static final ModelsFactory _instance = ModelsFactory._();

  factory ModelsFactory() => _instance;

  ModelsFactory._();

  /// Map structure:
  /// {
  ///   "ModelName": {
  ///     "FROM_JSON": fromJson factory method,
  ///     "CREATE_MODEL_INTERCEPTOR": CreateModelInterceptor
  ///   }
  /// }
  final Map<String, dynamic> _modelsMap = {};

  /// Register a model into the factory.
  void registerModel(
    String modelName,
    dynamic Function(dynamic) modelCreator,
    String createModelInterceptorName,
    CreateModelInterceptor createModelInterceptor,
  ) {
    final Map<String, dynamic> modelInfo = {
      _fromJsonKey: modelCreator,
      _interceptorKey: createModelInterceptor,
    };

    _modelsMap[modelName] = modelInfo;
  }

  /// Generate a single model of type T.
  T createModel<T extends BaseResponse>(dynamic json) {
    log('Creating model: $T');

    final modelName = T.toString();
    final modelInfo = _modelsMap[modelName];

    if (modelInfo == null) {
      throw Exception("Model '$modelName' is not registered in ModelsFactory.");
    }

    final modelFromJson = modelInfo[_fromJsonKey];
    final interceptor = modelInfo[_interceptorKey];

    if (modelFromJson == null || interceptor == null) {
      throw Exception("Model '$modelName' is missing required mappings.");
    }

    final model = interceptor.getModel(modelFromJson, json);
    return model;
  }

  /// Generate a list of models of type T.
  List<T?> createModelsList<T extends BaseResponse>(dynamic json) {
    if (json is! List) {
      throw Exception(
          "Expected a List for model list creation, got: ${json.runtimeType}");
    }

    return json.map<T?>((item) {
      return item == null ? null : createModel<T>(item);
    }).toList();
  }
}
