import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/registration/data/data_source/registration_api.dart';
import 'package:lms/aa_getx/modules/registration/data/models/request/set_pin_request_model.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/auth_login_response_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/request/registration_request_bean_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/entities/request/set_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/registration/domain/repositories/registration_repository.dart';
import 'package:lms/aa_getx/modules/registration/data/models/request/registration_request_bean_model.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationApi registrationApi;

  RegistrationRepositoryImpl(
      this.registrationApi,
      );


  @override
  ResultFuture<AuthLoginResponseEntity> setPin(SetPinRequestEntity setPinRequestEntity) async {
    try {
      SetPinRequestModel setPinRequestModel = SetPinRequestModel.fromEntity(setPinRequestEntity);
      final response = await registrationApi.setPin(setPinRequestModel);
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
  ResultFuture<AuthLoginResponseEntity> submitRegistration(RegistrationRequestBeanEntity registrationRequestBeanEntity) async {
    try {
      RegistrationRequestBeanModel registrationRequestBeanModel = RegistrationRequestBeanModel.fromEntity(registrationRequestBeanEntity);
      final response = await registrationApi.submitRegistration(registrationRequestBeanModel);
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
