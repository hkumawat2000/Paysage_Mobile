class RegistrationRequestBean {
  String firstName;
  String lastName;
  String phone;
  String email;
  String firebase_token;
  String app_version;
  String platform;

  RegistrationRequestBean(
      this.firstName, this.lastName, this.phone, this.email,this.firebase_token, this.app_version, this.platform);

  Map<String, dynamic> toJson() => {
    'first_name': this.firstName,
    'last_name': this.lastName,
    'mobile': this.phone,
    'email': this.email,
    'firebase_token': this.firebase_token,
    'app_version': this.app_version,
    'platform' : platform
  };
}
