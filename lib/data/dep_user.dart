class DepUser {
  String USER_NAME;
  int USER_CODE;
  String ROLE_NAME;

  DepUser(this.USER_NAME, this.USER_CODE, this.ROLE_NAME);

  DepUser.formJson(Map<String, dynamic> json) {
    USER_CODE = json['USER_CODE'];
    USER_NAME = json['USER_NAME'];
    ROLE_NAME = json['ROLE_NAME'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = new Map();
    json['USER_CODE'] = USER_CODE;
    json['USER_NAME'] = USER_NAME;
    json['ROLE_NAME'] = ROLE_NAME;
    return json;
  }
}
