import '../network/responsebean/OnboardingResponseBean.dart';
import 'TutorialScreenDao.dart';

class TutorialScreenRepository{

  final tutorialScreenDao = TutorialScreenDao();

  Future<OnBoardingResponseBean> getOnBoardingData() => tutorialScreenDao.getOnBoardingData();
}