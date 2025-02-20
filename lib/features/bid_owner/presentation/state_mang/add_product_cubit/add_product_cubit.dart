import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/domain/entity/add_product_entity.dart';
import 'package:peakmart/features/bid_owner/domain/repository/owner_repo.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  OwnerRepo ownerRepo = instance<OwnerRepo>();

  AddProductCubit() : super(AddProductInitialState());
  late BuildContext context;
  Future<void> addProduct(
      {required AddProductRequest addProductRequest}) async {
    emit(
      AddProductLoadingState(),
    );

    Result<AppErrors, AddProductEntity> result = await ownerRepo.addProduct(
      AddProductRequest(
        photo: addProductRequest.photo,
        description: addProductRequest.description,
        location: addProductRequest.location,
        name: addProductRequest.name,
        startingPrice: addProductRequest.startingPrice,
        startDate: addProductRequest.startDate,
        deliveryDate: addProductRequest.deliveryDate,
        categoryId: addProductRequest.categoryId,
        periodOfBid: addProductRequest.periodOfBid,
        expectedPrice: addProductRequest.expectedPrice,
      ),
    );
    debugPrint('''In AddProduct Cubit photo: ${addProductRequest.photo},
        description: ${addProductRequest.description},
        location: ${addProductRequest.location},
        name: ${addProductRequest.name},
        startingPrice: ${addProductRequest.startingPrice},
        startDate:${addProductRequest.startDate},
        deliveryDate: ${addProductRequest.deliveryDate},
        categoryId: ${addProductRequest.categoryId},
        periodOfBid: ${addProductRequest.periodOfBid},
        expectedPrice: ${addProductRequest.expectedPrice}''');

    result.pick(onData: (data) {
      debugPrint(
        'data in add product cubit is $data',
      );
      Navigator.pop(context);
      emit(
        AddProductSuccessState(
            addProductEntity: AddProductEntity(
                productId: data.productId,
                description: data.description,
                location: data.location,
                startingPrice: data.startingPrice,
                categoryId: data.categoryId,
                expectedPrice: data.expectedPrice,
                periodOfBid: data.periodOfBid,
                deliveryDate: data.deliveryDate,
                startDate: data.startDate,
                productName: data.productName,
                photoUrl: data.photoUrl)),
      );
    }, onError: (error) {
      log(
        error.toString(),
      );
      Navigator.pop(context);
      emit(
        AddProductFailureState(
          errors: error,
          onRetry: () {},
        ),
      );
    });
  }
}
