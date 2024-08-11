import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/request/update_profile_and_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/update_profile_and_pin_response_entity.dart';

/// AccountSettingsRepository is an abstract class defining the contract for operations
/// related to data within the domain layer.
/// Concrete implementations of this repository interface will be provided
/// in the data layer to interact with specific data sources (e.g., API, database).
abstract class AccountSettingsRepository {

ResultFuture<UpdateProfileAndPinResponseEntity> updateProfilePicAndPin(
      UpdateProfileAndPinRequestEntity updateProfileAndPinRequestEntity);

}