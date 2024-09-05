import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/fetch_mutual_fund_response_entity.dart';

class FetchMutualFundController extends GetxController {

  List<FetchMutualFundResponseDataEntity> fetchMutualFundResponseData = Get.arguments;

  @override
  void onInit() {
    dataBindOfMutualFund();
    super.onInit();
  }

  dataBindOfMutualFund(){
    print("Total Mutual Fund => ${fetchMutualFundResponseData.length}");
  }

}