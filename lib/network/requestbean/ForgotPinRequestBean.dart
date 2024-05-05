class ForgotPinRequestBean {
  String? email;
  String? otp;
  String? newPin;
  String? retypePin;

  ForgotPinRequestBean({this.email, this.otp, this.newPin, this.retypePin});

  ForgotPinRequestBean.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
    newPin = json['new_pin'];
    retypePin = json['retype_pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['new_pin'] = this.newPin;
    data['retype_pin'] = this.retypePin;
    return data;
  }
}
