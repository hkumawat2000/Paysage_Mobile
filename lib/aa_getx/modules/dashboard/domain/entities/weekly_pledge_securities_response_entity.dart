// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeeklyPledgeSecuritiesResponseEntity {
    String? messsage;
  List<WeeklyPLedgeDataResponseEntity>? weeklyPledgeData;
  WeeklyPledgeSecuritiesResponseEntity({
    this.messsage,
    this.weeklyPledgeData,
  });
}

class WeeklyPLedgeDataResponseEntity {
  int? week;
  double? weeklyAmountForAllLoans;
  WeeklyPLedgeDataResponseEntity({
    this.week,
    this.weeklyAmountForAllLoans,
  });
}
