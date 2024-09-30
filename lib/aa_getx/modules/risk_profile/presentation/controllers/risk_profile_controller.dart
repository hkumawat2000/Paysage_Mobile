import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/request/risk_profile_request_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/get_risk_category_response_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/risk_profile_response_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/usecases/get_risk_category_usecase.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/usecases/save_risk_category_usecase.dart';

class RiskProfileController extends GetxController {
  List<String> ageList = ["", "20-30", "30-40", "40-50", "50-60"];

  final age = Rxn<String>();
  RxList<RiskCategoryDataEntity> riskCategoryDataList = <RiskCategoryDataEntity>[].obs;
  RxList<RiskProfileRequestDataEntity> riskCategoryResultDataList = <RiskProfileRequestDataEntity>[].obs;
  RxList<String?> riskSubCategoryResultList = <String?>[].obs;
  RxBool isApiCalling = true.obs;

  final GetRiskCategoryUsecase getRiskCategoryUsecase;
  final SaveRiskCategoryUsecase saveRiskCategoryUsecase;

  RiskProfileController(this.getRiskCategoryUsecase, this.saveRiskCategoryUsecase);

  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  getCategory() async {
    DataState<GetRiskCategoryResponseEntity> response =
        await getRiskCategoryUsecase.call();
    isApiCalling(false);
    if (response is DataSuccess) {
      riskCategoryDataList.value = response.data!.categoryDataList!;
      for(int i=0; i< response.data!.categoryDataList!.length; i++){
        riskSubCategoryResultList.add(null);
      }
    } else if (response is DataFailed) {
      Utility.showToastMessage(response.error!.message);
    }
  }

  dropDownOnChange(int index, String subCategory){
    riskSubCategoryResultList[index] = subCategory;
  }

  submitData() async {
    if(riskSubCategoryResultList.contains(null)){
      Utility.showToastMessage("Select all Category");
    } else {
      showDialogLoading(Strings.please_wait);
      riskCategoryResultDataList.clear();
      for(int i=0; i<riskCategoryDataList.length; i++){
        riskCategoryResultDataList.add(
          RiskProfileRequestDataEntity(
            category: riskCategoryDataList[i].category,
            subCategory: riskSubCategoryResultList[i],
          ),
        );
      }

      DataState<RiskProfileResponseEntity> response = await saveRiskCategoryUsecase.call(
        SaveRiskProfileCategoryParams(
          riskProfileRequestEntity: RiskProfileRequestEntity(
            data: riskCategoryResultDataList
          ),
        ),
      );
      Get.back();
      if (response is DataSuccess) {
        Get.back();
        Utility.showToastMessage("${response.data!.data!.riskProfilePercentage!}");
      } else if (response is DataFailed) {
        Utility.showToastMessage(response.error!.message);
      }

    }
  }
}