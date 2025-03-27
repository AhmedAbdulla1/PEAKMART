import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/data/owner_repo_imp.dart';
import 'package:peakmart/features/bid_owner/domain/entity/add_product_entity.dart';
import 'package:peakmart/features/bid_owner/domain/repository/owner_repo.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  OwnerRepo ownerRepo = OwnerRepoImp();

  AddProductCubit() : super(AddProductInitialState());
  // late BuildContext context;
  Future<void> addProduct(
      {required AddProductRequest addProductRequest}) async {
    // ShowDialog().showElasticDialog(context: context, builder: (context) => const WaitingWidget(), barrierDismissible: false);

    emit(
      AddProductLoadingState(),
    );

    Result<AppErrors, AddProductEntity> result = await ownerRepo.addProduct(
      AddProductRequest(
        photos: addProductRequest.photos,
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
    debugPrint('''In AddProduct Cubit photo: ${addProductRequest.photos},
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
      // Navigator.pop(context);
      emit(
        AddProductSuccessState(
            addProductEntity: AddProductEntity(
          productId: data.productId,
          productPhotos: data.productPhotos,
        )),
      );
    }, onError: (error) {
      log(
        "in add product cubit error is $error",
      );
      // Navigator.pop(context);
      emit(
        AddProductFailureState(
          errors: error,
          onRetry: () {},
        ),
      );
    });
  }
}
