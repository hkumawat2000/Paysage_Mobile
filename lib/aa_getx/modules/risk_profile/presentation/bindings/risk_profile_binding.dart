import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/data_source/risk_profile_data_source.dart';
import 'package:lms/aa_getx/modules/risk_profile/data/repositories/risk_profile_repository_impl.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/usecases/get_risk_category_usecase.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/usecases/save_risk_category_usecase.dart';
import 'package:lms/aa_getx/modules/risk_profile/presentation/controllers/risk_profile_controller.dart';

class RiskProfileBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<RiskProfileDataSourceImpl>(
          () => RiskProfileDataSourceImpl(),
    );

    Get.lazyPut<RiskProfileRepositoryImpl>(
          () => RiskProfileRepositoryImpl(
        Get.find<RiskProfileDataSourceImpl>(),
      ),
    );

    Get.lazyPut<GetRiskCategoryUsecase>(
            () => GetRiskCategoryUsecase(Get.find<RiskProfileRepositoryImpl>()));

    Get.lazyPut<SaveRiskCategoryUsecase>(
            () => SaveRiskCategoryUsecase(Get.find<RiskProfileRepositoryImpl>()));

    Get.lazyPut<RiskProfileController>(() => RiskProfileController(
      Get.find<GetRiskCategoryUsecase>(),
      Get.find<SaveRiskCategoryUsecase>(),
    ));
  }
}
