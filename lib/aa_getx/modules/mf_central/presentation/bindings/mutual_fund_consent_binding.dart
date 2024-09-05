import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/mf_central/data/data_source/mf_central_data_source.dart';
import 'package:lms/aa_getx/modules/mf_central/data/repositories/mf_central_repository_impl.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/usecases/mutual_fund_fetch_usecase.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/usecases/mutual_fund_otp_send_usecase.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/controllers/mutual_fund_consent_controller.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/controllers/mutual_fund_otp_controller.dart';

class MutualFundConsentBinding extends Bindings {

  @override
  void dependencies() {

    Get.lazyPut<MfCentralDataSourceImpl>(
          () => MfCentralDataSourceImpl(),
    );

    Get.lazyPut<MfCentralRepositoryImpl>(
          () => MfCentralRepositoryImpl(
        Get.find<MfCentralDataSourceImpl>(),
      ),
    );

    Get.lazyPut<MutualFundOtpSendUsecase>(
            () => MutualFundOtpSendUsecase(Get.find<MfCentralRepositoryImpl>()));

    Get.lazyPut<MutualFundFetchUsecase>(
            () => MutualFundFetchUsecase(Get.find<MfCentralRepositoryImpl>()));

    Get.lazyPut<MutualFundOtpController>(() => MutualFundOtpController(
      Get.find<ConnectionInfo>(),
      Get.find<MutualFundFetchUsecase>(),
    ));

    Get.lazyPut<MutualFundConsentController>(() =>
        MutualFundConsentController(
          Get.find<ConnectionInfo>(),
          Get.find<MutualFundOtpSendUsecase>(),
        ),
    );
  }

}