import 'package:lms/network/requestbean/ContactUsRequestBean.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/LoginResponseBean.dart';
import 'package:lms/network/responsebean/ContactUsResponseBean.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class ContactUSDao extends BaseDio {
  Future<LoginResponseBean> contactUs(ContactUsRequestBean contactUsRequestBean) async {
    Dio dio = await getBaseDio();
    LoginResponseBean wrapper = LoginResponseBean();
    try {
      Response response = await dio.post(Constants.contactUs, data: contactUsRequestBean.toJson());
      if (response.statusCode == 200) {
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
        wrapper.errorCode = e.response!.statusCode!;
        wrapper.errorMessage = e.response!.statusMessage!;
      }
    }
    return wrapper;
  }

  Future<ContactUsResponseBean> getContactUsData(String search, int viewMore) async {
    Dio dio = await getBaseDio();
    ContactUsResponseBean wrapper = ContactUsResponseBean();
    try {
      Response response = await dio.get(Constants.contactUsOld,
          queryParameters: {ParametersConstants.search: search, ParametersConstants.viewMore: viewMore});
      if (response.statusCode == 200) {
        wrapper = ContactUsResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper = ContactUsResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        wrapper.errorMessage = e.response!.statusMessage!;
      }
    }
    return wrapper;
  }
}
