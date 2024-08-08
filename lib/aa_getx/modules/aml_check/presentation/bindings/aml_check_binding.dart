import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/aml_check/data/data_source/aml_data_source.dart';
import 'package:lms/aa_getx/modules/aml_check/data/repositories/aml_check_repository_impl.dart';
import 'package:lms/aa_getx/modules/aml_check/domain/usecases/aml_check_usecase.dart';
import 'package:lms/aa_getx/modules/aml_check/presentation/controllers/aml_check_controller.dart';

class AmlCheckBinding extends Bindings {


  @override
  void dependencies() {

    Get.lazyPut(() => AmlDataSourceApiImp());

    Get.lazyPut(() => AmlCheckRepositoryImpl(Get.find<AmlDataSourceApiImp>()));

    Get.lazyPut<AmlCheckUsecase>(
            () => AmlCheckUsecase(Get.find<AmlCheckRepositoryImpl>()));

    Get.lazyPut<AmlCheckController>(
          () => AmlCheckController(
        Get.find<ConnectionInfo>(),
        Get.find<AmlCheckUsecase>(),
      ),
    );
  }

}