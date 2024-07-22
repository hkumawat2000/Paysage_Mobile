import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/login/data/models/auto_login_response.dart';
import 'package:lms/aa_getx/modules/login/data/models/get_terms_and_privacy_response_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/request/login_submit_resquest_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/request/pin_screen_request_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/request/verify_otp_request_model.dart';

/// LoginDataSource is an abstract class defining the contract for fetching
/// data from various sources.
/// This abstract class outlines the methods that concrete data source
/// implementations should implement, such as fetching data from a remote API, local database, or any other data source.
abstract class LoginDataSource {
  Future<GetTermsandPrivacyResponse> getTermsAndPrivacyUrl();
  Future<AuthLoginResponse> loginSubmit( LoginSubmitResquestModel loginSubmitResquestModel);
  Future<AuthLoginResponse> verifyOtp(VerifyOtpRequestModel verifyOtpRequestModel);
  Future<AuthLoginResponse> getPin(PinScreenRequestModel pinScreenRequestModel);

}

/// LoginDataSourceImpl is the concrete implementation of the LoginDataSource
/// interface.
/// This class implements the methods defined in LoginDataSource to fetch
/// data from a remote API or other data sources.
class LoginDataSourceImpl with BaseDio implements LoginDataSource {
  Future<GetTermsandPrivacyResponse> getTermsAndPrivacyUrl() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.termsOfUse);
      if (response.statusCode == 200) {
        return
            GetTermsandPrivacyResponse.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      // ErrorEntity eInfo = createErrorEntity(e);
      // print('Dio Exception Handler ${eInfo}');
      // throw eInfo;
      throw handleDioClientError(e);
    }
    }


  Future<AuthLoginResponse> loginSubmit(
      LoginSubmitResquestModel loginSubmitResquestModel
      ) async {
    Dio dio = await getBaseDioVersionPlatform();
    try {
      final response = await dio.post(
        Apis.logIn,
        data: loginSubmitResquestModel.toJson(),
      );
      if (response.statusCode == 200) {
       return AuthLoginResponse.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }


   Future<AuthLoginResponse> verifyOtp(
      VerifyOtpRequestModel verifyOtpRequestModel
      ) async {
    Dio dio = await getBaseDioVersionPlatform();
    try {
      final response = await dio.post(
        Apis.otpVerify,
        data: verifyOtpRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return AuthLoginResponse.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  Future<AuthLoginResponse> getPin(
      PinScreenRequestModel pinScreenRequestModel
      ) async {
    Dio dio = await getBaseDioVersionPlatform();
    try {
      final response = await dio.post(
        Apis.otpVerify,
        data: pinScreenRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return AuthLoginResponse.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

 
}
