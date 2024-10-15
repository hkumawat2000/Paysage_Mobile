import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/lender/data/datasources/lender_datasource.dart';
import 'package:lms/aa_getx/modules/lender/data/repositories/lender_repository_impl.dart';
import 'package:lms/aa_getx/modules/lender/domain/usecases/lender_usecase.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/datasource/isin_details_datasource.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/datasource/pledge_mf_datasource.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/repositories/isin_details_repository_impl.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/repositories/pledge_mf_repository_impl.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/usecases/isin_details_usecase.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/usecases/mf_scheme_usecase.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/presentation/controllers/pledge_mf_scheme_selection_controller.dart';

class PledgeMfBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PledgeMfDatasourceImpl>(
      () => PledgeMfDatasourceImpl(),
    );

    Get.lazyPut<LenderDatasourceImpl>(
      () => LenderDatasourceImpl(),
    );

    Get.lazyPut<IsinDetailsDatasourceImpl>(
      () => IsinDetailsDatasourceImpl(),
    );

    Get.lazyPut<PledgeMfRepositoryImpl>(
      () => PledgeMfRepositoryImpl(
        Get.find<PledgeMfDatasourceImpl>(),
      ),
    );

    Get.lazyPut<LenderRepositoryImpl>(
      () => LenderRepositoryImpl(
        Get.find<LenderDatasourceImpl>(),
      ),
    );

    Get.lazyPut<IsinDetailsRepositoryImpl>(
      () => IsinDetailsRepositoryImpl(
        Get.find<IsinDetailsDatasourceImpl>(),
      ),
    );

    Get.lazyPut<MfSchemeUsecase>(
        () => MfSchemeUsecase(Get.find<PledgeMfRepositoryImpl>()));

    Get.lazyPut<LenderUsecase>(
        () => LenderUsecase(Get.find<LenderRepositoryImpl>()));

    Get.lazyPut<IsinDetailsUsecase>(
        () => IsinDetailsUsecase(Get.find<IsinDetailsRepositoryImpl>()));
        

    Get.lazyPut<PledgeMfSchemeSelectionController>(
      () => PledgeMfSchemeSelectionController(
        Get.find<ConnectionInfo>(),
        Get.find<MfSchemeUsecase>(),
        Get.find<LenderUsecase>(),
        Get.find<IsinDetailsUsecase>(),
      ),
    );
  }
}