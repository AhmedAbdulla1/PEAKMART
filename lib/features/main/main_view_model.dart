import 'dart:async';

class MainViewModel extends MainViewModelInput {
  @override
  Sink get currentIndexInput => onTap.sink;

  StreamController<int> onTap = StreamController.broadcast();

  @override
  void onNavItemTapped(int index) {
    if (index >= 0 && index < 4) {
      currentIndexInput.add(index);
    }
  }

  @override
  Stream<int> get currentIndexOutput => onTap.stream;
}

abstract class MainViewModelInput extends MainViewModelOutput {
  Sink get currentIndexInput;

  onNavItemTapped(int index);
}

abstract class MainViewModelOutput {
  Stream<int> get currentIndexOutput;
}
