import 'package:choice/approved_securities/ApprovedSecuritiesDao.dart';
import 'package:choice/network/requestbean/ApprovedSecuritiesRequestBean.dart';
import 'package:choice/network/responsebean/ApprovedSecurityResponseBean.dart';

class ApprovedSecuritiesRepository {
  final approvedSecuritiesDao = ApprovedSecuritiesDao();

  Future<ApprovedSecurityResponseBean> getApprovedSecurities(ApprovedSecuritiesRequestBean approvedSecuritiesRequestBean) =>
      approvedSecuritiesDao
          .getApprovedSecurities(approvedSecuritiesRequestBean);
}
