import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/onboarding/data/datasource/onboarding_api.dart';
import 'package:lms/aa_getx/modules/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:lms/aa_getx/modules/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:lms/aa_getx/modules/onboarding/domain/usecases/onboarding_usecase.dart';
import 'package:lms/aa_getx/modules/onboarding/presentation/controllers/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingApiImpl>(
      () => OnboardingApiImpl(),
    );

    Get.lazyPut<OnboardingRepositoryImpl>(
      () => OnboardingRepositoryImpl(
        Get.find<OnboardingApiImpl>(),
        Get.find<ConnectionInfo>(),
      ),
    );

    Get.lazyPut<GetOnboardingDetailsUsecase>(
        () => GetOnboardingDetailsUsecase(Get.find<OnboardingRepositoryImpl>()));

    Get.lazyPut<SplashController>(() => SplashController(
          Get.find<GetOnboardingDetailsUsecase>(),
          Get.find<ConnectionInfo>(),
        ));
  }
}
