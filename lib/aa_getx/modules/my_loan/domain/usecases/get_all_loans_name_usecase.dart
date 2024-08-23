import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/all_loan_names_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/repositories/my_loans_repository.dart';

class GetAllLoansNamesUseCase
    extends UsecaseWithoutParams<AllLoanNamesResponseEntity> {
  final MyLoansRepository myLoansRepository;

  GetAllLoansNamesUseCase(this.myLoansRepository);

  @override
  ResultFuture<AllLoanNamesResponseEntity> call() async {
    return await myLoansRepository.getAllLoansNames();
  }
}
