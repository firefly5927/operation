import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:operation/widget/dash_path.dart';
import 'package:operation/util/date_util.dart';
import 'package:operation/util/screen_util.dart';

class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = ScreenUtil.get(context);
    return Scaffold(
      backgroundColor: Color(0XFF2D3231),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: CustomPaint(
                  size: Size(size.width - 30, 300),
                  painter: ChartWidget(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    ViewWidget(
                      width: size.width / 2 - 15 - 10,
                      height: 130,
                      colors: [Colors.red, Colors.orange],
                      radius: 40,
                      value: 0.6,
                      text: '待接收的工单',
                    ),
                    Container(
                      width: 20,
                      height: 1,
                    ),
                    ViewWidget(
                      text: '我未完成的工单',
                      width: size.width / 2 - 15 - 10,
                      height: 130,
                      colors: [Colors.blue, Colors.cyan],
                      radius: 40,
                      value: 0.3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewWidget extends StatelessWidget {
  ViewWidget(
      {@required this.width,
      @required this.height,
      @required this.radius,
      @required this.colors,
      @required this.text,
      this.value});

  /// 渐变色数组
  final List<Color> colors;
  final double radius;
  final double value;
  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0XFF2D3231),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 6,
            )
          ],
        ),
        child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      GradientCircularProgressIndicator(
                        colors: colors,
                        radius: radius,
                        stokeWidth: 8.0,
                        strokeCapRound: true,
                        value: value,
                      ),
                      Text(
                        '33',
                        style: TextStyle(color: colors[0], fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            )),
      ),
    );
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  GradientCircularProgressIndicator(
      {this.stokeWidth = 2.0,
      @required this.radius,
      @required this.colors,
      this.stops,
      this.strokeCapRound = false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.totalAngle = 2 * pi,
      this.value});

  ///粗细
  final double stokeWidth;

  /// 圆的半径
  final double radius;

  ///两端是否为圆角
  final bool strokeCapRound;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条背景色
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 渐变色数组
  final List<Color> colors;

  /// 渐变色的终止点，对应colors属性
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    // 如果两端为圆角，则需要对起始位置进行调整，否则圆角部分会偏离起始位置
    // 下面调整的角度的计算公式是通过数学几何知识得出，读者有兴趣可以研究一下为什么是这样
    if (strokeCapRound) {
      _offset = asin(stokeWidth / (radius * 2 - stokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
          size: Size.fromRadius(radius),
          painter: _GradientCircularProgressPainter(
            stokeWidth: stokeWidth,
            strokeCapRound: strokeCapRound,
            backgroundColor: backgroundColor,
            value: value,
            total: totalAngle,
            radius: radius,
            colors: _colors,
          )),
    );
  }
}

//实现画笔
class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter(
      {this.stokeWidth: 10.0,
      this.strokeCapRound: false,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.radius,
      this.total = 2 * pi,
      @required this.colors,
      this.stops,
      this.value});

  final double stokeWidth;
  final bool strokeCapRound;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double> stops;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius);
    }
    double _offset = stokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(stokeWidth / (size.width - stokeWidth));
    }

    Rect rect = Offset(_offset, _offset) &
        Size(size.width - stokeWidth, size.height - stokeWidth);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = stokeWidth;

    // 先画背景
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    // 再画前景，应用渐变
    if (_value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);

      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

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
