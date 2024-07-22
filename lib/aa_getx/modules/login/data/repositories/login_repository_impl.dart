import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/login/data/data_sources/login_data_source.dart';
import 'package:lms/aa_getx/modules/login/data/models/request/login_submit_resquest_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/request/pin_screen_request_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/request/verify_otp_request_model.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/get_terms_and_privacy_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/pin_screen_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/repositories/login_repository.dart';

/// LoginRepositoryImpl is the concrete implementation of the LoginRepository
/// interface.
/// This class implements the methods defined in LoginRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource loginDataSource;
  LoginRepositoryImpl(this.loginDataSource);

  ResultFuture<GetTermsandPrivacyResponseEntity> getTermsAndPrivacyUrl() async {
    try {

      final termsAndPrivacyUrlResponse =
          await loginDataSource.getTermsAndPrivacyUrl();
      print("response : $termsAndPrivacyUrlResponse");
      return DataSuccess(termsAndPrivacyUrlResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  ResultFuture<AuthLoginResponseEntity> loginSubmit(
      LoginSubmitResquestEntity loginSubmitResquestEntity) async {
    try {
      LoginSubmitResquestModel loginSubmitResquestModel =
          LoginSubmitResquestModel.fromEntity(
              loginSubmitResquestEntity);
      final authLoginResponse =
          await loginDataSource.loginSubmit(loginSubmitResquestModel);
      return DataSuccess(authLoginResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

   ResultFuture<AuthLoginResponseEntity> verifyOtp(
      VerifyOtpRequestEntity verifyOtpRequestEntity) async {
    try {
      VerifyOtpRequestModel verifyOtpRequestModel =
          VerifyOtpRequestModel.fromEntity(
              verifyOtpRequestEntity);
      final authLoginResponse =
          await loginDataSource.verifyOtp(verifyOtpRequestModel);
      return DataSuccess(authLoginResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      // ErrorEntity eInfo = createErrorEntity(e);
      print("object Exception");
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    }
  }

  ResultFuture<AuthLoginResponseEntity> getPin(
      PinScreenRequestEntity pinScreenRequestEntity) async {
    try {
      PinScreenRequestModel pinScreenRequestModel =
      PinScreenRequestModel.fromEntity(
          pinScreenRequestEntity);
      final authLoginResponse =
      await loginDataSource.getPin(pinScreenRequestModel);
      return DataSuccess(authLoginResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      // ErrorEntity eInfo = createErrorEntity(e);
      print("object Exception");
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(UnknownFailure(e.toString(), 0));
    }
  }
}
