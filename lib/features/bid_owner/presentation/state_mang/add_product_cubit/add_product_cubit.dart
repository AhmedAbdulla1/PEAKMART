import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/app_prefs.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/core/entities/empty_entity.dart';
import 'package:peakmart/core/errors/app_errors.dart';
import 'package:peakmart/core/results/result.dart';
import 'package:peakmart/features/bid_owner/data/models/request/add_product_request.dart';
import 'package:peakmart/features/bid_owner/data/owner_repo_imp.dart';
import 'package:peakmart/features/bid_owner/domain/entity/check_is_seller_entity.dart';
import 'package:peakmart/features/bid_owner/domain/repository/owner_repo.dart';
import 'package:peakmart/features/home/domain/entity/category_entity.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  OwnerRepo ownerRepo = OwnerRepoImp();
  AppPreferences appPreferences = instance<AppPreferences>();
  bool isSeller = false;
  CategoriesEntity category = const CategoriesEntity(categories: []);
  AddProductCubit() : super(AddProductInitialState());

  // late BuildContext context;
  Future<void> addProduct(
      {required AddProductRequest addProductRequest}) async {
    // ShowDialog().showElasticDialog(context: context, builder: (context) => const WaitingWidget(), barrierDismissible: false);

    emit(
      AddProductLoadingState(),
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

    Result<AppErrors, EmptyEntity> result = await ownerRepo.addProduct(
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
        tabId: addProductRequest.tabId,
        amount: addProductRequest.amount,
      ),
    );
    debugPrint('result in add product cubit is $result');

    result.pick(onData: (data) {
      debugPrint(
        'data in add product cubit is $data',
      );
      // Navigator.pop(context);
      emit(
        AddProductSuccessState(),
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

  Future checkIsASeller() async {
    final cookie = appPreferences.getCookie("HKH");
    final phone = appPreferences.getCookie("PHONE");
    final hkhn = appPreferences.getCookie("HKHN");

    if (cookie != '') {
      emit(AddProductLoadingState());

      Result<AppErrors, CheckIsSellerEntity> result =
          await ownerRepo.checkIsASeller();

      result.pick(
        onData: (data) async {
          if (data.isSeller) {
            isSeller = true;
            await appPreferences.setIsSeller(true);
            log("User Status is Seller, isSeller:$isSeller");
            emit(ActivatedState(categoriesEntity: category));
          } else {
            isSeller = false;
            await appPreferences.setIsSeller(false); 
            log("User is not a seller anymore, isSeller:$isSeller");
            emit(NotActivatedState());
          }
        },
        onError: (error) {
          log("Error checking seller status: $error");
          emit(AddProductFailureState(errors: error, onRetry: checkIsASeller));
        },
      );
    } else if (phone != '') {
      emit(NotVerifiedState());
    } else if (hkhn != '') {
      emit(NotCompleteState());
    } else {
      emit(NotASellerState());
    }
  }

  Future getCategories() async {
    Result<AppErrors, CategoriesEntity> result =
        await ownerRepo.getCategories();
    result.pick(onData: (data) {
      category = data;
      log("Categories loaded: ${data.categories.length}");
    }, onError: (error) {
      emit(AddProductFailureState(errors: error, onRetry: () {}));
    });
  }
}
