import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/aml_check/data/data_source/aml_data_source.dart';
import 'package:lms/aa_getx/modules/aml_check/data/repositories/aml_check_repository_impl.dart';
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



    /// AML Check
    Get.lazyPut<AmlCheckDataSourceApi>(
          () => AmlDataSourceApiImp(),
      fenix: true,
    );

    Get.lazyPut<AmlCheckRepositoryImpl>(
          () => AmlCheckRepositoryImpl(
        Get.find(),
      ),
      fenix: true,
    );
  }

}