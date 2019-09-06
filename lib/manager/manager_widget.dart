import 'package:flutter/material.dart';
import 'package:operation/weiget_get.dart';

class ManagerWidget extends StatefulWidget {
  final VoidCallback callback;

  const ManagerWidget({Key key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ManagerWidgetState();
  }

}

class _ManagerWidgetState extends State<ManagerWidget> {
  @override
  void initState() {
    super.initState();
    print('manager widget init');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetGet.operationBar('管理', widget.callback),
      body: Center(
        child: Text('Manager'),
      ),
    );
  }
}
