import 'package:flutter/material.dart';

class AnimWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimWidgetState();
  }
}

class _AnimWidgetState extends State<AnimWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _animation = new Tween(begin: 40.0, end: 80.0).animate(_animation);
    _controller.addStatusListener((states) {
      if (states == AnimationStatus.completed) {
        _controller.reverse();
      } else if (states == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BuilderWidget(
              animation: _animation,
              child: CircleAvatar(
                child: Text('A'),
                radius: _animation.value / 2.0,
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BuilderWidget extends StatelessWidget {
  const BuilderWidget({Key key, @required this.animation, @required this.child})
      : super(key: key);
  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (BuildContext context, Widget child) {
          return Container(
            width: animation.value,
            height: animation.value,
            child: child,
          );
        });
  }
}

class AnimCircleAvatar extends AnimatedWidget {
  AnimCircleAvatar({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return CircleAvatar(
      child: Text('A'),
      radius: animation.value / 2.0,
    );
  }
}
