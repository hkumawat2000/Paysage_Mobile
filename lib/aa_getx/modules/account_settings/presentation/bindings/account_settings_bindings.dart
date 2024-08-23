import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/account_settings/data/data_sources/account_settings_data_source.dart';
import 'package:lms/aa_getx/modules/account_settings/data/repositories/account_settings_repository_impl.dart';
import 'package:lms/aa_getx/modules/account_settings/domain/usecases/account_settings_usecases.dart';
import 'package:lms/aa_getx/modules/account_settings/presentation/controllers/account_settings_controller.dart';
import 'package:lms/aa_getx/modules/login/data/data_sources/login_data_source.dart';
import 'package:lms/aa_getx/modules/login/data/repositories/login_repository_impl.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/get_profile_and_set_alert_usecase.dart';

class AccountSettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountSettingsDataSourceImpl>(
      () => AccountSettingsDataSourceImpl(),
    );
    Get.lazyPut<AccountSettingsRepositoryImpl>(
      () => AccountSettingsRepositoryImpl(
        Get.find<AccountSettingsDataSourceImpl>(),
      ),
    );

    Get.lazyPut<AccountSettingsUseCase>(
        () => AccountSettingsUseCase(Get.find<AccountSettingsRepositoryImpl>()));

    // Login Dependencisy added for GetProfileUsecase
     Get.lazyPut<LoginDataSourceImpl>(
      () => LoginDataSourceImpl(),
    );

    Get.lazyPut<LoginRepositoryImpl>(
      () => LoginRepositoryImpl(
        Get.find<LoginDataSourceImpl>(),
      ),
    );
    Get.lazyPut<GetProfileAndSetAlertUsecase>(
        () => GetProfileAndSetAlertUsecase(Get.find<LoginRepositoryImpl>()));

    Get.lazyPut(() => AccountSettingsController(
          Get.find<ConnectionInfo>(),
          Get.find<AccountSettingsUseCase>(),
          Get.find<GetProfileAndSetAlertUsecase>(),
        ));
  }
}
