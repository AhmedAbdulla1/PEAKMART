part of '../error_widget.dart';

class CustomErrorScreenWidget extends StatefulWidget {
  final String message;
  final VoidCallback? callback;
  final bool? disableRetryButton;

  const CustomErrorScreenWidget({
    Key? key,
    required this.message,
    this.callback,
    this.disableRetryButton,
  }) : super(key: key);

  @override
  _CustomErrorScreenWidgetState createState() =>
      _CustomErrorScreenWidgetState();
}

class _CustomErrorScreenWidgetState extends State<CustomErrorScreenWidget>
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
      callback: widget.callback,
      context: context,
      disableRetryButton: widget.disableRetryButton ?? false,
      content: widget.message,
      icon: Icons.refresh,
      imageUrl: AppConstants.ERROR_INVALID,
      errorAnimation: ErrorAnimation(
        animUrl: AppConstants.ANIM_LOTTIE_ERROR,
        animationController: _controller,
      ),
    );
  }
}
