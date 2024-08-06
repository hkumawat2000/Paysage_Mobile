
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/all_loan_names_response_entity.dart';

abstract class MyLoansRepository{
  ResultFuture<AllLoanNamesResponseEntity> getAllLoansNames();

}