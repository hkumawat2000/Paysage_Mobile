import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/kyc/data/data_sources/kyc_data_source.dart';
import 'package:lms/aa_getx/modules/kyc/data/repositories/kyc_repository_impl.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/consent_details_usecase.dart';
import 'package:lms/aa_getx/modules/kyc/domain/usecases/get_pincode_details_usecase.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/controllers/kyc_address_controller.dart';


class KycAddressBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KycDataSourceImpl>(
      () => KycDataSourceImpl(),
    );
    Get.lazyPut<KycRepositoryImpl>(
      () => KycRepositoryImpl(
        Get.find<KycDataSourceImpl>(),
      ),
    );

    Get.lazyPut<GetPincodeDetailsUsecase>(
        () => GetPincodeDetailsUsecase(Get.find<KycRepositoryImpl>()));

    Get.lazyPut<ConsentDetailsKycUsecase>(
        () => ConsentDetailsKycUsecase(Get.find<KycRepositoryImpl>()));

    Get.lazyPut<KycAddressController>(
      () => KycAddressController(
        Get.find<ConnectionInfo>(),
        Get.find<GetPincodeDetailsUsecase>(),
        Get.find<ConsentDetailsKycUsecase>(),
      ),
    );
  }
}
