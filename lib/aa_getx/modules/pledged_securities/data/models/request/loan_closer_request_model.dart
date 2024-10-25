// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/request/loan_closer_request_entity.dart';

class LoanCloserRequestModel {
  String? loanNo;

  LoanCloserRequestModel({this.loanNo});

  LoanCloserRequestModel.fromJson(Map<String, dynamic> json) {
    loanNo = json['loan_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_no'] = this.loanNo;
    return data;
  }

  factory LoanCloserRequestModel.fromEntity(LoanCloserRequestEntity loanCloserRequestEntity) {
    return LoanCloserRequestModel(
      loanNo: loanCloserRequestEntity.loanNo != null ? loanCloserRequestEntity.loanNo as String : null,
    );
  }
}
