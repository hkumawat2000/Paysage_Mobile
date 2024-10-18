import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/additional_account_details/data/datasource/additional_acc_details_datasource.dart';
import 'package:lms/aa_getx/modules/additional_account_details/data/repositories/additional_acc_details_repository_impl.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/usecases/additional_account_details_usecase.dart';
import 'package:lms/aa_getx/modules/additional_account_details/presentation/controllers/additional_account_details_controller.dart';

class AdditionalAccountDetailsBindings extends Bindings {
  AdditionalAccountDetailsBindings();

  @override
  void dependencies() {
    Get.lazyPut<ConnectionInfoImpl>(
      () => ConnectionInfoImpl(Connectivity()),
    );

    Get.lazyPut<AdditionalAccDetailsDatasourceImpl>(
      () => AdditionalAccDetailsDatasourceImpl(),
    );

    Get.lazyPut<AdditionalAccDetailsRepositoryImpl>(
      () => AdditionalAccDetailsRepositoryImpl(
        Get.find<AdditionalAccDetailsDatasourceImpl>(),
      ),
    );

    Get.lazyPut<AdditionalAccountDetailsUsecase>(() =>
        AdditionalAccountDetailsUsecase(
            Get.find<AdditionalAccDetailsRepositoryImpl>()));

    Get.lazyPut<AdditionalAccountDetailsController>(
      () => AdditionalAccountDetailsController(
        Get.find<ConnectionInfo>(),
        Get.find<AdditionalAccountDetailsUsecase>(),
      ),
    );
  }
}
