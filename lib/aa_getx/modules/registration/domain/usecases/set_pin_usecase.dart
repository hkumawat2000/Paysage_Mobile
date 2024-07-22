import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/auth_login_response_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/request/set_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/repositories/registration_repository.dart';

class SetPinUseCase
    extends UsecaseWithParams<AuthLoginResponseEntity,SetPinParams> {
  final RegistrationRepository registrationRepository;

  SetPinUseCase(this.registrationRepository);

  @override
  ResultFuture<AuthLoginResponseEntity> call(SetPinParams params) async {
    return await registrationRepository.setPin(params.setPinRequestEntity);
  }
}

class SetPinParams {
  final SetPinRequestEntity setPinRequestEntity;
  SetPinParams({
    required this.setPinRequestEntity,
  });
}