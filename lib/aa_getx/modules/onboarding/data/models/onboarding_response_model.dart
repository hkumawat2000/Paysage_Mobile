// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/onboarding/domain/entity/onboarding_response_entity.dart';
import 'package:lms/network/ModelWrapper.dart';

class OnBoardingResponseModel  {
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

  // factory OnBoardingResponseModel.fromJson(Map<String, dynamic> json) {
  //   return OnBoardingResponseModel(
  //     onBoardingData: json['message'] != null
  //         ? List<OnBoardingData>.from(
  //             (json['message'] as List<dynamic>).map<OnBoardingData>(
  //               (item) => OnBoardingData.fromJson(item as Map<String, dynamic>),
  //             ),
  //           )
  //         : null,
  //   );
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.onBoardingData != null) {
      data['message'] = this.onBoardingData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  OnBoardingResponseEntity toEntity() => OnBoardingResponseEntity(
        onBoardingData: onBoardingData != null
            ? onBoardingData!.map((x) => x.toEntity()).toList()
            : null,
      );
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

  OnBoardingDataEntity toEntity() => OnBoardingDataEntity(
        screenNo: screenNo,
        title: title,
        description: description,
      );
}
