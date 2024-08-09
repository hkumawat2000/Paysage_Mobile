
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/all_loan_names_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/lender_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/request/securities_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/securities_response_entity.dart';

abstract class MyLoansRepository{
  ResultFuture<AllLoanNamesResponseEntity> getAllLoansNames();

  ResultFuture<LenderResponseEntity> getLenders();

  ResultFuture<SecuritiesResponseEntity> getSecurities(SecuritiesRequestEntity securitiesRequestEntity);

}