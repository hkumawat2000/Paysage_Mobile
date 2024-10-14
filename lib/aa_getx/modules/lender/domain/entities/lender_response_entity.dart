
class LenderResponseEntity {
  String? message;
  List<LenderDataResponseEntity>? lenderData;

  LenderResponseEntity({this.message, this.lenderData});
}


class LenderDataResponseEntity {
  String? name;
  List<String>? levels;
  String? schemeType;

  LenderDataResponseEntity({this.name, this.levels, this.schemeType});
}