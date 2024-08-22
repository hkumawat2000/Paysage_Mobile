
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/force_update_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/loan_summary_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/new_dashboard_response_entity.dart';

abstract class DasboardRepository {

ResultFuture<ForceUpdateResponseEntity> forceUpdate();

ResultFuture<NewDashboardResponseEntity> getDashboardData();

 ResultFuture<LoanSummaryResponseEntity> getLoanSummaryData();




}