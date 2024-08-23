
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/create_loan_application_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/process_cart_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/repositories/my_loans_repository.dart';

class CreateLoanApplicationUseCase extends UsecaseWithParams<ProcessCartResponseEntity, CreateLoanApplicationRequestParams>{
  final MyLoansRepository _myLoansRepository;

  CreateLoanApplicationUseCase(this._myLoansRepository);

  @override
  ResultFuture<ProcessCartResponseEntity> call(CreateLoanApplicationRequestParams params) async {
    return await _myLoansRepository.createLoanApplication(params.createLoanApplicationRequestEntity);
  }

}

class CreateLoanApplicationRequestParams {
  final CreateLoanApplicationRequestEntity createLoanApplicationRequestEntity;

  CreateLoanApplicationRequestParams({required this.createLoanApplicationRequestEntity });
}