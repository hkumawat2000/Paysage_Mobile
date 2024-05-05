import 'package:choice/network/requestbean/LogoutRequestBean.dart';
import 'package:choice/network/responsebean/LoginResponseBean.dart';
import 'package:choice/network/responsebean/ProfileListResponse.dart';
import 'package:choice/network/responsebean/ProfileResposoneBean.dart';
import 'package:choice/network/responsebean/TncResponseBean.dart';
import 'package:choice/profile/ProfileDao.dart';

class ProfileRespository {
  final profileDao = ProfileDao();

  Future<ProfileListResponse> getProfile() => profileDao.getProfile();

  Future<ProfileResposoneBean> setProfile(customerName) => profileDao.setProfile(customerName);

  Future<LoginResponseBean> userLogout(LogoutRequestBean logoutRequestBean) => profileDao.userLogout(logoutRequestBean);
}
