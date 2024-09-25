class GetRiskCategoryResponseEntity {
  String? message;
  List<RishCategoryDataEntity>? categoryDataList;

  GetRiskCategoryResponseEntity({this.message, this.categoryDataList});
}

class RishCategoryDataEntity {
  String? category;
  List<String>? subCategoryList;

  RishCategoryDataEntity({this.category, this.subCategoryList});

}