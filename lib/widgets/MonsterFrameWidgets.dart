import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models.dart';
import '../painters.dart';
import 'colors.dart';

class MonsterFrame extends StatelessWidget {
  final MonsterDrawing drawing;
  final borderWidth = 5.0;
  final monsterName;

  const MonsterFrame({Key key, this.monsterName = 'Monster Name', @required this.drawing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final frameWidth = min(200.0, MediaQuery.of(context).size.width * 0.7);
    final frameHeight = frameWidth * 1.5;

    return Container(
      height: frameHeight + 7.5 * borderWidth + 28,
      color: Colors.black,
      child: Container(
        margin: EdgeInsets.all(borderWidth),
        color: const Color(0xFF764700),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: borderWidth * 1.5,
                right: borderWidth * 1.5,
                top: borderWidth * 1.5,
              ),
              color: Colors.black,
              child: Container(
                margin: EdgeInsets.all(borderWidth),
                color: paper,
                height: frameHeight,
                width: frameWidth,
                child: MonsterDrawingWidget(drawing: drawing),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: borderWidth,
                bottom: borderWidth,
              ),
              color: Colors.black,
              child: Container(
                margin: EdgeInsets.all(2),
                color: Colors.yellow,
                height: 24,
                width: frameWidth + borderWidth - 1,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        monsterName,
                        style: GoogleFonts.forum(
                          fontWeight: FontWeight.w500,
                          fontSize: 40,
                        ),
                      ),
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

class MonsterDrawingWidget extends StatelessWidget {
  final MonsterDrawing drawing;

  const MonsterDrawingWidget({Key key, @required this.drawing}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final frameWidth = min(200.0, MediaQuery.of(context).size.width * 0.7);
    final monsterPartHeight = frameWidth * (9 / 16);

    //drawing.top.height = frameHeight / 3;

    //debugPrint('topHeight: ${drawing.top.height} \ntopWidth: ${drawing.top.width}');
    //debugPrint('midHeight: ${drawing.middle.height} \nmidWidth: ${drawing.middle.width}');

    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(color: Colors.blue),
          child: CustomPaint(
            painter: MyPainter(
              drawing.top.getScaledPaths(
                outputHeight: monsterPartHeight,
              ),
              drawing.top.getScaledPaints(
                outputHeight: monsterPartHeight,
              ),
            ),
          ),
        ),
        Positioned(
          top: frameWidth * (9 / 16) * (5 / 6),
          child: CustomPaint(
            painter: MyPainter(
              drawing.middle.getScaledPaths(
                outputHeight: frameWidth * (9 / 16),
              ),
              drawing.middle.getScaledPaints(
                outputHeight: frameWidth * (9 / 16),
              ),
            ),
          ),
        ),
        Positioned(
          top: 2 * frameWidth * (9 / 16) * (5 / 6),
          child: CustomPaint(
            painter: MyPainter(
              drawing.bottom.getScaledPaths(
                outputHeight: frameWidth * (9 / 16),
              ),
              drawing.bottom.getScaledPaints(
                outputHeight: frameWidth * (9 / 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}