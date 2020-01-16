import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'constants.dart';
import 'zoom_analog_clock.dart';

/// This is the main entrance of the clock, injecting the [ClockModel] to take benefit of it.
/// The app consists in loading the [ZoomAnalogClock] which takes care of launching a [Timer]
/// to get the current time. While doing that, it updates the UI by rendering the [ZoomAnalogClockWidget].
void main() {
  runApp(ClockCustomizer((ClockModel model) => ZoomAnalogClock()));
}

class ZoomAnalogClock extends StatefulWidget {
  ZoomAnalogClock({Key key}) : super(key: key);

  @override
  _ZoomAnalogClockState createState() => _ZoomAnalogClockState();
}

class _ZoomAnalogClockState extends State<ZoomAnalogClock> {
  var _now = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// The clock has two themes : dark and light, that animate when changing
  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      duration: Duration(seconds: 1),
      data: Theme.of(context).brightness == Brightness.dark ? Constants.darkTheme : Constants.lightTheme,
      child: ZoomAnalogClockWidget(
        currentTime: _now,
      ),
    );
  }

  /// The hour is updated every half a second, so we make sure it is always on time.
  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(milliseconds: 500),
        _updateTime,
      );
    });
  }
}
