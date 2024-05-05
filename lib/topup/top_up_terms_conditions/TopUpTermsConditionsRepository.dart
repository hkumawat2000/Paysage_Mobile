import 'package:choice/network/responsebean/TermsConditionResponse.dart';
import 'package:choice/topup/top_up_terms_conditions/TopUpTermsConditionsDao.dart';

class TopUpTermsConditionsRepository {
  final topUpTermsConditionsDao = TopUpTermsConditionsDao();

  Future<TermsConditionResponse> getTopUpTermsCondition(loanName, topupAmount) => topUpTermsConditionsDao.getTopUpTermsCondition(loanName, topupAmount);
}