import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_on_demand_request_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_on_demand_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/usecases/cibil_on_demand_usecase.dart';

class CibilResultController extends GetxController {

  CibilResultArgs cibilResultArgs = Get.arguments;
  String? hitId;
  String cibilScore = "";
  RxString cibilScoreDate = "".obs;

  RxString cibilScoreResult = "".obs;

  final CibilOnDemandUsecase cibilOnDemandUsecase;

  CibilResultController(this.cibilOnDemandUsecase);

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }


  getArgument(){
    hitId = cibilResultArgs.hitId;
    cibilScore = cibilResultArgs.cibilScore!;
    cibilScoreDate.value = cibilResultArgs.cibilScoreDate ?? "";
    print("cibilScore ==> ${cibilScore}");
    if(hitId!.isNotEmpty){
      cibilScoreResult.value = cibilScore;
    }
  }

  callOnDematRefresh() async {
    DataState<CibilOnDemandResponseEntity> response = await cibilOnDemandUsecase.call(
        CibilOnDemandParams(
            cibilOnDemandRequestEntity: CibilOnDemandRequestEntity(
              hitID: hitId,
            )
        )
    );
    if (response is DataSuccess) {
      if (response.data!.cibilDataEntity != null) {
        cibilScore = response.data!.cibilDataEntity!.cibilScore!.toString();
        cibilScoreDate.value = response.data!.cibilDataEntity!.cibilScoreDate!;
      }
    } else if (response is DataFailed) {
      Utility.showToastMessage(response.error!.message);
    }
  }
}

class CibilResultArgs {
  String? hitId;
  String? cibilScore;
  String? cibilScoreDate;

  CibilResultArgs({this.hitId, this.cibilScore, this.cibilScoreDate});
}