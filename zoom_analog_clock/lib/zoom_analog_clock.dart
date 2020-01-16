import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'constants.dart';

/// Renders the clock with respect to the [currentTime] passed in parameters.
/// This clock is a zoomed rendering of a 12 hours clock showing a single hand for both minutes and hours
///
/// As the zoom is centered on the dots, the hand seems to turn around the center of the screen.
/// The zoom and the effect is done by applying several rotation, translation and scale transforms to the
/// initial clock.
class ZoomAnalogClockWidget extends StatelessWidget {
  final DateTime currentTime;

  const ZoomAnalogClockWidget({Key key, this.currentTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Transform.scale(
          scale: Constants.ZOOM_SCALE,
          child: Transform.rotate(
            angle: _hourAngle(),
            child: Transform.translate(
              offset: Offset(0, Constants.GRAVITY_CENTER_OFFSET),
              child: Transform.rotate(
                angle: -_hourAngle(),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: _buildPoints(context) +
                      _buildNumbers(context) +
                      <Widget>[
                        Transform.rotate(
                          angle: _hourAngle() + radians(90),
                          child: Container(
                            color: Theme.of(context).accentColor,
                            height: 1,
                          ),
                        )
                      ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Computes the clock single hand's angle, taking into account the current time
  double _hourAngle() {
    return radians((currentTime.hour.toDouble() + currentTime.minute.toDouble() / 60.0 + currentTime.second.toDouble() / 3600.0) * 360.0 / 12.0);
  }

  /// Renders the digits of the clock
  List<Widget> _buildNumbers(BuildContext context) {
    var numbers = List<Widget>();
    for (var i = 0; i < Constants.HOURS; i++) {
      numbers.add(
        Transform.rotate(
          angle: radians(i.toDouble() * Constants.HOUR_ANGLE_IN_DEGREE),
          child: Transform.translate(
            offset: Offset(0, -(Constants.POINT_OFFSET + Constants.NUMBER_OFFSET)),
            child: Transform.rotate(
              angle: -radians(i.toDouble() * Constants.HOUR_ANGLE_IN_DEGREE),
              child: Text(
                "${i == 0 ? Constants.HOURS : i}",
                style: Theme.of(context).textTheme.display1.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return numbers;
  }

  /// Renders the dots around the clock
  List<Widget> _buildPoints(BuildContext context) {
    var points = List<Widget>();
    for (var i = 0; i < Constants.HOURS; i++) {
      points.add(
        Transform.rotate(
          angle: radians(i.toDouble() * Constants.HOUR_ANGLE_IN_DEGREE),
          child: Transform.translate(
            offset: Offset(0, -Constants.POINT_OFFSET),
            child: Container(
              width: Constants.BIG_BULLET_SIZE,
              height: Constants.BIG_BULLET_SIZE,
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      );
    }
    for (var i = 0; i < Constants.HOURS * Constants.QUARTERS; i++) {
      if (i % Constants.QUARTERS == 0) {
        continue;
      }
      points.add(
        Transform.rotate(
          angle: radians(i.toDouble() * Constants.HOUR_ANGLE_IN_DEGREE / Constants.QUARTERS),
          child: Transform.translate(
            offset: Offset(0, -Constants.POINT_OFFSET),
            child: Container(
              width: Constants.SMALL_BULLET_SIZE,
              height: Constants.SMALL_BULLET_SIZE,
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      );
    }
    return points;
  }
}