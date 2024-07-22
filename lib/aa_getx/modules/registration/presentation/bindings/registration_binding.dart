import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/registration/data/data_source/registration_api.dart';
import 'package:lms/aa_getx/modules/registration/data/repositories/registration_repository_impl.dart';
import 'package:lms/aa_getx/modules/registration/domain/usecases/submit_registration_usecase.dart';
import 'package:lms/aa_getx/modules/registration/presentation/controllers/registration_controller.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegistrationApiImpl>(
      () => RegistrationApiImpl(),
    );

    Get.lazyPut<RegistrationRepositoryImpl>(
      () => RegistrationRepositoryImpl(Get.find<RegistrationApiImpl>()),
    );

    Get.lazyPut<SubmitRegistrationUseCase>(
      () => SubmitRegistrationUseCase(Get.find<RegistrationRepositoryImpl>()),
    );

    Get.lazyPut<RegistrationController>(() => RegistrationController(
        Get.find<SubmitRegistrationUseCase>(), Get.find<ConnectionInfo>()));
  }
}
