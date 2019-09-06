import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class TouchEventWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TouchEventWidgetState();
  }
}

class _TouchEventWidgetState extends State<TouchEventWidget> {
  bool switchColor = false;

  TapGestureRecognizer _tapGen = new TapGestureRecognizer();

  @override
  void dispose() {
    _tapGen.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text.rich(TextSpan(
          children: [
            TextSpan(text: 'hello flutter '),
            TextSpan(
                text: 'click me switch color',
                style: TextStyle(
                    fontSize: 20,
                    color: switchColor ? Colors.red : Colors.blue),
                recognizer: _tapGen
                  ..onTap = () {
                    setState(() {
                      switchColor = !switchColor;
                    });
                  }),
            TextSpan(text: ' end .'),
          ],
        )),
      ),
    );
  }
}
