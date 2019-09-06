import 'dart:convert';

import 'package:operation/base/refresh_bloc.dart';
import 'package:operation/data/dep_user.dart';
import 'package:operation/http/http.dart';

class OrderRefreshBloc extends RefreshBloc {
  @override
  Future<void> requestData() async {
//    await Future.delayed(Duration(seconds: 2));
//    //数据处理
//    actionSink.add('Fire');
    await Http.get('api/PublicInterface/SelectDEPToUser', {'DEP_ID': 160}, this,
        this.toString());
  }

  @override
  void requestFail(String msg, int requestType) {
    actionSink.add(List());
  }

  @override
  void requestSuccess(data, String msg, int requestType) {
    if (data != null) {
      var _info = json.decode(data);
      actionSink
          .add((_info as List).map((item) => DepUser.formJson(item)).toList());
    } else
      actionSink.add(List());
  }
}
