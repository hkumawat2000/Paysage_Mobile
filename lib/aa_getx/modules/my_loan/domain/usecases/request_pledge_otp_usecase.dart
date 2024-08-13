
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/request/pledge_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/repositories/my_loans_repository.dart';

class RequestPledgeOtpUseCase extends UsecaseWithParams<CommonResponseEntity, PledgeOtpParams>{
  MyLoansRepository _myLoansRepository;

  RequestPledgeOtpUseCase(this._myLoansRepository);
  @override
  ResultFuture<CommonResponseEntity> call(params) async {
    return await _myLoansRepository.requestPledgeOTP(params.pledgeOTPRequestEntity);
  }

}

class PledgeOtpParams {
  PledgeOTPRequestEntity pledgeOTPRequestEntity;

  PledgeOtpParams({required this.pledgeOTPRequestEntity});
}