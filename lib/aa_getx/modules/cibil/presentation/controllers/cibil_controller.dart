import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';

class CibilController extends GetxController {
  final ConnectionInfo _connectionInfo;

  CibilController(this._connectionInfo);


  @override
  void onInit() {
    super.onInit();
  }

  Future<void> cibilCheckApi() async {
    if (await _connectionInfo.isConnected) {


    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }
}