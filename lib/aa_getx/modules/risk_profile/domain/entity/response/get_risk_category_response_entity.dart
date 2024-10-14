class GetRiskCategoryResponseEntity {
  String? message;
  List<RiskCategoryDataEntity>? categoryDataList;

  GetRiskCategoryResponseEntity({this.message, this.categoryDataList});
}

class RiskCategoryDataEntity {
  String? category;
  List<String>? subCategoryList;

  RiskCategoryDataEntity({this.category, this.subCategoryList});

}