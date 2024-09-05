import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/mf_send_otp_response_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/repositories/mf_central_repository.dart';

class MutualFundOtpSendUsecase implements UsecaseWithoutParams<MutualFundSendOtpResponseEntity>{

  final MfCentralRepository mfCentralRepository;
  MutualFundOtpSendUsecase(this.mfCentralRepository);

  @override
  ResultFuture<MutualFundSendOtpResponseEntity> call() async {
    return await mfCentralRepository.mutualFundOtpSend();
  }

}