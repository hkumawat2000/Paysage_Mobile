import 'package:lms/network/responsebean/CreateContactResponse.dart';
import 'package:lms/network/responsebean/ForceUpdateResponse.dart';
import 'package:lms/network/responsebean/LoanSummaryResponseBean.dart';
import 'package:lms/new_dashboard/NewDashboardDao.dart';
import 'package:lms/network/responsebean/NewDashboardResponse.dart';
import 'package:lms/network/responsebean/WeeklyPledgedSecurityResponse.dart';

class NewDashboardRepository {
  final newDashboardDao = NewDashboardDao();

  Future<NewDashboardResponse> getDashboardData() => newDashboardDao.getDashboardData();

  Future<WeeklyPledgedSecurityResponse> getWeeklyPledgedData() => newDashboardDao.getWeeklyPledgedData();

  Future<ForceUpdateResponse> forceUpdate() => newDashboardDao.forceUpdate();

  Future<LoanSummaryResponseBean> getLoanSummaryData() => newDashboardDao.getLoanSummaryData();

}