import 'package:flutter/material.dart';
import 'package:operation/util/screen_util.dart';
import 'package:operation/weiget_get.dart';
import 'package:operation/widget/chart_widget.dart';
import 'package:operation/widget/gradient_circular_progress.dart';
import 'package:operation/widget/home_bg.dart';

class HomeWidget extends StatefulWidget {
  final VoidCallback callback;

  const HomeWidget({Key key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeWidgetState();
  }

}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
    print('home widget init');
  }

  @override
  Widget build(BuildContext context) {
    Size size = ScreenUtil.get(context);
    double statusBarHeight = ScreenUtil.getStatusBarHeight(context);
    return Scaffold(
//      appBar: WidgetGet.operationBar('首页', widget.callback),
      body: SafeArea(
          top: false,
          child: Stack(children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: HomeGrayWidget(),
              ),
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: statusBarHeight,
                  ),
                  WidgetGet.titleBar(size, '首页', widget.callback),
                  Container(
                    width: size.width,
                    height: 40,
                  ),
                  Expanded(
                    flex: 1,
                    child: DecoratedBox(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        ViewWidget(
                          width: size.width / 2 - 15 - 10,
                          height: 106,
                          colors: [Colors.red, Colors.orange],
                          radius: 33,
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
                          height: 106,
                          colors: [Colors.blue, Colors.cyan],
                          radius: 33,
                          value: 0.3,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 70,
                  ),
                ],
              ),
            ),
          ])),
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
            )
          ],
        ),
        child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4),
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
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            )),
      ),
    );
  }
}
