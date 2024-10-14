import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/data/datasource/approved_shares_and_mf_datasource.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/data/repositories/approved_shares_and_mf_repository_impl.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/usecases/get_demat_account_details_usecase.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/presentation/controllers/approved_shares_controller.dart';

class ApprovedSharesAndMfBindings extends Bindings {
  ApprovedSharesAndMfBindings();

  @override
  void dependencies() {
    Get.lazyPut<ApprovedSharedAndMfDataSourceImpl>(
      () => ApprovedSharedAndMfDataSourceImpl(),
    );

    Get.lazyPut<ApprovedSharesAndMfRepositoryImpl>(
      () => ApprovedSharesAndMfRepositoryImpl(
        Get.find<ApprovedSharedAndMfDataSourceImpl>(),
      ),
    );

    Get.lazyPut<GetDematAccountDetailsUsecase>(
        () => GetDematAccountDetailsUsecase(Get.find<ApprovedSharesAndMfRepositoryImpl>()));

    Get.lazyPut<ApprovedSharesController>(
      () => ApprovedSharesController(
        Get.find<ConnectionInfo>(),
        Get.find<GetDematAccountDetailsUsecase>(),
      ),
    );
  }
}
