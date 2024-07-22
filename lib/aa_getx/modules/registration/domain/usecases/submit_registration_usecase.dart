
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/auth_login_response_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/repositories/registration_repository.dart';
import 'package:lms/aa_getx/modules/registration/presentation/arguments/registration_request_bean.dart';

class SubmitRegistrationUseCase
    extends UsecaseWithParams<AuthLoginResponseEntity,RegistrationRequestBean> {
  final RegistrationRepository registrationRepository;

  SubmitRegistrationUseCase(this.registrationRepository);

  @override
  ResultFuture<AuthLoginResponseEntity> call(RegistrationRequestBean params) async {
    return await registrationRepository.submitRegistration(params);
  }
}