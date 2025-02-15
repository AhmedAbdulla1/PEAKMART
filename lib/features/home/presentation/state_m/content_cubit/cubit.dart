import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peakmart/app/di.dart';
import 'package:peakmart/features/home/domain/home_repo.dart';
import 'package:peakmart/features/home/presentation/state_m/content_cubit/state.dart';

class ContentCubit extends Cubit<ContentState> {
  final HomeRepository _homeRepository = instance<HomeRepository>();

  ContentCubit() : super(ContentInitial());

  void getContent() async {
    print('getContent');
    emit(ContentLoading());
    final result = await _homeRepository.getContent();
    result.pick(
      onData: (data) => emit(ContentLoaded(data)),
      onError: (error) => emit(ContentError(error)),
    );
  }
}
