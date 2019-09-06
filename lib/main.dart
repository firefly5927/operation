import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:operation/anim.dart';
import 'package:operation/demo.dart';
import 'package:operation/home/home_widget.dart';
import 'package:operation/inspection/inspection_widget.dart';
import 'package:operation/manager/manager_widget.dart';
import 'package:operation/order/order_widget.dart';
import 'package:operation/util/screen_util.dart';
import 'package:operation/weiget_get.dart';

import 'custom_widget.dart';
import 'enter_widget.dart';
import 'touch_event.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
//      home: Jump(),
//      home: CounterPage(),
      home: MainApp(),
    );
//    return MaterialApp(
//      title: 'Bloc',
//      theme: new ThemeData(primarySwatch: Colors.blue),
//      home: BlocProvider<IncrementBloc>(
//        bloc:  IncrementBloc(),
//        child: CounterPageTwo(),
//      ),
//    );
  }
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainAppState();
  }
}

class _MainAppState extends State<MainApp> {
  int _index = 0;

  List<BottomNavigationBarItem> _items;
  List<Widget> _contents;

  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    _items ??= [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('首页'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.accessible_forward),
        title: Text('巡检'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.school),
        title: Text('工单'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        title: Text('管理'),
      ),
    ];
    _contents ??= [
      HomeWidget(
        callback: _openDrawer,
      ),
      InspectionWidget(
        callback: _openDrawer,
      ),
      OrderWidget(
        callback: _openDrawer,
      ),
      ManagerWidget(
        callback: _openDrawer,
      )
    ];
    ;
  }

  ///打开侧边栏
  void _openDrawer() {
    _globalKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: IndexedStack(
        index: _index,
        children: _contents,
      ),
      drawer: DrawerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = ScreenUtil.get(context);
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        child: Container(
          color: Colors.blue,
          child: Center(
            child: Text(
              'cocofire',
              style: TextStyle(color: Colors.white),
              textScaleFactor: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class Jump extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetGet.getAppBar('Demo'),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return EnterWidget();
                }));
              },
              color: Colors.pink,
              child: Text(
                'Enter',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return TouchEventWidget();
                }));
              },
              color: Colors.pink,
              child: Text(
                'Touch',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            FlatButton(
              onPressed: () {
//                Navigator.push(context,
//                    new CupertinoPageRoute(builder: (context) {
//                  return AnimWidget();
//                }));
//                Navigator.push(
//                  context,
//                  PageRouteBuilder(
//                    pageBuilder: (BuildContext context, Animation animation,
//                        Animation secondaryAnimation) {
//                      return new FadeTransition(
//                        opacity: animation,
//                        child: AnimWidget(),
//                      );
//                    },
//                    transitionDuration: Duration(milliseconds: 500),
//                  ),
//                );
                Navigator.push(context, FadeRoute(builder: (context) {
                  return AnimWidget();
                }));
              },
              color: Colors.pink,
              child: Text(
                'Anim',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return CustomWidget();
                }));
              },
              color: Colors.pink,
              child: Text(
                'Custome',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return GradientCircularProgressRoute();
                }));
              },
              color: Colors.pink,
              child: Text(
                'GradientCircular',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
          ],
        ),
      ),
    );
  }
}

class FadeRoute extends PageRoute {
  FadeRoute({
    @required this.builder,
  });

  final WidgetBuilder builder;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}
