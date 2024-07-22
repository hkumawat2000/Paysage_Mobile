import 'package:lms/aa_getx/modules/registration/domain/entities/request/registration_request_bean_entity.dart';

class RegistrationRequestBeanModel {
  String firstName;
  String lastName;
  String phone;
  String email;
  String firebase_token;
  String app_version;
  String platform;

  RegistrationRequestBeanModel(
  {required this.firstName, required this.lastName, required this.phone, required this.email,required this.firebase_token, required this.app_version, required this.platform});

  Map<String, dynamic> toJson() => {
    'first_name': this.firstName,
    'last_name': this.lastName,
    'mobile': this.phone,
    'email': this.email,
    'firebase_token': this.firebase_token,
    'app_version': this.app_version,
    'platform' : platform
  };

  factory RegistrationRequestBeanModel.fromEntity(
      RegistrationRequestBeanEntity registrationRequestBeanEntity) {
    return RegistrationRequestBeanModel(
      firstName: registrationRequestBeanEntity.firstName,
      lastName: registrationRequestBeanEntity.lastName,
      phone: registrationRequestBeanEntity.phone,
      email: registrationRequestBeanEntity.email,
      firebase_token: registrationRequestBeanEntity.firebase_token,
      app_version: registrationRequestBeanEntity.app_version,
      platform: registrationRequestBeanEntity.platform,
    );
  }
}
