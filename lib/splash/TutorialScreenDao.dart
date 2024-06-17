import 'package:dio/dio.dart';

import '../network/responsebean/OnboardingResponseBean.dart';
import '../util/base_dio.dart';
import '../util/constants.dart';
import '../util/strings.dart';

class TutorialScreenDao extends BaseDio {

  Future<OnBoardingResponseBean> getOnBoardingData() async {
    Dio dio = await getBaseDio();
    OnBoardingResponseBean wrapper = OnBoardingResponseBean();
    try {
      Response response = await dio.get(Constants.onBoarding);
      if (response.statusCode == 200) {
        wrapper = OnBoardingResponseBean.fromJson(response.data);
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
        if (e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }
}