import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/aml_check/domain/usecases/aml_check_usecase.dart';

import '../../../../core/utils/connection_info.dart';

class AmlCheckController extends GetxController {

  final ConnectionInfo _connectionInfo;
  final AmlCheckUsecase amlCheckUsecase;

  AmlCheckController(this._connectionInfo, this.amlCheckUsecase);


  @override
  void onInit() {
    // callAMLCheckApi();
    super.onInit();
  }

  callAMLCheckApi() async {
    if (await _connectionInfo.isConnected) {
      print("Helloooo.....");
      amlCheckUsecase.call();
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}