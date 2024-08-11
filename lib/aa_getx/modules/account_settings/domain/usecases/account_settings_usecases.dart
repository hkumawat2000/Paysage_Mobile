import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/request/update_profile_and_pin_request_entity.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/entities/update_profile_and_pin_response_entity.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/repositories/account_settings_repository.dart';

/// use case is a class responsible for encapsulating a specific piece of business logic or
/// a particular operation that your application needs to perform.
/// It acts as a bridge between the presentation
/// layer and the data layer.
class AccountSettingsUseCase
    implements
        UsecaseWithParams<UpdateProfileAndPinResponseEntity,
            UpdateProfileAndPinRequestParams> {
  final AccountSettingsRepository accountSettingsRepository;
  AccountSettingsUseCase(this.accountSettingsRepository);

  @override
  ResultFuture<UpdateProfileAndPinResponseEntity> call(params) async {
    return await accountSettingsRepository.updateProfilePicAndPin(params.updateProfileAndPinRequestEntity);
  }
}

class UpdateProfileAndPinRequestParams {
  final UpdateProfileAndPinRequestEntity updateProfileAndPinRequestEntity;
  UpdateProfileAndPinRequestParams({
    required this.updateProfileAndPinRequestEntity,
  });
}
