class LoginResModel {
  final String token;
  final UserData userData;
  final String roleName;
  final String userId;
  final String userName;
  final String orgName;
  final String orgId;
  final String loginName;
  final Map<String, UserRole> userRole;
  final String mobileNo;
  final bool checkValue;
  final String message;
  final int status;

  LoginResModel({
    required this.token,
    required this.userData,
    required this.roleName,
    required this.userId,
    required this.userName,
    required this.orgName,
    required this.orgId,
    required this.loginName,
    required this.userRole,
    required this.mobileNo,
    required this.checkValue,
    required this.message,
    required this.status,
  });

  factory LoginResModel.fromJson(Map<String, dynamic> json) {
    return LoginResModel(
      token: json['token'],
      userData: UserData.fromJson(json['userData']),
      roleName: json['rolename'],
      userId: json['userid'],
      userName: json['username'],
      orgName: json['orgname'],
      orgId: json['orgId'],
      loginName: json['loginname'],
      userRole: (json['userrole'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, UserRole.fromJson(value)),
      ),
      mobileNo: json['mobileno'],
      checkValue: json['checkvalue'],
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userData': userData.toJson(),
      'rolename': roleName,
      'userid': userId,
      'username': userName,
      'orgname': orgName,
      'orgId': orgId,
      'loginname': loginName,
      'userrole': userRole.map((key, value) => MapEntry(key, value.toJson())),
      'mobileno': mobileNo,
      'checkvalue': checkValue,
      'message': message,
      'status': status,
    };
  }
}

class UserData {
  final String username;
  final String userId;
  final String roleName;
  final String userRoleId;
  final String orgName;
  final String orgId;
  final String loginName;

  UserData({
    required this.username,
    required this.userId,
    required this.roleName,
    required this.userRoleId,
    required this.orgName,
    required this.orgId,
    required this.loginName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      username: json['username'],
      userId: json['userid'],
      roleName: json['rolename'],
      userRoleId: json['usrlId'],
      orgName: json['orgname'],
      orgId: json['orgId'],
      loginName: json['loginname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'userid': userId,
      'rolename': roleName,
      'usrlId': userRoleId,
      'orgname': orgName,
      'orgId': orgId,
      'loginname': loginName,
    };
  }
}

class UserRole {
  final String menuPath;
  final bool menuView;
  final bool menuAdd;
  final bool menuDelete;
  final bool menuEdit;
  final int menuLevel;
  final String menuName;
  final int userMenuId;
  final int userRoleId;

  UserRole({
    required this.menuPath,
    required this.menuView,
    required this.menuAdd,
    required this.menuDelete,
    required this.menuEdit,
    required this.menuLevel,
    required this.menuName,
    required this.userMenuId,
    required this.userRoleId,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      menuPath: json['menupath'],
      menuView: json['menuview'],
      menuAdd: json['menuadd'],
      menuDelete: json['menudelete'],
      menuEdit: json['menuedit'],
      menuLevel: json['menulevel'],
      menuName: json['menuname'],
      userMenuId: json['usmenu_id'],
      userRoleId: json['usrl_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menupath': menuPath,
      'menuview': menuView,
      'menuadd': menuAdd,
      'menudelete': menuDelete,
      'menuedit': menuEdit,
      'menulevel': menuLevel,
      'menuname': menuName,
      'usmenu_id': userMenuId,
      'usrl_id': userRoleId,
    };
  }
}
