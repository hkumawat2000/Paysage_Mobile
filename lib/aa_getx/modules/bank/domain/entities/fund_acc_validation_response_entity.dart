
class FundAccValidationResponseEntity{
  String? message;
  FundAccValidationDataEntity? fundAccValidationData;

  FundAccValidationResponseEntity({this.message, this.fundAccValidationData});
}

class FundAccValidationDataEntity {
  String? favId;
  String? status;

  FundAccValidationDataEntity({this.favId, this.status});
}