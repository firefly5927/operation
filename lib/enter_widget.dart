import 'package:flutter/material.dart';
import 'package:operation/weiget_get.dart';

class EnterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EnterWidgetState();
  }
}

class _EnterWidgetState extends State<EnterWidget> {
  List<Img> _imgs;

  List<String> _imgPaths = ['+'];

  @override
  void initState() {
    super.initState();
    _imgs ??= [];
    _imgs.add(Img(
      tag: _imgPaths[0],
      itemClickListener: _picClickListener,
    ));
  }

  static int index = 0;

  void _picClickListener(String tag) {
    if (tag == '+') {
      _imgPaths.insert(_imgPaths.length - 1, (++index).toString());
    } else {
      _imgPaths.remove(tag);
    }
    _imgs.clear();
    setState(() {
      _imgs = _imgPaths.map((item) {
        return Img(
          tag: item,
          itemClickListener: _picClickListener,
        );
      }).toList();
    });
  }

  DateTime _lastPressedAt; //上次点击时间
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: WidgetGet.getAppBar('报修录入'),
        bottomNavigationBar: Container(
          color: Color(0XFFF5F6F6),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Center(
            child: Text(
              'confirm',
              style: TextStyle(color: Color(0XFF30BE9B)),
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HintWidget(
                hintText: '报修人',
              ),
              EnterContentWidget(
                hintText: '请输入保修人',
              ),
              HintWidget(
                hintText: '电话*',
              ),
              EnterContentWidget(
                hintText: '请输入电话',
              ),
              HintWidget(
                hintText: '所属部门',
              ),
              EnterContentWidget(
                hintText: '请选择',
              ),
              HintWidget(
                hintText: '所在区域',
              ),
              Row(
                verticalDirection: VerticalDirection.up,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: EnterContentWidget(
                      hintText: '请选择',
                      rightDis: 10,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color(0Xb2f0f4f3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'imgs/icon_location_blue.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              HintWidget(
                hintText: '具体位置*',
              ),
              EnterContentWidget(
                hintText: '请输入位置信息，不超过25字',
              ),
              HintWidget(
                hintText: '故障类别',
              ),
              EnterContentWidget(
                hintText: '请选择',
              ),
              HintWidget(
                hintText: '故障描述*',
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(30, 8, 20, 0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0Xb2f0f4f3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextField(
                      maxLines: 5,
                      maxLength: 150,
                      decoration: InputDecoration(
                        hintText: '请输入描述信息，不超过150字',
                        contentPadding: EdgeInsets.fromLTRB(8, 10, 8, 10),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          color: Color(0XFFCBCACA),
                          fontSize: 15,
                        ),
                      ),
                      style: TextStyle(
                        color: Color(0XFF333333),
                        fontSize: 15,
                      ),
                    ),
                  )),
              HintWidget(
                hintText: '报修图片',
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(30, 8, 20, 20),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _imgs,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class Img extends StatelessWidget {
  const Img({Key key, @required this.tag, @required this.itemClickListener})
      : super(key: key);

  final String tag;
  final ValueSetter<String> itemClickListener;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TargetPlatform platform = Theme.of(context).platform;
    double minWidth = platform==TargetPlatform.android?(size.width - 58 - 24) / 4:(size.width - 58 - 16) / 3;
    return GestureDetector(
      onTap: _click,
      child: Container(
        width: minWidth,
        height: minWidth,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              style: BorderStyle.solid,
              color: Color(0XFF46CBAA),
            ),
          ),
          child: Center(
            child: Text(
              tag,
              style: TextStyle(color: Color(0XFF46CBAA)),
              textAlign: TextAlign.center,
              textScaleFactor: tag == '+' ? 4 : 3,
            ),
          ),
        ),
      ),
    );
  }

  void _click() {
    if (itemClickListener != null) itemClickListener(tag);
  }
}

class EnterContentWidget extends StatelessWidget {
  EnterContentWidget({Key key, @required this.hintText, this.rightDis = 20})
      : super(key: key);

  double rightDis;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 8, rightDis, 0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0Xb2f0f4f3),
            borderRadius: BorderRadius.circular(4),
          ),
          child: TextField(
            maxLines: 1,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: EdgeInsets.fromLTRB(8, 10, 8, 10),
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Color(0XFFCBCACA),
                fontSize: 15,
              ),
            ),
            style: TextStyle(
              color: Color(0XFF333333),
              fontSize: 15,
            ),
          ),
        ));
  }
}

class HintWidget extends StatelessWidget {
  const HintWidget({Key key, @required this.hintText}) : super(key: key);

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'imgs/icon_ellipse.png',
            width: 10,
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              hintText,
              style: TextStyle(
                fontSize: 13,
                color: Color(0XFF666666),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
