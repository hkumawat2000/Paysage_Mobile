import 'package:choice/network/responsebean/CreateContactResponse.dart';
import 'package:choice/network/responsebean/ForceUpdateResponse.dart';
import 'package:choice/network/responsebean/LoanSummaryResponseBean.dart';
import 'package:choice/new_dashboard/NewDashboardDao.dart';
import 'package:choice/network/responsebean/NewDashboardResponse.dart';
import 'package:choice/network/responsebean/WeeklyPledgedSecurityResponse.dart';

class NewDashboardRepository {
  final newDashboardDao = NewDashboardDao();

  Future<NewDashboardResponse> getDashboardData() => newDashboardDao.getDashboardData();

  Future<WeeklyPledgedSecurityResponse> getWeeklyPledgedData() => newDashboardDao.getWeeklyPledgedData();

  Future<ForceUpdateResponse> forceUpdate() => newDashboardDao.forceUpdate();

  Future<LoanSummaryResponseBean> getLoanSummaryData() => newDashboardDao.getLoanSummaryData();

}