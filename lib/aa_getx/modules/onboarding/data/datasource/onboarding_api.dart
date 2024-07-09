import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/onboarding/data/models/onboarding_response_model.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';

abstract class OnboardingApi {
  Future<OnBoardingResponseModel> getOnBoardingData();
}

class OnboardingApiImpl with BaseDio implements OnboardingApi {
  Future<OnBoardingResponseModel> getOnBoardingData() async {
    Dio dio = await getBaseDio();
    OnBoardingResponseModel onBoardingResponseModel = OnBoardingResponseModel();
    try {
      final response = await dio.get(Apis.onBoarding);
      if (response.statusCode == 200) {
        onBoardingResponseModel =
            OnBoardingResponseModel.fromJson(response.data);
        onBoardingResponseModel.isSuccessFull = true;
      } else {
        onBoardingResponseModel.isSuccessFull = false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        onBoardingResponseModel.isSuccessFull = false;
        onBoardingResponseModel.errorMessage = Strings.server_error_message;
        onBoardingResponseModel.errorCode = Constants.noInternet;
      } else {
        onBoardingResponseModel.isSuccessFull = false;
        onBoardingResponseModel.errorCode = e.response!.statusCode;
        onBoardingResponseModel.errorMessage =
            e.response!.data["message"] ?? Strings.something_went_wrong;
      }
    }
    return onBoardingResponseModel;
  }

}
