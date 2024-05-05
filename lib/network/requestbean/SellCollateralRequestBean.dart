class SellCollateralRequestBean {
  Securities? securities;
  String? loanName;
  String? otp;
  String? loanMarginShortfallName;


  SellCollateralRequestBean({this.securities, this.loanName, this.otp,this.loanMarginShortfallName});

  SellCollateralRequestBean.fromJson(Map<String, dynamic> json) {
    securities = json['securities'] != null
        ? new Securities.fromJson(json['securities'])
        : null;
    loanName = json['loan_name'];
    otp = json['otp'];
    loanMarginShortfallName = json['loan_margin_shortfall_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.securities != null) {
      data['securities'] = this.securities!.toJson();
    }
    data['loan_name'] = this.loanName;
    data['otp'] = this.otp;
    data['loan_margin_shortfall_name'] = this.loanMarginShortfallName;
    return data;
  }
}

class Securities {
  List<SellList>? list;

  Securities({this.list});

  Securities.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <SellList>[];
      json['list'].forEach((v) {
        list?.add(new SellList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SellList {
  String? isin;
  String? folio;
  String? psn;
  double? quantity;

  SellList({this.isin,this.folio,this.psn, this.quantity});

  SellList.fromJson(Map<String, dynamic> json) {
    isin = json['isin'];
    folio = json['folio'];
    psn = json['psn'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isin'] = this.isin;
    data['folio'] = this.folio;
    data['psn'] = this.psn;
    data['quantity'] = this.quantity;
    return data;
  }
}
