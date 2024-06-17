import 'package:lms/login/LoginDao.dart';
import 'package:lms/network/requestbean/FeedbackRequestBean.dart';
import 'package:lms/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:lms/network/responsebean/FeedbackResponse.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class FeedbackDao extends BaseDio {

  Future<AuthLoginResponse> submitFeedback(FeedbackRequestBean feedbackPopUpRequestBean) async {
    Dio dio = await getBaseDio();
    AuthLoginResponse wrapper = AuthLoginResponse();
    try {
      Response response = await dio.post(Constants.feedback, data: feedbackPopUpRequestBean.toJson());
      if (response.statusCode == 200) {
        wrapper = AuthLoginResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      }
      else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        if(e.response!.statusCode == 403) {
          wrapper.isSuccessFull = false;
          wrapper.errorCode = e.response!.statusCode!;
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.isSuccessFull = false;
          wrapper.errorCode = e.response!.statusCode!;
          wrapper.errorMessage = e.response!.data["message"];
        }
      }
    }
    return wrapper;
  }
}