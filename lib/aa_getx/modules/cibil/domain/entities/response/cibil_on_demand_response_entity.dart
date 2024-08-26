// ignore_for_file: public_member_api_docs, sort_constructors_first
class CibilOnDemandResponseEntity {
  String? message;
  CibilOnDemandResponseDataEntity? cibilDataEntity;

  CibilOnDemandResponseEntity({
    this.message,
    this.cibilDataEntity,
  });
}

class CibilOnDemandResponseDataEntity {
  int? cibilScore;
  String? cibilScoreDate;

  CibilOnDemandResponseDataEntity({
    this.cibilScore,
    this.cibilScoreDate,
  });
}
