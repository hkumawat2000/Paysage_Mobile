import 'package:lms/aa_getx/modules/payment/domain/entities/request/loan_details_request_entity.dart';

class LoanDetailsRequestModel {
  String? loanName;

  LoanDetailsRequestModel({this.loanName});

  LoanDetailsRequestModel.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    return data;
  }

  factory LoanDetailsRequestModel.fromEntity(LoanDetailsRequestEntity loanDetailsRequestEntity) {
    return LoanDetailsRequestModel(
      loanName: loanDetailsRequestEntity.loanName != null ? loanDetailsRequestEntity.loanName as String : null,
    );
  }
}