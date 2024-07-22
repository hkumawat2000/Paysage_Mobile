import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/registration/data/data_source/registration_api.dart';
import 'package:lms/aa_getx/modules/registration/data/repositories/registration_repository_impl.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';

import '../core/utils/connection_info.dart';

class InitialBinding implements Bindings {

  @override
  void dependencies() {

    /// Connectivity
    final Connectivity connectivity = Connectivity();
    Get.lazyPut<ConnectionInfo>(
          () => ConnectionInfoImpl(connectivity),
      fenix: true,
    );

    /// Registration API
    Get.lazyPut<RegistrationApi>(
          () => RegistrationApiImpl(),
      fenix: true,
    );

    Get.lazyPut<RegistrationRepositoryImpl>(
          () => RegistrationRepositoryImpl(
        Get.find(),
      ),
      fenix: true,
    );

  }

}