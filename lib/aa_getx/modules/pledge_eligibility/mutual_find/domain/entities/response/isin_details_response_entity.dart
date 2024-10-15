class IsinDetailResponseEntity {
  String? message;
  IsinDetailsDataResponseEntity? data;

  IsinDetailResponseEntity({this.message, this.data});
}

class IsinDetailsDataResponseEntity {
  List<IsinDetailsResponseEntity>? isinDetails;

  IsinDetailsDataResponseEntity({this.isinDetails});
}

class IsinDetailsResponseEntity {
  String? isin;
  double? ltv;
  String? category;
  String? name;
  double? minimumSanctionedLimit;
  double? maximumSanctionedLimit;
  double? rateOfInterest;

  IsinDetailsResponseEntity({
    this.isin,
    this.ltv,
    this.category,
    this.name,
    this.minimumSanctionedLimit,
    this.maximumSanctionedLimit,
    this.rateOfInterest,
  });
}
