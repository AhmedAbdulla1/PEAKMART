import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/features/home/domain/home_repo.dart';
import 'package:Bid_Mart/features/home/presentation/state_m/category_cubit/states.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final HomeRepository _homeRepository = instance<HomeRepository>();

  CategoryCubit() : super(CategoryInitial());

  void getCategory() async {
    log('getCategory');
    emit(CategoryLoading());
    final result = await _homeRepository.getCategory();
    result.pick(
      onData: (data) => emit(CategoryLoaded(data)),
      onError: (error) => emit(CategoryError(error)),
    );
  }
}
