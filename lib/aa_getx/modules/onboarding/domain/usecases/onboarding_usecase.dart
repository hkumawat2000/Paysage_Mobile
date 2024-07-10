import 'package:lms/aa_getx/core/utils/base_usecase.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/onboarding/domain/entity/onboarding_response_entity.dart';
import 'package:lms/aa_getx/modules/onboarding/domain/repositories/onboarding_repository.dart';

class GetOnboardingDetailsUsecase
    extends UsecaseWithoutParams<OnBoardingResponseEntity> {
  final OnboardingRepository onboardingRepository;

  GetOnboardingDetailsUsecase(this.onboardingRepository);

  @override
  ResultFuture<OnBoardingResponseEntity> call() async {
    return await onboardingRepository.getOnboardingData();
  }
}