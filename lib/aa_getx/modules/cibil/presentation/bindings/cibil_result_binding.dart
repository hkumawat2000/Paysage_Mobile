import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/cibil/data/repositories/cibil_repository_impl.dart';
import 'package:lms/aa_getx/modules/cibil/domain/usecases/cibil_on_demand_usecase.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_result_controller.dart';

class CibilResultBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<CibilOnDemandUsecase>(
            () => CibilOnDemandUsecase(Get.find<CibilRepositoryImpl>()));

    Get.lazyPut<CibilResultController>(() => CibilResultController(
        Get.find<CibilOnDemandUsecase>()));
  }

}