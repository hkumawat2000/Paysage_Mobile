// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/repositories/login_repository.dart';

class VerifyOtpUsecase implements UsecaseWithParams<AuthLoginResponseEntity,VerifyOtpParams>{
  final LoginRepository loginRepository;
  VerifyOtpUsecase(this.loginRepository);

  @override
  ResultFuture<AuthLoginResponseEntity> call(params) async{
    return await loginRepository.verifyOtp(params.verifyOtpRequestEntity);
  }
  }

class VerifyOtpParams {
  final VerifyOtpRequestEntity verifyOtpRequestEntity;
  VerifyOtpParams({
    required this.verifyOtpRequestEntity,
  });
}
