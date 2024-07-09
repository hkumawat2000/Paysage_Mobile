import 'package:lms/network/ModelWrapper.dart';

class OnBoardingResponseModel extends ModelWrapper<List<OnBoardingData>>{
  List<OnBoardingData>? onBoardingData;

  OnBoardingResponseModel({this.onBoardingData});

  OnBoardingResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      onBoardingData = <OnBoardingData>[];
      json['message'].forEach((v) {
        onBoardingData!.add(new OnBoardingData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onBoardingData != null) {
      data['message'] = this.onBoardingData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OnBoardingData {
  String? screenNo;
  String? title;
  String? description;

  OnBoardingData({this.screenNo, this.title, this.description});

  OnBoardingData.fromJson(Map<String, dynamic> json) {
    screenNo = json['screen_no'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['screen_no'] = this.screenNo;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
