import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/loan_withdraw_response_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/request/withdraw_loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/request/withdraw_otp_request_entity.dart';

abstract class LoanWithdrawRepository {
  ResultFuture<LoanWithdrawResponseEntity> getWithdrawDetails(
      WithdrawLoanDetailsRequestEntity withdrawLoanDetailsRequestEntity);
  ResultFuture<CommonResponseEntity> requestLoanWithDrawOTP();
  ResultFuture<CommonResponseEntity> createWithDrawRequest(
      WithdrawOtpRequestEntity withdrawOtpRequestEntity);
}
