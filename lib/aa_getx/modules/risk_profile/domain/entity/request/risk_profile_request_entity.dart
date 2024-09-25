// ignore_for_file: public_member_api_docs, sort_constructors_first
class RishProfileRequestEntity {
  List<RiskProfileRequestDataEntity>? data;
  
  RishProfileRequestEntity({
    this.data,
  });
}

class RiskProfileRequestDataEntity {
  String? category;
  String? subCategory;
  
  RiskProfileRequestDataEntity({
    this.category,
    this.subCategory,
  });
}
