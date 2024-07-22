import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/onboarding/data/models/onboarding_response_model.dart';

abstract class OnboardingApi {
  Future<OnBoardingResponseModel> getOnBoardingData();
}

class OnboardingApiImpl with BaseDio implements OnboardingApi {
  Future<OnBoardingResponseModel> getOnBoardingData() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.onBoarding);
      if (response.statusCode == 200) {
        return OnBoardingResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}
