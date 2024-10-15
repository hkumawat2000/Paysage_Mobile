// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/contact_us/domain/entity/response/contactus_response_entity.dart';

class ContactUsResponseModel {
  String? message;

  ContactUsResponseModel({this.message});

  ContactUsResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }

  ContactUsResponseEntity toEntity() =>
  ContactUsResponseEntity(
      message: message,
  
  );
}
