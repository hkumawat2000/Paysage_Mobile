import 'package:choice/network/ModelWrapper.dart';

class WeeklyPledgedSecurityResponse extends ModelWrapper<WeeklyData>{
  String? message;
  List<WeeklyData>? weeklyData;

  WeeklyPledgedSecurityResponse({this.message, this.weeklyData});

  WeeklyPledgedSecurityResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      weeklyData =  <WeeklyData>[];
      json['data'].forEach((v) {
        weeklyData!.add(new WeeklyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.weeklyData != null) {
      data['data'] = this.weeklyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WeeklyData {
  int? week;
  double? weeklyAmountForAllLoans;
//  int domainUpper;
//  int domainLower;

  WeeklyData({this.week, this.weeklyAmountForAllLoans});

  WeeklyData.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    weeklyAmountForAllLoans = json['weekly_amount_for_all_loans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['week'] = this.week;
    data['weekly_amount_for_all_loans'] = this.weeklyAmountForAllLoans;
    return data;
  }
}
