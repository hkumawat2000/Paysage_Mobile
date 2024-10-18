// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/additional_account_details/domain/entities/request/additional_account_details_request_entity.dart';

class AdditionalAccountdetailsRequestModel {
  String? email;

  AdditionalAccountdetailsRequestModel({this.email});

  AdditionalAccountdetailsRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }

  factory AdditionalAccountdetailsRequestModel.fromEntity(AdditionalAccountdetailsRequestEntity additionalAccountdetailsRequestEntity) {
    return AdditionalAccountdetailsRequestModel(
      email: additionalAccountdetailsRequestEntity.email != null ? additionalAccountdetailsRequestEntity.email as String : null,
    );
  }
}
