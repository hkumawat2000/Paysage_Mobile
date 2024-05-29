import 'dart:async';

import 'package:lms/network/requestbean/LogoutRequestBean.dart';
import 'package:lms/network/responsebean/LoginResponseBean.dart';
import 'package:lms/network/responsebean/ProfileListResponse.dart';
import 'package:lms/network/responsebean/ProfileResposoneBean.dart';
import 'package:lms/network/responsebean/TncResponseBean.dart';
import 'package:lms/profile/ProfileRepository.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class ProfileBloc {
  ProfileBloc();

  final profileRepository = ProfileRespository();
  final _profileController = StreamController<ProfileData>.broadcast();

  get profileData => _profileController.stream;

  Future<ProfileListResponse> getProfile() async {
    ProfileListResponse wrapper = await profileRepository.getProfile();
    if (wrapper.isSuccessFull!) {
      printLog("Sucees to get Profile");
      printLog("Sucees to get Profile:: ${wrapper.data![0].name}");
      setProfile(wrapper.data![0].name);
    } else {
      printLog("Fail to get Profile");
      _profileController.sink.addError(wrapper.errorMessage!);
    }
    return wrapper;
  }

  Future<ProfileResposoneBean> setProfile(customerName) async {
    ProfileResposoneBean wrapper = await profileRepository.setProfile(customerName);
    if (wrapper.isSuccessFull!) {
      printLog("Sucees to get Profile");
      _profileController.sink.add(wrapper.data!);
    } else {
      printLog("Fail to get Profile");
      _profileController.sink.addError(wrapper.errorMessage!);
    }
    return wrapper;
  }

  Future<LoginResponseBean> userLogout(LogoutRequestBean logoutRequestBean) async {
    LoginResponseBean wrapper = await profileRepository.userLogout(logoutRequestBean);
    return wrapper;
  }
}
