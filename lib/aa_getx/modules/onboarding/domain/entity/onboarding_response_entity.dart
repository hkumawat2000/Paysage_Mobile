import 'package:lms/network/ModelWrapper.dart';

class OnBoardingResponseEntity extends ModelWrapper<List<OnBoardingDataEntity>>{
  List<OnBoardingDataEntity>? onBoardingData;

  OnBoardingResponseEntity({this.onBoardingData});

}

class OnBoardingDataEntity {
  String? screenNo;
  String? title;
  String? description;

  OnBoardingDataEntity({this.screenNo, this.title, this.description});

  
}
