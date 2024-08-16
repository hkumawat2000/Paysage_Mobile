import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';

class MFIncreaseLoanArguments {
  String? loanName, comingFrom, loanType, schemeType;
  LoanDetailDataEntity? loanData;

  MFIncreaseLoanArguments(
      {required this.loanName,
        required this.comingFrom,
        required this.loanData,
        required this.loanType,
        required this.schemeType});
}