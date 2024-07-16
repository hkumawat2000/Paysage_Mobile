
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/registration/data/data_source/registration_api.dart';
import 'package:lms/aa_getx/modules/registration/data/repositories/registration_repository_impl.dart';
import 'package:lms/aa_getx/modules/registration/domain/usecases/set_pin_usecase.dart';
import 'package:lms/aa_getx/modules/registration/presentation/controllers/set_pin_controller.dart';

class SetPinBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut<RegistrationApiImpl>(
          () => RegistrationApiImpl(),
    );

    Get.lazyPut<RegistrationRepositoryImpl>(
          () => RegistrationRepositoryImpl(
        Get.find<RegistrationApiImpl>()
      ),
    );

    Get.lazyPut<SetPinUseCase>(
          () => SetPinUseCase(Get.find<RegistrationRepositoryImpl>()),
    );

    Get.lazyPut<SetPinController>(()=>SetPinController(Get.find<SetPinUseCase>(),Get.find<ConnectionInfo>()));
  }

}