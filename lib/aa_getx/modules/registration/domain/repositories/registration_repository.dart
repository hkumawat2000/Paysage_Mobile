import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/auth_login_response_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/usecases/set_pin_usecase.dart';

abstract class RegistrationRepository {
  ResultFuture<AuthLoginResponseEntity> setPin(SetPinParams params);
}