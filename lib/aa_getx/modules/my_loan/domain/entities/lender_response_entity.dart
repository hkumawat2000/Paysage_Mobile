
class LenderResponseEntity {
  String? message;
  List<LenderDataEntity>? lenderData;

  LenderResponseEntity({this.message, this.lenderData});
}

class LenderDataEntity {
  String? name;
  List<String>? levels;
  String? schemeType;

  LenderDataEntity({this.name, this.levels, this.schemeType});
}