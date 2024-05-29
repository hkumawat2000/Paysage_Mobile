import 'package:lms/account_setting//AccountSettingDao.dart';
import 'package:lms/network/responsebean/UpdateProfileAndPinResponseBean.dart';

class AccountSettingRepository {

  final accountSettingDao = AccountSettingDao();

  Future<UpdateProfileAndPinResponseBean> setProfileAndPin(updateProfileAndPinRequestBean) =>
      accountSettingDao.setProfileAndPin(updateProfileAndPinRequestBean);

}