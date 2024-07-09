import 'package:lms/aa_getx/modules/onboarding/data/models/onboarding_response_model.dart';

abstract class OnboardingRepository {
  Future<OnBoardingResponseModel> getOnbaordingData();
}
