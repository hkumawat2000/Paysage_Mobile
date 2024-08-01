import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';

class GetLoanDetailsRequestModel{
  String? loanName;
  int? transactionsPerPage;
  int? transactionsStart;
  //"transactions_per_page": 15,
  //         "transactions_start": 0

  GetLoanDetailsRequestModel(
      {this.loanName,this.transactionsPerPage, this.transactionsStart});

  GetLoanDetailsRequestModel.fromJson(Map<String, dynamic> json) {
    loanName = json['loanName'];
    transactionsPerPage = json['transactions_per_page'];
    transactionsStart = json['transactions_start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loanName'] = loanName;
    data['transactions_per_page'] = this.transactionsPerPage;
    data['transactions_start'] = this.transactionsStart;
    return data;
  }

  GetLoanDetailsRequestEntity toEntity() => GetLoanDetailsRequestEntity(
    loanName: loanName,
    transactionsPerPage: transactionsPerPage,
    transactionsStart: transactionsStart,
  );

  factory GetLoanDetailsRequestModel.fromEntity(
      GetLoanDetailsRequestEntity loanDetailsRequestEntity) {
    return GetLoanDetailsRequestModel(
      loanName: loanDetailsRequestEntity.loanName,
      transactionsStart: loanDetailsRequestEntity.transactionsStart,
      transactionsPerPage: loanDetailsRequestEntity.transactionsPerPage,
    );
  }

}