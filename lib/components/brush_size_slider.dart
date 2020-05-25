import 'package:flutter/material.dart';

import 'colors.dart';

class BrushSizeSlider extends StatefulWidget {
  @override
  _BrushSizeSliderState createState() => _BrushSizeSliderState();
}

class _BrushSizeSliderState extends State<BrushSizeSlider> {
  double value = 10;
  bool showDot = false;
  bool transparentDot = true;
  bool timerOn = false;

  void _timerToHideDot(double valueWhenCalled) {
    Future.delayed(Duration(milliseconds: 800)).then((_) {
      if (value == valueWhenCalled) {
        setState(() {
          showDot = false;
        });
        Future.delayed(Duration(milliseconds: 95)).then((_) {
          if (value == valueWhenCalled) {
            setState(() {
              transparentDot = true;
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 150,
      child: RotatedBox(
        quarterTurns: 1,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            ClipPath(
              clipper: _CustomTriangleClipper(),
              child: Container(
                height: 20,
                width: 170,
                color: dashes,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedPadding(
                duration: Duration(milliseconds: 100),
                padding: EdgeInsets.only(bottom: showDot ? 100 : 0, right: 24 + ((value - 10) * 4.3)),
                child: Container(
                  height: value,
                  width: value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: transparentDot ? Colors.transparent : Colors.blue,
                  ),
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Container(
                  height: 20,
                  width: 164,
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 0,
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
                      thumbColor: Colors.black,
                    ),
                    child: Slider(
                      min: 10,
                      max: 40,
                      onChanged: (val) {
                        setState(() {
                          value = val;
                        });
                      },
                      value: value,
                      onChangeStart: (_) {
                        setState(() {
                          transparentDot = false;
                          timerOn = false;
                          showDot = true;
                        });
                      },
                      onChangeEnd: (value) {
                        timerOn = true;
                        _timerToHideDot(value);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}