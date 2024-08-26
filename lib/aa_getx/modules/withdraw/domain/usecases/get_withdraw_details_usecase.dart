// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/core/utils/type_def.dart';

import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_search_response_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/loan_withdraw_response_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/request/withdraw_loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/repositories/loan_withdraw_repository.dart';

/// use case is a class responsible for encapsulating a specific piece of business logic or 
/// a particular operation that your application needs to perform.
/// It acts as a bridge between the presentation
/// layer and the data layer.
class GetWithdrawDetailsUsecase implements UsecaseWithParams<LoanWithdrawResponseEntity,GetWithdrawParams>{
	  
   final LoanWithdrawRepository loanWithdrawRepository;
   GetWithdrawDetailsUsecase(this.loanWithdrawRepository);

   @override
  ResultFuture<LoanWithdrawResponseEntity> call(params)async {
    return await loanWithdrawRepository.getWithdrawDetails(params.withdrawLoanDetailsRequestEntity);
  }
}

class GetWithdrawParams {
  final WithdrawLoanDetailsRequestEntity withdrawLoanDetailsRequestEntity;
  GetWithdrawParams({
    required this.withdrawLoanDetailsRequestEntity,
  });
  
}
