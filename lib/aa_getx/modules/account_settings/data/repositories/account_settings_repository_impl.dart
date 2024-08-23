import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/account_settings/data/data_sources/account_settings_data_source.dart';
import 'package:lms/aa_getx/modules/account_settings/data/models/request/update_profile_and_pin_request_model.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/request/update_profile_and_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/update_profile_and_pin_response_entity.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/repositories/account_settings_repository.dart';

/// AccountSettingsRepositoryImpl is the concrete implementation of the AccountSettingsRepository
/// interface.
/// This class implements the methods defined in AccountSettingsRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class AccountSettingsRepositoryImpl implements AccountSettingsRepository {
      
   final AccountSettingsDataSource  accountSettingsDataSource;
   AccountSettingsRepositoryImpl(this.accountSettingsDataSource);


   ResultFuture<UpdateProfileAndPinResponseEntity> updateProfilePicAndPin(
      UpdateProfileAndPinRequestEntity updateProfileAndPinRequestEntity) async {
    try {
      UpdateProfileAndPinRequestModel updateProfileAndPinRequestModel =
          UpdateProfileAndPinRequestModel.fromEntity(updateProfileAndPinRequestEntity);
      final updateProfileAndPinResponse =
          await accountSettingsDataSource.updateProfilePicAndPin(updateProfileAndPinRequestModel);
      return DataSuccess(updateProfileAndPinResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

}