
import 'package:flutter/material.dart';
import 'package:operation/util/date_util.dart';
import 'package:operation/widget/dash_path.dart';

class ChartWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
//    double eWidth = size.width / 15;
//    double eHeight = size.height / 15;
    //背景
    Paint paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0xff2d3231);
    RRect rRect =
    RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(10));
    canvas.drawRRect(rRect, paint);
//    canvas.drawRect(Offset.zero & size, paint);
    //虚线
    paint
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..color = Colors.white70
      ..strokeWidth = .5;

    double marginTop = 30.0;
    double marginBottom = 40.0;
    double marginLeft = 25.0;
    double marginRight = 30.0;
    double uHeight = (size.height - marginTop - marginBottom) / 5;
    for (int i = 0; i < 6; i++) {
      Path p = Path()
        ..moveTo(marginLeft, marginTop + uHeight * i)
        ..lineTo(size.width - marginRight, marginTop + uHeight * i);
      canvas.drawPath(
          dashPath(
            p,
            dashArray: CircularIntervalList<double>(
              <double>[2.0, 2.0, 2.0],
            ),
          ),
          paint);

      drawPercentData(i, marginRight, canvas, size, marginTop, uHeight);
    }
    //绘制完成量，工作量
    //画圆
    double distance = 10.0;
    Paint circlePaint = new Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    canvas.drawCircle(Offset(marginLeft - distance - 1.75, marginTop / 2.0),
        3.5, circlePaint);
    TextPainter(
        text: TextSpan(
            text: '完成量', style: TextStyle(fontSize: 10.0, color: Colors.white)),
        textDirection: TextDirection.ltr)
      ..textAlign = TextAlign.center
      ..layout(minWidth: 20.0, maxWidth: 50.0)
      ..paint(canvas, Offset(marginLeft, marginTop / 2.0 - 5.0));
    circlePaint.color = Colors.orange;
    canvas.drawCircle(
        Offset(marginLeft + 45, marginTop / 2.0), 3.5, circlePaint);
    TextPainter(
        text: TextSpan(
            text: '工作量', style: TextStyle(fontSize: 10.0, color: Colors.white)),
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 20.0, maxWidth: 50.0)
      ..paint(
          canvas, Offset(marginLeft + 45 + distance, marginTop / 2.0 - 5.0));

    //绘制日期
    List<String> dates = DateUtil.getWeekDate();
    double contentWidth = size.width - marginLeft - marginRight;
    double ucWidth = contentWidth / 6;
    double txtBottomPosition = size.height - marginBottom + 10;
    for (int i = 0; i < 7; i++) {
      drawDataText(dates[i], i, ucWidth, canvas, marginLeft, txtBottomPosition);
    }

    //画线段
    List<double> o1 = [20.0, 58.0, 40.0, 66.0, 30.0, 52.0, 97.0];
    List<double> o2 = [30.0, 38.0, 80.0, 76.0, 94.0, 23.0, 69.0];

    double contentHeight = size.height - marginTop - marginBottom;
    double unitWith = contentWidth / 6.0;
    //每一份占位多少
    double unitPercent = (contentHeight) / 100.0;
    Path p1 = new Path();
    Path p2 = new Path();
    for (int i = 0; i < 7; i++) {
      double x = marginLeft + unitWith * i;
      double y1 = marginTop + contentHeight - o1[i] * unitPercent;
      double y2 = marginTop + contentHeight - o2[i] * unitPercent;

      i == 0 ? p1.moveTo(x, y1) : p1.lineTo(x, y1);
      i == 0 ? p2.moveTo(x, y2) : p2.lineTo(x, y2);
    }
    paint = new Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1.5
      ..color = Colors.orange
      ..style = PaintingStyle.stroke;
    canvas.drawPath(p1, paint);
    paint..color = Colors.blue;
    canvas.drawPath(p2, paint);

    //画圆环
    Paint ringPaint = new Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    //画白圆
    circlePaint = new Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    for (int i = 0; i < 7; i++) {
      double x = marginLeft + unitWith * i;
      double y1 = marginTop + contentHeight - o1[i] * unitPercent;
      double y2 = marginTop + contentHeight - o2[i] * unitPercent;

      canvas.drawCircle(Offset(x, y1), 5, circlePaint);
      canvas.drawCircle(Offset(x, y2), 5, circlePaint);

      ringPaint.color = Colors.orange;
      canvas.drawCircle(Offset(x, y1), 3, ringPaint);
      ringPaint.color = Colors.blue;
      canvas.drawCircle(Offset(x, y2), 3, ringPaint);
    }
  }

  ///画百分比数字
  void drawPercentData(int i, double marginRight, Canvas canvas, Size size,
      double marginTop, double uHeight) {
    TextPainter(
        text: TextSpan(
            text: (100 - i * 20).toString(),
            style: TextStyle(fontSize: 9.0, color: Colors.white70)),
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 10.0, maxWidth: marginRight)
      ..paint(canvas,
          Offset(size.width - marginRight + 5, marginTop + uHeight * i - 5));
  }

  ///画日期
  void drawDataText(String data, int i, double ucWidth, Canvas canvas,
      double marginLeft, double txtBottomPosition) {
    TextPainter(
        text: TextSpan(
            text: data,
            style: TextStyle(
              fontSize: 9.0,
              color: i == 6 ? Color(0XFF30BE9B) : Colors.white70,
            )),
        textAlign: TextAlign.end,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 15, maxWidth: ucWidth)
      ..paint(
          canvas,
          Offset(
              i == 6
                  ? marginLeft + ucWidth * i - 15
                  : marginLeft + ucWidth * i - 8,
              txtBottomPosition));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}