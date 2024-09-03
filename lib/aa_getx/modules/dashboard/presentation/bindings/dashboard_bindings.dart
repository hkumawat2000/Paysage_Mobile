import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/dashboard/data/data_source/dashboard_datasource.dart';
import 'package:lms/aa_getx/modules/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/force_update_usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/usecases/get_loan_summary_data_usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/controllers/dashboard_controller.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/controllers/home_controller.dart';
import 'package:lms/aa_getx/modules/more/data/data_sources/more_api.dart';
import 'package:lms/aa_getx/modules/more/data/repositories/more_repository_impl.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_my_active_loans_usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_profile_set_alert_usecase.dart';
import 'package:lms/aa_getx/modules/more/presentation/controllers/more_controller.dart';
import 'package:lms/aa_getx/modules/my_loan/data/data_sources/my_loans_api.dart';
import 'package:lms/aa_getx/modules/my_loan/data/repositories/my_loans_repository_impl.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/get_all_loans_name_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/controllers/single_my_active_loan_controller.dart';
import 'package:lms/aa_getx/modules/notification/data/data_source/notification_api.dart';
import 'package:lms/aa_getx/modules/notification/data/repositories/notification_repository_impl.dart';
import 'package:lms/aa_getx/modules/notification/domain/usecases/delete_clear_notification_usecase.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/data_sources/pledged_securities_api.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/repositories/pledged_securities_repository_impl.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/usecases/get_my_pledged_securities_usecase.dart';
import 'package:lms/aa_getx/modules/pledged_securities/presentation/controllers/my_pledge_security_controller.dart';

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

    Get.lazyPut<NotificationApiImpl>(
          () => NotificationApiImpl(),
    );

    Get.lazyPut<NotificationRepositoryImpl>(
          () => NotificationRepositoryImpl(Get.find<NotificationApiImpl>()),
    );

    Get.lazyPut<DeleteOrClearNotificationUseCase>(() =>
        DeleteOrClearNotificationUseCase(
            Get.find<NotificationRepositoryImpl>()));

    Get.lazyPut<MoreApiImpl>(()=>MoreApiImpl());

    Get.lazyPut<MoreRepositoryImpl>(()=>MoreRepositoryImpl(Get.find<MoreApiImpl>()));

    Get.lazyPut<GetLoanDetailsUseCase>(()=> GetLoanDetailsUseCase(Get.find<MoreRepositoryImpl>()));

    Get.lazyPut<DashboardController>(
      () => DashboardController(
        Get.find<ConnectionInfo>(),
        Get.find<ForceUpdateUsecase>(),
        Get.find<DeleteOrClearNotificationUseCase>(),
        Get.find<GetLoanDetailsUseCase>(),
      ),
    );

    /// Home bindings
    Get.lazyPut<GetDashboardDataUseCase>(
            () => GetDashboardDataUseCase(Get.find<DashboardRepositoryImpl>()));

    Get.lazyPut<GetLoanSummaryDataUseCase>(
            () => GetLoanSummaryDataUseCase(Get.find<DashboardRepositoryImpl>()));

    Get.lazyPut<HomeController>(
          () => HomeController(
        Get.find<ConnectionInfo>(),
        Get.find<GetDashboardDataUseCase>(),
        Get.find<GetLoanSummaryDataUseCase>(),
        Get.find<GetLoanDetailsUseCase>(),
      ),
    );

    /// More bindings
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

    /// My Pledge Securities bindings
    Get.lazyPut<MyLoansApiImpl>(() => MyLoansApiImpl());

    Get.lazyPut<MyLoansRepositoryImpl>(
            () => MyLoansRepositoryImpl(Get.find<MyLoansApiImpl>()));

    Get.lazyPut<GetAllLoansNamesUseCase>(
            () => GetAllLoansNamesUseCase(Get.find<MyLoansRepositoryImpl>()));

    Get.lazyPut<PledgedSecuritiesApiImpl>(()=>PledgedSecuritiesApiImpl());

    Get.lazyPut<PledgedSecuritiesRepositoryImpl>(()=> PledgedSecuritiesRepositoryImpl(Get.find<PledgedSecuritiesApiImpl>()));

    Get.lazyPut<GetMyPledgedSecuritiesUseCase>(()=>GetMyPledgedSecuritiesUseCase(Get.find<PledgedSecuritiesRepositoryImpl>()));

    Get.lazyPut<MyPledgeSecurityController>(() => MyPledgeSecurityController(
        Get.find<ConnectionInfo>(),
        Get.find<GetAllLoansNamesUseCase>(),
        Get.find<GetLoanDetailsUseCase>(),
        Get.find<GetMyPledgedSecuritiesUseCase>()));

    /// Single my active loan bindings
    Get.lazyPut<SingleMyActiveLoanController>(() =>
        SingleMyActiveLoanController(
            Get.find<ConnectionInfo>(),
            Get.find<GetAllLoansNamesUseCase>(),
            Get.find<GetLoanDetailsUseCase>()));
  }
}
