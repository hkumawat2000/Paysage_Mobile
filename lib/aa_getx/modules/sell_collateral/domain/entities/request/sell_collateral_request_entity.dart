
class SellCollateralRequestEntity {
  SecuritiesEntity? securities;
  String? loanName;
  String? otp;
  String? loanMarginShortfallName;


  SellCollateralRequestEntity({this.securities, this.loanName, this.otp,this.loanMarginShortfallName});
}

class SecuritiesEntity {
  List<SellListEntity>? list;

  SecuritiesEntity({this.list});
}

class SellListEntity {
  String? isin;
  String? folio;
  String? psn;
  double? quantity;

  SellListEntity({this.isin,this.folio,this.psn, this.quantity});
}