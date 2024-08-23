// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdateProfileAndPinRequestEntity {
  int? isForUpdatePin;
  int? isForProfilePic;
  String? oldPin;
  String? newPin;
  String? retypePin;
  String? image;
  
  UpdateProfileAndPinRequestEntity({
   required this.isForUpdatePin,
   required this.isForProfilePic,
   required this.oldPin,
   required this.newPin,
   required this.retypePin,
   required this.image,
  });
}
