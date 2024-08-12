class AmlCheckResponseEntity {
  String? message;
  AmlDataEntity? amlData;

  AmlCheckResponseEntity({this.message, this.amlData});
}

class AmlDataEntity {
  int? hitCount;

  AmlDataEntity({this.hitCount});
}