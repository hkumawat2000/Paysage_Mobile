import 'package:get/get.dart';

class CibilResultController extends GetxController {

  CibilResultArgs cibilResultArgs = Get.arguments;
  String? hitId;
  RxString? cibilScore;
  String? cibilScoreDate;

  // RxString cibilScoreResult = "".obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }


  getArgument(){
    hitId = cibilResultArgs.hitId;
    cibilScore!.value = cibilResultArgs.cibilScore!;
    cibilScoreDate = cibilResultArgs.cibilScoreDate;
    // if(hitId!.isNotEmpty){
    //   cibilScoreResult.value = cibilScore!;
    // }
  }
}

class CibilResultArgs {
  String? hitId;
  String? cibilScore;
  String? cibilScoreDate;

  CibilResultArgs({this.hitId, this.cibilScore, this.cibilScoreDate});
}