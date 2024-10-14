class MyCartRequestEntity {
  SecuritiesRequestEntity? securities;
  String? cartName;
  String? loamName;
  String? pledgor_boid;
  String? loan_margin_shortfall_name;
  String? lender;
  String? instrumentType;
  String? schemeType;

  MyCartRequestEntity({
    this.securities,
    this.cartName,
    this.pledgor_boid,
    this.loan_margin_shortfall_name,
    this.instrumentType,
    this.schemeType,
    this.loamName,
    this.lender,
  });
}

class SecuritiesRequestEntity {
  List<SecuritiesListRequestEntity>? list;

  SecuritiesRequestEntity({this.list});
}

class SecuritiesListRequestEntity {
  String? isin;
  double? quantity;
  double? price;
  double? qty;

  SecuritiesListRequestEntity({
    this.isin,
    this.quantity,
    this.price,
    this.qty,
  });
}