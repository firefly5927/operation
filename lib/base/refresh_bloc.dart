import 'dart:async';

import 'package:operation/base/base_bloc.dart';
import 'package:operation/http/http.dart';

enum RefreshType {
  init, //列表初始化数据
  refresh, //列表刷新
  refreshSuccess, //列表刷新成功
  refreshFail, //列表刷新失败
  loadMore, //列表加载更多
  loadSuccess, //加载更多成功
  loadMoreFail, //加载更多失败
}

abstract class RefreshBloc implements BlocBase {
  //装列表数据
  List<dynamic> _dataS;

  //数据处理
  StreamController<List<dynamic>> _dataController =
      StreamController<List<dynamic>>();

  StreamSink<List<dynamic>> get _dataDealSink => _dataController.sink;

  Stream<List<dynamic>> get outStream => _dataController.stream;

  //业务处理
  StreamController _actionController = StreamController();

  StreamSink get actionSink => _actionController.sink;

  RefreshBloc() {
    print('${this.toString()}');
    _dataS ??= new List();
    _actionController.stream.listen(_loadData);
  }

  ///数据处理
  void _loadData(data) {
    _dataS = data;
    _dataDealSink.add(_dataS);
  }

  ///请求数据
  Future<void> requestData();

  @override
  void dispose() {
    Http.disposeRequest(this.toString());
    _actionController.close();
    _dataController.close();
  }
}
