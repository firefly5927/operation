import 'dart:io';

import 'package:dio/dio.dart';
import 'package:operation/data/result.dart';

var dio = new Dio(new BaseOptions(
    baseUrl: "http://192.168.1.203:8080/API/",
    connectTimeout: 10000,
    receiveTimeout: 10000,
    contentType: ContentType.json,
    // Transform the response data to a String encoded with UTF8.
    // The default value is [ResponseType.JSON].
    responseType: ResponseType.json))
  ..interceptors.add(new LogInterceptor());

class Http {
  ///管理请求
  static Map<String, Map<String, CancelToken>> _cancelTokenMap = new Map();

  ///取消请求
  static disposeRequest(String tag) {
    Map<String, CancelToken> _map = _cancelTokenMap[tag];
    _map.forEach((tag, cancelToken) {
      cancelToken.cancel('canceled');
    });
  }

  static Future post(String api, Map<String, dynamic> data,
      RequestCallBack callBack, String tag) async {
    await postToRequestType(api, data, callBack, 0, tag);
  }

  static Future get(String api, Map<String, dynamic> data,
      RequestCallBack callBack, String tag) async {
    await getToRequestType(api, data, callBack, 0, tag);
  }

  ///检查请求信息
  static void checkRequest(String tag, String api) {
    if (_cancelTokenMap.containsKey(tag)) {
      Map<String, CancelToken> _map = _cancelTokenMap[tag];
      if (_map.containsKey(api)) {
        if (!_map[api].isCancelled) _map[api].cancel('canceled'); //取消请求
      }
      ///分析源码可知，cancel token如果被修改成了canceled，（因为_cancelError不再为空）那么在赋值给他，是不能去请求数据的。
      _map[api] = new CancelToken();
    } else {
      _cancelTokenMap[tag] = new Map();
      _cancelTokenMap[tag][api] = new CancelToken();
    }
  }

  static Future getToRequestType(String api, Map<String, dynamic> data,
      RequestCallBack callBack, int requestType, String tag) async {
    checkRequest(tag, api);
    try {
      Response<Map> response = await dio.get(
        api,
        queryParameters: data,
        cancelToken: _cancelTokenMap[tag][api],
      );
      dataConvert(response, callBack, requestType);
    } on DioError catch (e) {
      ///网络异常
      callBack.requestFail(e.message, requestType);
    }
  }

  static Future postToRequestType(String api, Map<String, dynamic> data,
      RequestCallBack callBack, int requestType, String tag) async {
    checkRequest(tag, api);
    try {
      Response<Map> response = await dio.post(
        api,
        data: data,
        cancelToken: _cancelTokenMap[tag][api],
      );
      dataConvert(response, callBack, requestType);
    } on DioError catch (e) {
      ///网络异常
      callBack.requestFail(e.message, requestType);
    }
  }

  static void dataConvert(
      Response<Map> response, RequestCallBack callBack, int requestType) {
    if (response.statusCode != 200) {
      callBack.requestFail(response.statusMessage, requestType);
      return;
    }

    var result = new Result.formJson(response.data);

    if (result == null) {
      callBack.requestFail('数据请求失败', requestType);
      return;
    }

    ///请求数据成功
    if (result.code == 1) {
//      var user = new User.formJson(json.decode(result.data));
      callBack.requestSuccess(result.data, result.msg, requestType);
    } else {
      callBack.requestFail(result.msg, requestType);
    }
  }
}

abstract class RequestCallBack {
  ///数据请求成功
  void requestSuccess(dynamic data, String msg, int requestType);

  ///数据获取失败
  void requestFail(String msg, int requestType);
}
