import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';

class MarginShortfallArguments{
  LoanDetailDataEntity? loanData;
  String? pledgorBoid;
  bool? isSellCollateral;
  bool? isSaleTriggered;
  bool? isRequestPending;
  String? msg;
  String? loanType;
  String? schemeType;
  MarginShortfallArguments({required this.loanData, required this.pledgorBoid, required this.isSellCollateral, required this.isSaleTriggered, required this.isRequestPending, required this.msg, required this.loanType, required this.schemeType});
}