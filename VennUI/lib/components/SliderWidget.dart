import 'package:VennUI/providers/SettingsProvider.dart';
import 'package:VennUI/utilies.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderWidget extends StatelessWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;
  final int value;
  final int index;

  SliderWidget({
    this.sliderHeight = 100,
    this.max = 10,
    this.min = 0,
    this.fullWidth = false,
    this.value = 0,
    this.index,
  });

  final Color baseColor = Color(0xff222f3e);

  String getValue() {
    return ((getRange() * computeSliderValue(value)) + min).round().toString();
  }

  double getRange() {
    return (max - min).toDouble();
  }

  int incrementValue() {
    if (value + 1 < max) {
      return value + 1;
    }
    return max;
  }

  int decrementValue() {
    if (value - 1 > min) {
      return value - 1;
    }
    return min;
  }

  double computeSliderValue(int value) {
    if (value > max) {
      return 1.0;
    }
    if (value < min) {
      return 0.0;
    }
    return (value - min).toDouble() / getRange();
  }

  int getValueInt(double sliderValue) {
    return ((sliderValue * getRange()) + min).toInt();
  }

  @override
  Widget build(BuildContext context) {
    double paddingFactor = .2;

    if (fullWidth) paddingFactor = .3;

    return Column(
      children: <Widget>[
        Container(
          width: 70,
          height: 30,
          decoration: new BoxDecoration(
            color: Colors.transparent,
          ),
          child: Center(
            child: Text(getValue(),
                style: TextStyle(
                  color: baseColor,
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: Container(
            width: sliderHeight,
            height: sliderHeight,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(
                Radius.circular(30),
              ),
              color: paleBlue.withOpacity(0.2),
            ),
            child: Icon(
              Icons.arrow_upward,
              size: 30,
              color: darkBlue,
            ),
          ),
          onTap: () => Provider.of<SettingsProvider>(context, listen: false)
              .setSetting(index, incrementValue()),
        ),
        RotatedBox(
          quarterTurns: 3,
          child: Container(
            width: fullWidth ? double.infinity : (sliderHeight) * 5,
            height: (sliderHeight),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(
                Radius.circular((sliderHeight * .3)),
              ),
              color: Colors.transparent,
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(sliderHeight * paddingFactor, 2,
                  sliderHeight * paddingFactor, 2),
              child: Row(
                children: <Widget>[
                  RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      '$min',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: sliderHeight * .4,
                        fontWeight: FontWeight.w600,
                        color: baseColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: sliderHeight * .1,
                  ),
                  Expanded(
                    child: Center(
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: baseColor.withOpacity(1),
                          inactiveTrackColor: baseColor.withOpacity(.5),

                          trackHeight: 3.0,
                          thumbShape: CustomSliderThumbRect(
                            thumbRadius: sliderHeight * .3,
                            thumbHeight: sliderHeight * .6,
                            min: min,
                            max: max,
                          ),
                          overlayColor: Color(0xff121212).withOpacity(.4),
                          //valueIndicatorColor: Colors.white,
                          activeTickMarkColor: Color(0xff121212),
                          inactiveTickMarkColor: Colors.red.withOpacity(.7),
                        ),
                        child: Slider(
                            value: computeSliderValue(value),
                            onChanged: (value) {
                              Provider.of<SettingsProvider>(context,
                                      listen: false)
                                  .setSetting(index, getValueInt(value));
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: sliderHeight * .1,
                  ),
                  RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      '$max',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: sliderHeight * .4,
                        fontWeight: FontWeight.w600,
                        color: baseColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Provider.of<SettingsProvider>(context, listen: false)
              .setSetting(index, decrementValue()),
          child: Container(
            width: sliderHeight,
            height: sliderHeight,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.all(
                Radius.circular(30),
              ),
              color: paleBlue.withOpacity(0.2),
            ),
            child: Icon(
              Icons.arrow_downward,
              size: 30,
              color: darkBlue,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomSliderThumbRect extends SliderComponentShape {
  final double thumbRadius;
  final thumbHeight;
  final int min;
  final int max;

  const CustomSliderThumbRect({
    this.thumbRadius,
    this.thumbHeight,
    this.min,
    this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final rRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
          center: center, height: thumbHeight * 1.2, width: thumbHeight * .6),
      Radius.circular(thumbRadius * .4),
    );

    final paint = Paint()
      ..color = baseColor //Thumb Background Color
      ..style = PaintingStyle.fill;

    TextSpan span = new TextSpan(
        style: new TextStyle(
            fontSize: thumbHeight * .3,
            fontWeight: FontWeight.w700,
            color: Color(0xff121212),
            height: 1),
        text: '');
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));
    canvas.drawRRect(rRect, paint);
    tp.paint(canvas, textCenter);
  }
}
