class LoginReqModel {
  final String fcmToken;
  final String macId;
  final String name;
  final String password;
  final String secretCode;

  LoginReqModel({
    required this.fcmToken,
    required this.macId,
    required this.name,
    required this.password,
    required this.secretCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'fcmToken': fcmToken,
      'macId': macId,
      'name': name,
      'password': password,
      'secretCode': secretCode,
    };
  }
}
