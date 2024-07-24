import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/forgot_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_forgot_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/repositories/login_repository.dart';

class VerifyForgotPinUsecase implements UsecaseWithParams<AuthLoginResponseEntity,VerifyForgotPinOtpParams>{
  final LoginRepository loginRepository;
  VerifyForgotPinUsecase(this.loginRepository);

  @override
  ResultFuture<AuthLoginResponseEntity> call(params) async{
    return await loginRepository.verifyForgotPinOtp(params.verifyForgotPinRequestEntity);
  }
  }

class VerifyForgotPinOtpParams {
  final VerifyForgotPinRequestEntity verifyForgotPinRequestEntity;
  VerifyForgotPinOtpParams({
    required this.verifyForgotPinRequestEntity,
  });
}