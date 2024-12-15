import 'dart:async';

class AnimationViewModel {
  final _positionController = StreamController<double>.broadcast();
  final _isExpandedController = StreamController<bool>.broadcast();
  final _isStartTextController = StreamController<bool>.broadcast();
  Stream<double> get positionStream => _positionController.stream;
  Stream<bool> get isStartTextStream => _isStartTextController.stream;
  Stream<bool> get isExpandedStream => _isExpandedController.stream;

  double _currentPosition = 0;
  bool _isExpanded = false;
  bool _hasNewsBadgeShown = false;

  void startInAnimation(double screenWidth) {
    _currentPosition = screenWidth;
    _positionController.add(_currentPosition);
  }

  void startExpandAnimation() {
    if (!_hasNewsBadgeShown) {
      _isExpanded = true;
      _hasNewsBadgeShown = true; // Prevent re-showing the news badge
      _isExpandedController.add(_isExpanded);
    }
  }
  void startTextAnimation() {
    print('start text animation');
    _isStartTextController.add(true);
  }

  void startCollapseAnimation(double screenWidth) {
    _isExpanded = false;
    _isExpandedController.add(_isExpanded);

    Future.delayed(const Duration(seconds: 1), () {
      _currentPosition = 2 * screenWidth; // Feed out the blue container
      _positionController.add(_currentPosition);
    });
  }

  void dispose() {
    _positionController.close();
    _isExpandedController.close();
    _isStartTextController.close();
  }
}
