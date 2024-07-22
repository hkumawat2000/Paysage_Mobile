import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/registration/data/data_source/registration_api.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/auth_login_response_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/repositories/registration_repository.dart';
import 'package:lms/aa_getx/modules/registration/domain/usecases/set_pin_usecase.dart';
import 'package:lms/aa_getx/modules/registration/presentation/arguments/registration_request_bean.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationApi registrationApi;

  RegistrationRepositoryImpl(
      this.registrationApi,
      );


  @override
  ResultFuture<AuthLoginResponseEntity> setPin(SetPinParams params) async {
    try {
      final response = await registrationApi.setPin(params);
      return DataSuccess(response.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg,0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(),0));
    }
  }

  @override
  ResultFuture<AuthLoginResponseEntity> submitRegistration(RegistrationRequestBean params) async {
    try {
      final response = await registrationApi.submitRegistration(params);
      return DataSuccess(response.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg,0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(),0));
    }
  }

}
