import 'package:lms/network/requestbean/TermsConditionRequestBean.dart';
import 'package:lms/network/responsebean/TermsConditionResponse.dart';
import 'package:lms/network/responsebean/TncResponseBean.dart';
import 'package:lms/terms_conditions/TnCDao.dart';

class TnCRepository {
  final tncDao = TnCDao();

  Future<TnCResponseBean> getTnCList() => tncDao.getTnCList();
  Future<TermsConditionResponse> setTnCList(TermsConditionRequestBean termsConditionRequestBean) => tncDao.saveTnCList(termsConditionRequestBean);
}