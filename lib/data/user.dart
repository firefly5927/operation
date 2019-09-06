
class User {
  String Token;
  String UserName;
  String RoleName;
  String DepName;
  String USER_IMG_APP;
  int UserID;
  int RoleID;
  int DepID;
  List<RoleInfo> RoleApp;

  User(this.Token, this.UserName, this.RoleName, this.DepName,
      this.USER_IMG_APP, this.UserID, this.RoleID, this.DepID, this.RoleApp);

  User.formJson(Map<String, dynamic> json) {
    Token = json['Token'];
    UserName = json['UserName'];
    RoleName = json['RoleName'];
    DepName = json['DepName'];
    USER_IMG_APP = json['USER_IMG_APP'];
    UserID = json['UserID'];
    RoleID = json['RoleID'];
    DepID = json['DepID'];
    if (json['RoleApp'] != null) {
      RoleApp = new List<RoleInfo>();
      (json['RoleApp'] as List)
          .forEach((item) => RoleApp.add(new RoleInfo.fromJson(item)));
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['Token'] = Token;
    data['UserName'] = UserName;
    data['RoleName'] = RoleName;
    data['DepName'] = DepName;
    data['USER_IMG_APP'] = USER_IMG_APP;
    data['UserID'] = UserID;
    data['RoleID'] = RoleID;
    data['DepID'] = DepID;
    data['RoleApp'] =
        RoleApp != null ? RoleApp.map((item) => item.toJson()).toList() : null;
    return data;
  }
}

class RoleInfo {
  final String Name;

  RoleInfo(this.Name);

  RoleInfo.fromJson(Map<String, dynamic> json) : Name = json['Name'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map();
    data['Name'] = Name;
    return data;
  }
}
