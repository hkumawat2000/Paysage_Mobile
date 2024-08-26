// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/core/utils/type_def.dart';

import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/repositories/loan_withdraw_repository.dart';

/// use case is a class responsible for encapsulating a specific piece of business logic or
/// a particular operation that your application needs to perform.
/// It acts as a bridge between the presentation
/// layer and the data layer.
class GetLoanWithdrawOTPUsecase
    implements UsecaseWithoutParams<CommonResponseEntity> {
  final LoanWithdrawRepository loanWithdrawRepository;
  GetLoanWithdrawOTPUsecase(this.loanWithdrawRepository);

  @override
  ResultFuture<CommonResponseEntity> call() async {
    return await loanWithdrawRepository.requestLoanWithDrawOTP();
  }
}
