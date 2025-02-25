import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/features/home/domain/entity/content_entity.dart';
import 'package:peakmart/features/home/domain/home_repo.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/state.dart';

class ContentCubit extends Cubit<ContentState> {
  final HomeRepository _homeRepository = instance<HomeRepository>();

  ContentCubit() : super(ContentInitial());

  ContentEntity? _cachedContent;
  bool _hasFetched = false;

  void getContent() async {
    if (_hasFetched) return;

    _hasFetched = true;
    emit(ContentLoading());

    final result = await _homeRepository.getContent();
    result.pick(
      onData: (data) {
        _cachedContent = data;
        emit(ContentLoaded(data));
      },
      onError: (error) {
        _hasFetched = false;
        emit(ContentError(error));
      },
    );
  }
}
