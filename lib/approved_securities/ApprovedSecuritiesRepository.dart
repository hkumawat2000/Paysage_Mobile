import 'package:lms/approved_securities/ApprovedSecuritiesDao.dart';
import 'package:lms/network/requestbean/ApprovedSecuritiesRequestBean.dart';
import 'package:lms/network/responsebean/ApprovedSecurityResponseBean.dart';

class ApprovedSecuritiesRepository {
  final approvedSecuritiesDao = ApprovedSecuritiesDao();

  Future<ApprovedSecurityResponseBean> getApprovedSecurities(ApprovedSecuritiesRequestBean approvedSecuritiesRequestBean) =>
      approvedSecuritiesDao
          .getApprovedSecurities(approvedSecuritiesRequestBean);
}
