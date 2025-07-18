import 'package:Bid_Mart/app/di.dart';
import 'package:Bid_Mart/features/home/domain/home_repo.dart';
import 'package:Bid_Mart/features/home/presentation/state_m/content_cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContentCubit extends Cubit<ContentState> {
  final HomeRepository _homeRepository = instance<HomeRepository>();

  ContentCubit() : super(ContentInitial());

  bool _hasFetched = false;

  void getContent() async {
    if (_hasFetched) return;

    _hasFetched = true;
    emit(ContentLoading());

    final result = await _homeRepository.getContent();
    result.pick(
      onData: (data) {
        emit(ContentLoaded(data));
      },
      onError: (error) {
        _hasFetched = false;
        emit(ContentError(error));
      },
    );
  }
}
