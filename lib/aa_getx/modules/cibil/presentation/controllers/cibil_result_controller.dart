import 'package:get/get.dart';

class CibilResultController extends GetxController {

  CibilResultArgs cibilResultArgs = Get.arguments;
  String? hitId;
  String? cibilScore;

  RxString cibilScoreResult = "".obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }


  getArgument(){
    hitId = cibilResultArgs.hitId;
    cibilScore = cibilResultArgs.cibilScore;
    if(hitId!.isNotEmpty){
      cibilScoreResult.value = cibilScore!;
    }
  }
}

class CibilResultArgs {
  String? hitId;
  String? cibilScore;

  CibilResultArgs({this.hitId, this.cibilScore});
}