import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:operation/data/user.dart';
import 'package:operation/http/http.dart';
import 'package:operation/weiget_get.dart';

class InspectionWidget extends StatefulWidget {
  final VoidCallback callback;

  const InspectionWidget({Key key, this.callback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InspectionWidgetState();
  }
}

class _InspectionWidgetState extends State<InspectionWidget>
    implements RequestCallBack {
  @override
  void initState() {
    super.initState();
    print('inspection widget init');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetGet.operationBar('巡检', widget.callback),
      body: Center(
        child: RaisedButton(
          onPressed: _click,
          child: Text('click me'),
        ),
      ),
    );
  }

  _click() {
    Http.post(
        'api/Home/Login',
        {"USER_PHONE1": "18311111111", "USER_PSW": "123456"},
        this,
        this.widget.toString());
//    Http.post('api/RepairManagement/ANoHandlerWorkOrderSelect', new Map(), this, this.widget.toString());
  }

  @override
  void dispose() {
    Http.disposeRequest(this.widget.toString());
    super.dispose();
  }

  @override
  void requestFail(String msg, int requestType) {
    print('=======$msg');
  }

  @override
  void requestSuccess(data, String msg, int requestType) {
    var user = new User.formJson(json.decode(data));
    print(user.UserName);
  }
}
