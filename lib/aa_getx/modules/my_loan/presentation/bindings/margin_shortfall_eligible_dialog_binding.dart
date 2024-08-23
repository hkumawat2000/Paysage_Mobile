import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/my_loan/data/data_sources/my_loans_api.dart';
import 'package:lms/aa_getx/modules/my_loan/data/repositories/my_loans_repository_impl.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/request_pledge_otp_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/controllers/margin_shortfall_eligible_dialog_controller.dart';

class MarginShortfallEligibleDialogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyLoansApiImpl>(() => MyLoansApiImpl());

    Get.lazyPut<MyLoansRepositoryImpl>(
        () => MyLoansRepositoryImpl(Get.find<MyLoansApiImpl>()));

    Get.lazyPut<RequestPledgeOtpUseCase>(
        () => RequestPledgeOtpUseCase(Get.find<MyLoansRepositoryImpl>()));

    Get.lazyPut<MarginShortfallEligibleDialogController>(() =>
        MarginShortfallEligibleDialogController(
            Get.find<ConnectionInfo>(), Get.find<RequestPledgeOtpUseCase>()));
  }
}
