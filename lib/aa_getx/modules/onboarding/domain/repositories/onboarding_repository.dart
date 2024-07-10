import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/onboarding/domain/entity/onboarding_response_entity.dart';

abstract class OnboardingRepository {
  ResultFuture<OnBoardingResponseEntity> getOnbaordingData();
}
