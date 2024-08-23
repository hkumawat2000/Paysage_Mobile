import 'dart:convert';

import 'package:lms/aa_getx/modules/dashboard/domain/entities/weekly_pledge_securities_response_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeeklyPledgeSecuritiesResponseModel {
  String? messsage;
  List<WeeklyPLedgeDataResponseModel>? weeklyPledgeData;
  WeeklyPledgeSecuritiesResponseModel({
    this.messsage,
    this.weeklyPledgeData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messsage': messsage,
      'data': weeklyPledgeData!.map((x) => x?.toMap()).toList(),
    };
  }

  factory WeeklyPledgeSecuritiesResponseModel.fromMap(Map<String, dynamic> map) {
    return WeeklyPledgeSecuritiesResponseModel(
      messsage: map['messsage'] != null ? map['messsage'] as String : null,
      weeklyPledgeData: map['data'] != null ? List<WeeklyPLedgeDataResponseModel>.from((map['data'] as List<int>).map<WeeklyPLedgeDataResponseModel?>((x) => WeeklyPLedgeDataResponseModel.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeeklyPledgeSecuritiesResponseModel.fromJson(String source) => WeeklyPledgeSecuritiesResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  WeeklyPledgeSecuritiesResponseEntity toEntity() =>
  WeeklyPledgeSecuritiesResponseEntity(
      messsage: messsage,
      weeklyPledgeData: weeklyPledgeData?.map((x) => x.toEntity()).toList(),
  
  );

  factory WeeklyPledgeSecuritiesResponseModel.fromEntity(WeeklyPledgeSecuritiesResponseEntity weeklyPledgeSecuritiesResponseEntity) {
    return WeeklyPledgeSecuritiesResponseModel(
      messsage: weeklyPledgeSecuritiesResponseEntity.messsage != null ? weeklyPledgeSecuritiesResponseEntity.messsage as String : null,
      weeklyPledgeData: weeklyPledgeSecuritiesResponseEntity.weeklyPledgeData != null ? List<WeeklyPLedgeDataResponseModel>.from((weeklyPledgeSecuritiesResponseEntity.weeklyPledgeData as List<dynamic>).map<WeeklyPLedgeDataResponseModel?>((x) => WeeklyPLedgeDataResponseModel.fromEntity(x as WeeklyPLedgeDataResponseEntity),),) : null,
    );
  }
}

class WeeklyPLedgeDataResponseModel {
  int? week;
  double? weeklyAmountForAllLoans;
  WeeklyPLedgeDataResponseModel({
    this.week,
    this.weeklyAmountForAllLoans,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'week': week,
      'weekly_amount_for_all_loans': weeklyAmountForAllLoans,
    };
  }

  factory WeeklyPLedgeDataResponseModel.fromMap(Map<String, dynamic> map) {
    return WeeklyPLedgeDataResponseModel(
      week: map['week'] != null ? map['week'] as int : null,
      weeklyAmountForAllLoans: map['weekly_amount_for_all_loans'] != null ? map['weekly_amount_for_all_loans'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeeklyPLedgeDataResponseModel.fromJson(String source) => WeeklyPLedgeDataResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  WeeklyPLedgeDataResponseEntity toEntity() =>
  WeeklyPLedgeDataResponseEntity(
      week: week,
      weeklyAmountForAllLoans: weeklyAmountForAllLoans,
  
  );

  factory WeeklyPLedgeDataResponseModel.fromEntity(WeeklyPLedgeDataResponseEntity weeklyPledgeDataResponseEntity) {
    return WeeklyPLedgeDataResponseModel(
      week: weeklyPledgeDataResponseEntity.week != null ? weeklyPledgeDataResponseEntity.week as int : null,
      weeklyAmountForAllLoans: weeklyPledgeDataResponseEntity.weeklyAmountForAllLoans != null ? weeklyPledgeDataResponseEntity.weeklyAmountForAllLoans as double : null,
    );
  }
}
