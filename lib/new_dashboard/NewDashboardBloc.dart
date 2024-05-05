import 'dart:async';
import 'package:choice/network/responsebean/ForceUpdateResponse.dart';
import 'package:choice/network/responsebean/LoanSummaryResponseBean.dart';
import 'package:choice/network/responsebean/NewDashboardResponse.dart';
import 'package:choice/network/responsebean/WeeklyPledgedSecurityResponse.dart';

import 'NewDashboardRepository.dart';

class NewDashboardBloc {

  final newDashboardRepository = NewDashboardRepository();
  int? listCount;

  final _listAllWeeklyPledgedController = StreamController<List<WeeklyData>>.broadcast();
  get listAllWeeklyPledged => _listAllWeeklyPledgedController.stream;

  final _listLoanSummaryController = StreamController<LoanSummaryData>.broadcast();
  get listLoanSummary => _listLoanSummaryController.stream;

  Future<NewDashboardResponse> getDashboardData() async {
    NewDashboardResponse wrapper = await newDashboardRepository.getDashboardData();
    return wrapper;
  }

  Future<ForceUpdateResponse> forceUpdate() async {
    ForceUpdateResponse wrapper = await newDashboardRepository.forceUpdate();
    return wrapper;
  }

  Future<WeeklyPledgedSecurityResponse> getWeeklyPledgedData() async {
    WeeklyPledgedSecurityResponse? wrapper = await newDashboardRepository.getWeeklyPledgedData();
    if (wrapper.isSuccessFull!) {
      _listAllWeeklyPledgedController.sink.add(wrapper.weeklyData!);
    } else {}
    return wrapper;
  }

  Future<LoanSummaryResponseBean> getLoanSummaryData() async {
    LoanSummaryResponseBean wrapper = await newDashboardRepository.getLoanSummaryData();
    if (wrapper.isSuccessFull!) {
      _listLoanSummaryController.sink.add(wrapper.loanSummaryData!);
    } else {}
    return wrapper;
  }

  dispose() {
    _listAllWeeklyPledgedController.close();
    _listLoanSummaryController.close();
  }
}