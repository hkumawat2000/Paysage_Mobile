import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_send_otp_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/repositories/cibil_repository.dart';

class CibilSendOtpUsecase implements UsecaseWithoutParams<CibilSendOtpResponseEntity>{

  final CibilRepository cibilRepository;
  CibilSendOtpUsecase(this.cibilRepository);

  @override
  ResultFuture<CibilSendOtpResponseEntity> call()async {
    return await cibilRepository.cibilOtpSend();
  }
}