// ignore_for_file: public_member_api_docs, sort_constructors_first
class RiskProfileResponseEntity {
  String? message;
  RiskPercentageDataResponseEnitty? data;
  
  RiskProfileResponseEntity({
    this.message,
    this.data,
  });
}

class RiskPercentageDataResponseEnitty {
  int? riskProfilePercentage;
  
  RiskPercentageDataResponseEnitty({
    this.riskProfilePercentage,
  });
}
