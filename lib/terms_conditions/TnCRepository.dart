import 'package:choice/network/requestbean/TermsConditionRequestBean.dart';
import 'package:choice/network/responsebean/TermsConditionResponse.dart';
import 'package:choice/network/responsebean/TncResponseBean.dart';
import 'package:choice/terms_conditions/TnCDao.dart';

class TnCRepository {
  final tncDao = TnCDao();

  Future<TnCResponseBean> getTnCList() => tncDao.getTnCList();
  Future<TermsConditionResponse> setTnCList(TermsConditionRequestBean termsConditionRequestBean) => tncDao.saveTnCList(termsConditionRequestBean);
}