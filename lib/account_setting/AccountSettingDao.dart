import 'package:choice/network/requestbean/UpdateProfileAndPinRequestBean.dart';
import 'package:choice/network/responsebean/UpdateProfileAndPinResponseBean.dart';
import 'package:choice/util/base_dio.dart';
import 'package:choice/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:choice/util/base_dio.dart';
import 'package:choice/util/constants.dart';
import 'package:choice/util/strings.dart';
import 'package:dio/dio.dart';

class AccountSettingDao with BaseDio {

  Future<UpdateProfileAndPinResponseBean> setProfileAndPin(updateProfileAndPinRequestBean) async {
    Dio dio = await getBaseDio();
    UpdateProfileAndPinResponseBean wrapper = UpdateProfileAndPinResponseBean();
    try {
      Response response = await dio.post(Constants.updateProfileAndPin,
          data: updateProfileAndPinRequestBean);
      if (response.statusCode == 200) {
        wrapper = UpdateProfileAndPinResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        wrapper.errorMessage = Strings.server_error_message;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        wrapper.errorMessage = e.response!.data["message"];
      }
    }
    return wrapper;
  }

}