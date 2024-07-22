// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/pin_screen_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/repositories/login_repository.dart';

class PinScreeenUsecase implements UsecaseWithParams<AuthLoginResponseEntity,PinScreenParams>{
  final LoginRepository loginRepository;
  PinScreeenUsecase(this.loginRepository);

  ResultFuture<AuthLoginResponseEntity> call(params) async{
    return await loginRepository.getPin(params.pinScreenRequestEntity);
  }



}

class PinScreenParams {
    final PinScreenRequestEntity pinScreenRequestEntity;
    
  PinScreenParams({
    required this.pinScreenRequestEntity,
  });
  }