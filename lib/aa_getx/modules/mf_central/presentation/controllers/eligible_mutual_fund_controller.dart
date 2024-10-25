import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/fetch_mutual_fund_response_entity.dart';

class EligibleMutualFundController extends GetxController {

  List<FetchMutualFundResponseDataEntity> fetchMutualFundResponseData = Get.arguments;
  List<FetchMutualFundResponseDataEntity> approvedMutualFundList = [];

  double totalValueOfAllowedMf = 0;

  @override
  void onInit() {
    dataBindOfMutualFund();
    super.onInit();
  }

  dataBindOfMutualFund(){
    for(int i=0; i < fetchMutualFundResponseData.length; i++){
      if(fetchMutualFundResponseData[i].isAllowed == 1) {
        approvedMutualFundList.add(fetchMutualFundResponseData[i]);
      }
    }

    for(int i=0; i < approvedMutualFundList.length; i++){
      totalValueOfAllowedMf += double.parse(approvedMutualFundList[i].marketValue!);
    }
  }

}