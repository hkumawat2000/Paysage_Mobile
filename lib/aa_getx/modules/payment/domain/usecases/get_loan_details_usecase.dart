
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/repositories/payment_repository.dart';

class GetLoanDetailsPayUseCase extends UsecaseWithParams<LoanDetailsResponseEntity, GetLoanDetailsParams>{
  final PaymentRepository paymentRepository;

  GetLoanDetailsPayUseCase(this.paymentRepository);

  @override
  ResultFuture<LoanDetailsResponseEntity> call(GetLoanDetailsParams params) async{
    return await paymentRepository.getLoanDetails(params.loanDetailsRequestEntity);
  }

}

class GetLoanDetailsParams{
  final LoanDetailsRequestEntity loanDetailsRequestEntity;
  GetLoanDetailsParams({
    required this.loanDetailsRequestEntity,
  });
}
