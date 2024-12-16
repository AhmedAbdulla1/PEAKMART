part of '../error_widget.dart';

class TimeOutErrorScreenWidget extends StatefulWidget {
  final VoidCallback callback;
  final bool? disableRetryButton;

  const TimeOutErrorScreenWidget(
      {super.key, required this.callback, this.disableRetryButton});

  @override
  _TimeOutErrorScreenWidgetState createState() =>
      _TimeOutErrorScreenWidgetState();
}

class _TimeOutErrorScreenWidgetState extends State<TimeOutErrorScreenWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildErrorScreen(
      context: context,
      callback: widget.callback,
      disableRetryButton: widget.disableRetryButton ?? false,
      content: AppStrings.timeoutError,
      icon: Icons.refresh,
      imageUrl: AppConstants.ERROR_TIMEOUT,
      errorAnimation: ErrorAnimation(
        animUrl: AppConstants.ANIM_LOTTIE_ERROR_TIMEOUT,
        animationController: _controller,
      ),
    );
  }
}
