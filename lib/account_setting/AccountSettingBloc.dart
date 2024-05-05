import 'package:choice/account_setting/AccountSettingRepository.dart';
import 'package:choice/network/responsebean/UpdateProfileAndPinResponseBean.dart';

class AccountSettingBloc {

  final accountSettingRepository = AccountSettingRepository();

  Future<UpdateProfileAndPinResponseBean> setProfileAndPin(updateProfileAndPinRequestBean) async {
    UpdateProfileAndPinResponseBean wrapper = await accountSettingRepository.setProfileAndPin(updateProfileAndPinRequestBean);
    return wrapper;
  }
}