import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_otp_verification_request_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_otp_verification_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/repositories/cibil_repository.dart';

class CibilOtpVerificationUsecase implements UsecaseWithParams<CibilOtpVerificationResponseEntity, CibilOtpVerificationParams>{

  final CibilRepository cibilRepository;
  CibilOtpVerificationUsecase(this.cibilRepository);

  @override
  ResultFuture<CibilOtpVerificationResponseEntity> call(params)async {
    return await cibilRepository.cibilOtpVerification(params.cibilOtpVerificationRequestEntity);
  }
}


class CibilOtpVerificationParams {
  final CibilOtpVerificationRequestEntity cibilOtpVerificationRequestEntity;
  CibilOtpVerificationParams({
    required this.cibilOtpVerificationRequestEntity,
  });
}
