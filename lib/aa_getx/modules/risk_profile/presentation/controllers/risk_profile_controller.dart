import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/entity/response/get_risk_category_response_entity.dart';
import 'package:lms/aa_getx/modules/risk_profile/domain/usecases/get_risk_category_usecase.dart';

class RiskProfileController extends GetxController {
  List<String> ageList = ["", "20-30", "30-40", "40-50", "50-60"];

  final age = Rxn<String>();
  RxList<RiskCategoryDataEntity> riskCategoryDataList = <RiskCategoryDataEntity>[].obs;
  RxList<String?> riskSubCategoryResultList = <String?>[].obs;
  RxBool isApiCalling = true.obs;

  final GetRiskCategoryUsecase getRiskCategoryUsecase;

  RiskProfileController(this.getRiskCategoryUsecase);

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
}


class RiskCategoryResultResponse {
  String? category;
  String? subCategory;

  RiskCategoryResultResponse(this.category, this.subCategory);

}