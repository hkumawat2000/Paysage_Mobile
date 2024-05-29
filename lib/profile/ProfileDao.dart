import 'package:lms/network/requestbean/LogoutRequestBean.dart';
import 'package:lms/network/responsebean/LoginResponseBean.dart';
import 'package:lms/network/responsebean/ProfileListResponse.dart';
import 'package:lms/network/responsebean/ProfileResposoneBean.dart';
import 'package:lms/network/responsebean/TncResponseBean.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:dio/dio.dart';

class ProfileDao with BaseDio {
  Future<ProfileListResponse> getProfile() async {
    Dio dio = await getBaseDio();
    ProfileListResponse wrapper = ProfileListResponse();

    try {
      Response response = await dio.get(
        'api/resource/Customer',
      );
      if (response.statusCode == 200) {
        wrapper = ProfileListResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        wrapper.errorMessage = e.response!.statusMessage;
      }
    }
    return wrapper;
  }

  Future<ProfileResposoneBean> setProfile(customerName) async {
    Dio dio = await getBaseDio();
    ProfileResposoneBean wrapper = ProfileResposoneBean();
    try {
      Response response = await dio.get(
        'api/resource/Customer/$customerName',
      );
      if (response.statusCode == 200) {
        wrapper = ProfileResposoneBean.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        wrapper.errorMessage = e.response!.statusMessage;
      }
    }
    return wrapper;
  }

  Future<LoginResponseBean> userLogout(LogoutRequestBean logoutRequestBean) async {
    Dio dio = await getBaseDio();
    LoginResponseBean wrapper = LoginResponseBean();
    wrapper.isSuccessFull = false;
    try {
      Response response =
          await dio.post('api/method/lms.auth.logout', data: logoutRequestBean.toJson());
      if (response.statusCode == 200) {
        wrapper = LoginResponseBean.fromJson(response.data);
        if (wrapper.message!.status == 200) {
          wrapper.isSuccessFull = true;
        } else if (wrapper.message!.status == 422) {
          wrapper.isSuccessFull = false;
        }
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      printLog(e.toString());
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode;
        wrapper.errorMessage = e.response!.statusMessage;
      }
    }
    return wrapper;
  }
}
