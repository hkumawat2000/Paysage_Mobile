
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/auth_login_response_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/request/registration_request_bean_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/repositories/registration_repository.dart';

class SubmitRegistrationUseCase
    extends UsecaseWithParams<AuthLoginResponseEntity,RegistrationRequestBeanParams> {
  final RegistrationRepository registrationRepository;

  SubmitRegistrationUseCase(this.registrationRepository);

  @override
  ResultFuture<AuthLoginResponseEntity> call(RegistrationRequestBeanParams params) async {
    return await registrationRepository.submitRegistration(params.registrationRequestBeanEntity);
  }
}

class RegistrationRequestBeanParams {
  final RegistrationRequestBeanEntity registrationRequestBeanEntity;

  RegistrationRequestBeanParams({required this.registrationRequestBeanEntity});
}