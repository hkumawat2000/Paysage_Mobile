// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/login/domain/entity/errors_entity.dart';

class Errors {
  String? mobile;
  String? firebaseToken;
  String? otp;
  String? firstName;
  String? pin;
  String? message;

  Errors({this.mobile,this.firebaseToken,this.otp,this.firstName,this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    firebaseToken = json['firebase_token'];
    otp = json['otp'];
    firstName = json['first_name'];
    pin = json['pin'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['firebase_token'] = this.firebaseToken;
    data['otp'] = this.otp;
    data['first_name'] = this.firstName;
    data['pin'] = this.pin;
    data['message'] = this.message;
    return data;
  }

  ErrorsEntity toEntity() =>
  ErrorsEntity(
      mobile: mobile,
      firebaseToken: firebaseToken,
      otp: otp,
      firstName: firstName,
      pin: pin,
      message: message,
  
  );
}
