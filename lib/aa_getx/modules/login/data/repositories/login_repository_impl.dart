import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/login/data/data_sources/login_data_source.dart';
import 'package:lms/aa_getx/modules/login/data/models/request/login_submit_resquest_model.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/get_terms_and_privacy_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/repositories/login_repository.dart';
import 'package:lms/network/responsebean/AuthResponse/AuthLoginResponse.dart';

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
      return DataSuccess(termsAndPrivacyUrlResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on DioException catch (e) {
      return DataFailed(DioErrorHandler.handleDioError(e));
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
    } on DioException catch (e) {
      return DataFailed(DioErrorHandler.handleDioError(e));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }
}
