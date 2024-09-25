// ignore_for_file: public_member_api_docs, sort_constructors_first
class RishProfileResponseEntity {
  String? message;
  RiskPercentageDataResponseEnitty? data;
  
  RishProfileResponseEntity({
    this.message,
    this.data,
  });
}

class RiskPercentageDataResponseEnitty {
  String? riskProfilePercentage;
  
  RiskPercentageDataResponseEnitty({
    this.riskProfilePercentage,
  });
}
