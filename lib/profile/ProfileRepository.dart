import 'package:lms/network/requestbean/LogoutRequestBean.dart';
import 'package:lms/network/responsebean/LoginResponseBean.dart';
import 'package:lms/network/responsebean/ProfileListResponse.dart';
import 'package:lms/network/responsebean/ProfileResposoneBean.dart';
import 'package:lms/network/responsebean/TncResponseBean.dart';
import 'package:lms/profile/ProfileDao.dart';

class ProfileRespository {
  final profileDao = ProfileDao();

  Future<ProfileListResponse> getProfile() => profileDao.getProfile();

  Future<ProfileResposoneBean> setProfile(customerName) => profileDao.setProfile(customerName);

  Future<LoginResponseBean> userLogout(LogoutRequestBean logoutRequestBean) => profileDao.userLogout(logoutRequestBean);
}
