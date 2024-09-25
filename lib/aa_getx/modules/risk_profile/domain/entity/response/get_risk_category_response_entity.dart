class GetRiskCategoryResponseEntity {
  String? message;
  List<CategoryData>? categoryDataList;

  GetRiskCategoryResponseEntity({this.message, this.categoryDataList});
}

class CategoryData {
  String? category;
  List<String>? subCategoryList;

  CategoryData({this.category, this.subCategoryList});

}