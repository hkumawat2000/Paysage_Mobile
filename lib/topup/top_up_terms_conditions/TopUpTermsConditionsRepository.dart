import 'package:lms/network/responsebean/TermsConditionResponse.dart';
import 'package:lms/topup/top_up_terms_conditions/TopUpTermsConditionsDao.dart';

class TopUpTermsConditionsRepository {
  final topUpTermsConditionsDao = TopUpTermsConditionsDao();

  Future<TermsConditionResponse> getTopUpTermsCondition(loanName, topupAmount) => topUpTermsConditionsDao.getTopUpTermsCondition(loanName, topupAmount);
}