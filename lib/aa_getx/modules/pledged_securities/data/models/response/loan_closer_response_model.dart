// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/response/loan_closer_response_entity.dart';

class LoanCloserResponseModel {
  String? message;

  LoanCloserResponseModel({this.message});

  LoanCloserResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }

  LoanCloserResponseEntity toEntity() =>
  LoanCloserResponseEntity(
      message: message,
  
  );
}
