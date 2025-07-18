import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EnterListener extends StatefulWidget {
  final Widget child;
  final VoidCallback onEnter;

  const EnterListener({
    super.key,
    required this.child,
    required this.onEnter,
  });

  @override
  State<EnterListener> createState() => _EnterListenerState();
}

class _EnterListenerState extends State<EnterListener> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Ensure focus is on this widget to listen to keyboard input
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (KeyEvent event) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          widget.onEnter();
        }
      },
      child: widget.child,
    );
  }
}
