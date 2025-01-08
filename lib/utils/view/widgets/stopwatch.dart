import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mimix_app/utils/view/widgets/texts/header_text.dart';

import '../app_palette.dart';

class StopwatchWidget extends StatefulWidget {
  final void Function(StopwatchWidgetController)? onControllerReady;

  StopwatchWidget({this.onControllerReady});

  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  Duration _elapsed = Duration.zero;
  Timer? _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    if (widget.onControllerReady != null) {
      widget.onControllerReady!(
        StopwatchWidgetController(
          start: _start,
          stop: _stop,
          reset: _reset,
          elapsed: _getElapsed,
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Start the stopwatch
  void _start() {
    if (_isRunning) return;
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsed += Duration(milliseconds: 10);
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  // Stop the stopwatch
  void _stop() {
    if (!_isRunning) return;
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  String _getElapsed(){
    return _formatTime(_elapsed);
  }

  // Reset the stopwatch
  void _reset() {
    _stop();
    setState(() {
      _elapsed = Duration.zero;
    });
  }

  // Format elapsed time in mm:ss
  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds % 60)}';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.access_time, size: 32, color: PaletteColor.darkBlue),
        SizedBox(width: 10),
        HeaderText(
          text: _formatTime(_elapsed),
          size: HeaderText.H4,
        ),
      ],
    );
  }
}

class StopwatchWidgetController {
  final void Function() start;
  final void Function() stop;
  final void Function() reset;
  final String Function() elapsed;

  StopwatchWidgetController({
    required this.start,
    required this.stop,
    required this.reset,
    required this.elapsed
  });
}
