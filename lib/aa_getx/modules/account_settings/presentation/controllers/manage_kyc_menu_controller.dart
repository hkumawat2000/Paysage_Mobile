import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/login/data/models/bank_account_model.dart';
import 'package:rxdart/rxdart.dart';

class ManageKycMenuController extends GetxController{
  final ConnectionInfo _connectionInfo;
  ManageKycMenuController(this._connectionInfo);

  RxList<BankAccount> bankAccountList = <BankAccount>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}