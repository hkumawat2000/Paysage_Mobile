import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/get_profile_set_alert_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/my_loans_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/get_profile_set_alert_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';

abstract class MoreRepository{
  ResultFuture<MyLoansResponseEntity> getMyActiveLoans();

  ResultFuture<LoanDetailsResponseEntity> getLoanDetails(GetLoanDetailsRequestEntity getLoanDetailsRequestEntity);

  ResultFuture<GetProfileSetAlertResponseEntity> getProfileSetAlert(GetProfileSetAlertRequestEntity getProfileSetAlertRequestEntity);

}