import 'package:lms/aa_getx/core/utils/alert.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/onboarding/data/datasource/onboarding_api.dart';
import 'package:lms/aa_getx/modules/onboarding/data/models/onboarding_response_model.dart';
import 'package:lms/aa_getx/modules/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:lms/util/strings.dart';

class OnboardingRepositoryImpl implements OnboardingRepository{
   final OnboardingApi onboardingApi;
  final ConnectionInfo connectionInfo;

  OnboardingRepositoryImpl(
    this.onboardingApi,
    this.connectionInfo,
  );
  Future<OnBoardingResponseModel> getOnbaordingData() async{
    if(await connectionInfo.isConnected){
      final onboardingResponse = await onboardingApi.getOnBoardingData();
      return onboardingResponse;
    }else{
      Alert.showSnackBar(title: Strings.no_internet_message);
    }
    return OnBoardingResponseModel();
  }
 
}