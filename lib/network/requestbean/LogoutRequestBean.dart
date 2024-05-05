class LogoutRequestBean {
  String? firebaseToken;

  LogoutRequestBean({this.firebaseToken});

  LogoutRequestBean.fromJson(Map<String, dynamic> json) {
    firebaseToken = json['firebase_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firebase_token'] = this.firebaseToken;
    return data;
  }
}
