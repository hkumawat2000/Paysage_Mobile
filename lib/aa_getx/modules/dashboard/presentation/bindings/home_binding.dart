
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/dashboard/data/data_source/dashboard_datasource.dart';
import 'package:lms/aa_getx/modules/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/get_loan_summary_data_usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/controllers/home_controller.dart';
import 'package:lms/aa_getx/modules/more/data/data_sources/more_api.dart';
import 'package:lms/aa_getx/modules/more/data/repositories/more_repository_impl.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_my_active_loans_usecase.dart';

class HomeBinding extends Bindings{
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

    Get.lazyPut<GetDashboardDataUseCase>(
            () => GetDashboardDataUseCase(Get.find<DashboardRepositoryImpl>()));

    Get.lazyPut<GetLoanSummaryDataUseCase>(
            () => GetLoanSummaryDataUseCase(Get.find<DashboardRepositoryImpl>()));

    Get.lazyPut<MoreApiImpl>(()=>MoreApiImpl());

    Get.lazyPut<MoreRepositoryImpl>(()=>MoreRepositoryImpl(Get.find<MoreApiImpl>()));

    Get.lazyPut<GetMyActiveLoansUseCase>(()=>GetMyActiveLoansUseCase(Get.find<MoreRepositoryImpl>()));

    Get.lazyPut<GetLoanDetailsUseCase>(()=> GetLoanDetailsUseCase(Get.find<MoreRepositoryImpl>()));

    Get.lazyPut<HomeController>(
          () => HomeController(
        Get.find<ConnectionInfo>(),
        Get.find<GetDashboardDataUseCase>(),
        Get.find<GetLoanSummaryDataUseCase>(),
        Get.find<GetLoanDetailsUseCase>(),
      ),
    );
  }

}