// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/contact_us/domain/entity/request/contactus_request_entity.dart';

class ContactUsRequestModel {
  String? message;

  ContactUsRequestModel({this.message});

  ContactUsRequestModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }

  factory ContactUsRequestModel.fromEntity(ContactUsRequestEntity contactUsRequestEntity) {
    return ContactUsRequestModel(
      message: contactUsRequestEntity.message != null ? contactUsRequestEntity.message as String : null,
    );
  }
}
