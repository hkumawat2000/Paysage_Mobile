import '../network/responsebean/OnboardingResponseBean.dart';
import 'TutorialScreenRepository.dart';

class TutorialScreenBloc{

  final tutorialScreenRepository = TutorialScreenRepository();

  Future<OnBoardingResponseBean> getOnBoardingData() async {
    OnBoardingResponseBean wrapper = await tutorialScreenRepository.getOnBoardingData();
    return wrapper;
  }
}