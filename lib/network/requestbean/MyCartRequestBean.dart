import 'dart:ffi';

class MyCartRequestBean {
  Securities? securities;
  String? cartName;
  String? loamName;
  String? pledgor_boid;
  String? loan_margin_shortfall_name;
  String? lender;
  String? instrumentType;
  String? schemeType;

  MyCartRequestBean({this.securities, this.cartName,this.pledgor_boid,this.loan_margin_shortfall_name, this.instrumentType, this.schemeType, this.loamName, this.lender});

  MyCartRequestBean.fromJson(Map<String, dynamic> json) {
    securities = json['securities'] != null
        ? new Securities.fromJson(json['securities'])
        : null;
    cartName = json['cart_name'];
    loamName = json['loan_name'];
    pledgor_boid = json['pledgor_boid'];
    loan_margin_shortfall_name = json['loan_margin_shortfall_name'];
    lender = json['lender'];
    instrumentType = json['instrument_type'];
    schemeType = json['scheme_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.securities != null) {
      data['securities'] = this.securities!.toJson();
    }
    data['cart_name'] = this.cartName;
    data['loan_name'] = this.loamName;
    data['pledgor_boid'] = this.pledgor_boid;
    data['loan_margin_shortfall_name'] = this.loan_margin_shortfall_name;
    data['lender'] = this.lender;
    data['instrument_type'] = this.instrumentType;
    data['scheme_type'] = this.schemeType;
    return data;
  }
}

class Securities {
  List<SecuritiesList>? list;

  Securities({this.list});

  Securities.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <SecuritiesList>[];
      json['list'].forEach((v) {
        list!.add(new SecuritiesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SecuritiesList {
  String? isin;
  double? quantity;
  double? price;
  double? qty;

  SecuritiesList({this.isin, this.quantity, this.price, this.qty});

  SecuritiesList.fromJson(Map<String, dynamic> json) {
    isin = json['isin'];
    quantity = json['quantity'];
    price = json['price'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isin'] = this.isin;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['qty'] = this.qty;
    return data;
  }
}