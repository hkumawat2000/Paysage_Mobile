class MfSchemeResponseEntity {
  MFSchemeDataResponseEntity? mfSchemeDataResponseModel;
  MfSchemeResponseEntity({
    this.mfSchemeDataResponseModel,
  });
}

class MFSchemeDataResponseEntity {
  List<SchemesListEntity>? schemesListEntity;

  MFSchemeDataResponseEntity({
    this.schemesListEntity,
  });
}


class SchemesListEntity {
  String? isin;
  String? schemeName;
  double? ltv;
  String? instrumentType;
  String? schemeType;
  double? price;
  String? lenders;
  String? amcCode;
  String? amcImage;
  double? units;
  double? schemeValue;
  double? eligibleLoanAmount;

  SchemesListEntity(
      {this.isin,
      this.schemeName,
      this.ltv,
      this.instrumentType,
      this.schemeType,
      this.price,
      this.lenders,
      this.amcCode,
      this.amcImage,
      this.units,
      this.schemeValue,
      this.eligibleLoanAmount});
}