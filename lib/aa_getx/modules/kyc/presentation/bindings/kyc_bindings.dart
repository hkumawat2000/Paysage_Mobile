import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/kyc/data/data_sources/kyc_data_source.dart';
import 'package:lms/aa_getx/modules/kyc/data/repositories/kyc_repository_impl.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/consent_text_usecase.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/download_kyc_usecase.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/search_kyc_usecases.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/controllers/kyc_controller.dart';

class KycBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionInfoImpl>(
          () => ConnectionInfoImpl(Connectivity()),
    );

    Get.lazyPut<KycDataSourceImpl>(
      () => KycDataSourceImpl(),
    );

    Get.lazyPut<KycRepositoryImpl>(
      () => KycRepositoryImpl(
        Get.find<KycDataSourceImpl>(),
      ),
    );

    Get.lazyPut<SearchKycUseCase>(
        () => SearchKycUseCase(Get.find<KycRepositoryImpl>()));

    Get.lazyPut<DownloadKycUsecase>(
        () => DownloadKycUsecase(Get.find<KycRepositoryImpl>()));

    Get.lazyPut<ConsentTextKycUsecase>(
        () => ConsentTextKycUsecase(Get.find<KycRepositoryImpl>()));
        

    Get.lazyPut<KycController>(
      () => KycController(
        Get.find<ConnectionInfo>(),
        Get.find<SearchKycUseCase>(),
        Get.find<DownloadKycUsecase>(),
        Get.find<ConsentTextKycUsecase>(),
      ),
    );
  }
}
