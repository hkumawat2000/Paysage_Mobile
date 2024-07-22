
class RegistrationRequestBeanEntity {
  String firstName;
  String lastName;
  String phone;
  String email;
  String firebase_token;
  String app_version;
  String platform;

  RegistrationRequestBeanEntity(this.firstName, this.lastName, this.phone,
      this.email, this.firebase_token, this.app_version, this.platform);
}