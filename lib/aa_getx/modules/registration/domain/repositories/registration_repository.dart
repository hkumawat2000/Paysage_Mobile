import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/auth_login_response_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/request/registration_request_bean_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/request/set_pin_request_entity.dart';

abstract class RegistrationRepository {
  ResultFuture<AuthLoginResponseEntity> setPin(SetPinRequestEntity setPinRequestEntity);

  ResultFuture<AuthLoginResponseEntity> submitRegistration(RegistrationRequestBeanEntity params);
}