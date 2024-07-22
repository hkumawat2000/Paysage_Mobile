import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/login/data/data_sources/login_data_source.dart';
import 'package:lms/aa_getx/modules/login/data/repositories/login_repository_impl.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/pin_screeen_usecase.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/pin_screen_controller.dart';

class PinScreenBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<LoginDataSourceImpl>(
      () => LoginDataSourceImpl(),
    );

    Get.lazyPut<LoginRepositoryImpl>(
      () => LoginRepositoryImpl(
        Get.find<LoginDataSourceImpl>(),
      ),
    );

    Get.lazyPut<PinScreeenUsecase>(
        () => PinScreeenUsecase(Get.find<LoginRepositoryImpl>()));

    Get.lazyPut<PinScreenController>(
      () => PinScreenController(
        Get.find<ConnectionInfo>(),
        Get.find<PinScreeenUsecase>(),
      ),
    );
  }
}
