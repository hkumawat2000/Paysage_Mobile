import 'package:choice/account_setting//AccountSettingDao.dart';
import 'package:choice/network/responsebean/UpdateProfileAndPinResponseBean.dart';

class AccountSettingRepository {

  final accountSettingDao = AccountSettingDao();

  Future<UpdateProfileAndPinResponseBean> setProfileAndPin(updateProfileAndPinRequestBean) =>
      accountSettingDao.setProfileAndPin(updateProfileAndPinRequestBean);

}