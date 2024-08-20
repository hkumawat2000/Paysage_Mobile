import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/dashboard/data/data_source/dashboard_datasource.dart';
import 'package:lms/aa_getx/modules/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/force_update_usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:lms/aa_getx/modules/more/data/data_sources/more_api.dart';
import 'package:lms/aa_getx/modules/more/data/repositories/more_repository_impl.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_my_active_loans_usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_profile_set_alert_usecase.dart';
import 'package:lms/aa_getx/modules/more/presentation/controllers/more_controller.dart';

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

    //More bindings
    Get.lazyPut<MoreApiImpl>(()=>MoreApiImpl());

    Get.lazyPut<MoreRepositoryImpl>(()=>MoreRepositoryImpl(Get.find<MoreApiImpl>()));

    Get.lazyPut<GetMyActiveLoansUseCase>(()=>GetMyActiveLoansUseCase(Get.find<MoreRepositoryImpl>()));

    Get.lazyPut<GetLoanDetailsUseCase>(()=> GetLoanDetailsUseCase(Get.find<MoreRepositoryImpl>()));

    Get.lazyPut<GetProfileSetAlertUseCase>(()=> GetProfileSetAlertUseCase(Get.find<MoreRepositoryImpl>()));

    Get.lazyPut<MoreController>(() => MoreController(
      Get.find<GetMyActiveLoansUseCase>(),
      Get.find<ConnectionInfo>(),
      Get.find<GetLoanDetailsUseCase>(),
      Get.find<GetProfileSetAlertUseCase>(),
    ));
  }
}
