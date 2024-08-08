import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/aml_check/domain/entity/aml_check_response_entity.dart';
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

  Future<void> callAMLCheckApi() async {
    if (await _connectionInfo.isConnected) {

      DataState<AmlCheckResponseEntity> response =
      await amlCheckUsecase.call();

      if(response is DataSuccess){
        print("Helloooo.....");

      }else if (response is DataFailed){
        print('Failed AML Check');
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}