import 'package:flutter/material.dart';

class HomeGrayWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = new Paint()
      ..color = Color(0XFF2D3231)
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 2 / 3);
    path.lineTo(0, size.height * 5 / 6 - 30);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
