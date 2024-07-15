import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/login/data/models/auto_login_response.dart';
import 'package:lms/aa_getx/modules/login/data/models/get_terms_and_privacy_response_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/request/login_submit_resquest_model.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/widgets/WidgetCommon.dart';

/// LoginDataSource is an abstract class defining the contract for fetching
/// data from various sources.
/// This abstract class outlines the methods that concrete data source
/// implementations should implement, such as fetching data from a remote API, local database, or any other data source.
abstract class LoginDataSource {
  Future<GetTermsandPrivacyResponse> getTermsAndPrivacyUrl();
  Future<AuthLoginResponse> loginSubmit( LoginSubmitResquestModel loginSubmitResquestModel);
}

/// LoginDataSourceImpl is the concrete implementation of the LoginDataSource
/// interface.
/// This class implements the methods defined in LoginDataSource to fetch
/// data from a remote API or other data sources.
class LoginDataSourceImpl with BaseDio implements LoginDataSource {
  Future<GetTermsandPrivacyResponse> getTermsAndPrivacyUrl() async {
    Dio dio = await getBaseDio();
    GetTermsandPrivacyResponse getTermsandPrivacyResponse =
        GetTermsandPrivacyResponse();
    try {
      final response = await dio.get(Apis.termsOfUse);
      if (response.statusCode == 200) {
        getTermsandPrivacyResponse =
            GetTermsandPrivacyResponse.fromJson(response.data);
        getTermsandPrivacyResponse.isSuccessFull = true;
      } else {
        getTermsandPrivacyResponse.isSuccessFull = false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        getTermsandPrivacyResponse.isSuccessFull = false;
        getTermsandPrivacyResponse.errorMessage = Strings.server_error_message;
        getTermsandPrivacyResponse.errorCode = Constants.noInternet;
      } else {
        getTermsandPrivacyResponse.isSuccessFull = false;
        getTermsandPrivacyResponse.errorCode = e.response!.statusCode;
        getTermsandPrivacyResponse.errorMessage =
            e.response!.data["message"] ?? Strings.something_went_wrong;
      }
    }
    return getTermsandPrivacyResponse;
  }

  Future<AuthLoginResponse> loginSubmit(
      LoginSubmitResquestModel loginSubmitResquestModel
      //dynamic mobileNumber, firebase_token, acceptTerms
      ) async {
    Dio dio = await getBaseDioVersionPlatform();
    String? deviceInfo = await getDeviceInfo();
    String versionName = await Utility.getVersionInfo();
    AuthLoginResponse authLoginResponse = AuthLoginResponse();
    try {
      final response = await dio.post(
        Apis.logIn,
        data: loginSubmitResquestModel.toJson(),
      );
      if (response.statusCode == 200) {
        authLoginResponse = AuthLoginResponse.fromJson(response.data);
        authLoginResponse.isSuccessFull = true;
      } else {
        authLoginResponse.isSuccessFull = false;
      }
    } on DioException catch (e) {
      if (e.response == null) {
        authLoginResponse.isSuccessFull = false;
        authLoginResponse.errorMessage = Strings.server_error_message;
        authLoginResponse.errorCode = Constants.noInternet;
      } else {
        authLoginResponse.isSuccessFull = false;
        authLoginResponse.errorCode = e.response!.statusCode;
        authLoginResponse.errorMessage =
            e.response!.data["message"] ?? Strings.something_went_wrong;
      }
    }
    return authLoginResponse;
  }

  // @override
  // Future<GetTermsandPrivacyResponse> getCustomerDetails(
  //     String customerCode) async {
  //   Dio dio = await getBaseDio();

  //   Response<Map<String, dynamic>> response = await dio.get(Constants
  //       .getCustomerDetails
  //       .replaceFirst("{customerCode}", customerCode)
  //       .replaceFirst("{user_code}", Constants.userCode));

  //   if (response.statusCode == 200) {
  //     CustomerDetailsResponseModel customerDetailsResponseModel =
  //         CustomerDetailsResponseModel.fromJson(response.data!);

  //     return customerDetailsResponseModel;
  //   } else {
  //     throw ServerException(response.data?['error']['message']);
  //   }
  // }
}
