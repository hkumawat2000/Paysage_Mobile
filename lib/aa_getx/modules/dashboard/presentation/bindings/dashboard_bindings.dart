import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/dashboard/data/data_source/dashboard_datasource.dart';
import 'package:lms/aa_getx/modules/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/force_update_usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/controllers/dashboard_controller.dart';

class DashboardBindings extends Bindings {
  DashboardBindings();

  @override
  void dependencies() {
    Get.lazyPut<DashboardDataSourceDataSourceImpl>(
      () => DashboardDataSourceDataSourceImpl(),
    );

    Get.lazyPut<DashboardRepositoryImpl>(
      () => DashboardRepositoryImpl(
        Get.find<DashboardDataSourceDataSourceImpl>(),
      ),
    );

    Get.lazyPut<ForceUpdateUsecase>(
        () => ForceUpdateUsecase(Get.find<DashboardRepositoryImpl>()));

    Get.lazyPut<DashboardController>(
      () => DashboardController(
        Get.find<ConnectionInfo>(),
        Get.find<ForceUpdateUsecase>(),
      ),
    );
  }
}
