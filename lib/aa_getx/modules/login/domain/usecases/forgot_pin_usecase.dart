import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/forgot_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/repositories/login_repository.dart';

class ForgotPinUsecase implements UsecaseWithParams<AuthLoginResponseEntity,ForgotPinOtpParams>{
  final LoginRepository loginRepository;
  ForgotPinUsecase(this.loginRepository);

  @override
  ResultFuture<AuthLoginResponseEntity> call(params) async{
    return await loginRepository.forgotPinOtp(params.forgotPinRequestEntity);
  }
  }

class ForgotPinOtpParams {
  final ForgotPinRequestEntity forgotPinRequestEntity;
  ForgotPinOtpParams({
    required this.forgotPinRequestEntity,
  });
}