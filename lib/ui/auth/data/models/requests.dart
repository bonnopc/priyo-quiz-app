class SocialAuth {
  String? email;
  String? idToken;
  // String? loginType;
  String? errorMessage;
  String? deviceUuid;
  String? deviceToken;

  SocialAuth(
      {this.email,
      this.idToken,
      // this.loginType,
      this.errorMessage,
      this.deviceToken,
      this.deviceUuid});

  SocialAuth.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    idToken = json['idToken'];
    // loginType = json['loginType'];
    deviceUuid = json['deviceUuid'];
    deviceToken = json['deviceToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['idToken'] = this.idToken;
    // data['loginType'] = this.loginType;
    data['deviceUuid'] = this.deviceUuid;
    data['deviceToken'] = this.deviceToken;
    return data;
  }
}