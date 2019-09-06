
class Result{

  String msg;
  dynamic data;
  int code;

  Result(this.msg, this.data, this.code);

  Result.formJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = new Map();
    result['msg'] = msg;
    result['data'] = data;
    result['code'] = code;
    return result;
  }

}
