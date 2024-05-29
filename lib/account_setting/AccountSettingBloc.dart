import 'package:lms/account_setting/AccountSettingRepository.dart';
import 'package:lms/network/responsebean/UpdateProfileAndPinResponseBean.dart';

class AccountSettingBloc {

  final accountSettingRepository = AccountSettingRepository();

  Future<UpdateProfileAndPinResponseBean> setProfileAndPin(updateProfileAndPinRequestBean) async {
    UpdateProfileAndPinResponseBean wrapper = await accountSettingRepository.setProfileAndPin(updateProfileAndPinRequestBean);
    return wrapper;
  }
}