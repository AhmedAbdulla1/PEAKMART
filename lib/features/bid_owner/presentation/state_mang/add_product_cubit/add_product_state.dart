part of 'add_product_cubit.dart';

sealed class AddProductState {}

final class AddProductInitialState extends AddProductState {}

final class AddProductLoadingState extends AddProductState {}

final class AddProductFailureState extends AddProductState {
  final AppErrors errors;
  final Function() onRetry;
  AddProductFailureState({required this.errors, required this.onRetry});
}

final class AddProductSuccessState extends AddProductState {
  final AddProductEntity addProductEntity;
  AddProductSuccessState({required this.addProductEntity});
}
