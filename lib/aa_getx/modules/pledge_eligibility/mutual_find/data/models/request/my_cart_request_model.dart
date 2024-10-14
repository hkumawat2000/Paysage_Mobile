// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/my_cart_request_entity.dart';

class MyCartRequestModel {
  SecuritiesRequestModel? securities;
  String? cartName;
  String? loamName;
  String? pledgor_boid;
  String? loan_margin_shortfall_name;
  String? lender;
  String? instrumentType;
  String? schemeType;

  MyCartRequestModel({
    this.securities,
    this.cartName,
    this.pledgor_boid,
    this.loan_margin_shortfall_name,
    this.instrumentType,
    this.schemeType,
    this.loamName,
    this.lender,
  });

  MyCartRequestModel.fromJson(Map<String, dynamic> json) {
    securities = json['securities'] != null
        ? new SecuritiesRequestModel.fromJson(json['securities'])
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

  factory MyCartRequestModel.fromEntity(
      MyCartRequestEntity myCartRequestEntity) {
    return MyCartRequestModel(
      securities: myCartRequestEntity.securities != null
          ? SecuritiesRequestModel.fromEntity(
              myCartRequestEntity.securities as SecuritiesRequestEntity)
          : null,
      cartName: myCartRequestEntity.cartName != null
          ? myCartRequestEntity.cartName as String
          : null,
      loamName: myCartRequestEntity.loamName != null
          ? myCartRequestEntity.loamName as String
          : null,
      pledgor_boid: myCartRequestEntity.pledgor_boid != null
          ? myCartRequestEntity.pledgor_boid as String
          : null,
      loan_margin_shortfall_name:
          myCartRequestEntity.loan_margin_shortfall_name != null
              ? myCartRequestEntity.loan_margin_shortfall_name as String
              : null,
      lender: myCartRequestEntity.lender != null
          ? myCartRequestEntity.lender as String
          : null,
      instrumentType: myCartRequestEntity.instrumentType != null
          ? myCartRequestEntity.instrumentType as String
          : null,
      schemeType: myCartRequestEntity.schemeType != null
          ? myCartRequestEntity.schemeType as String
          : null,
    );
  }
}

class SecuritiesRequestModel {
  List<SecuritiesListRequestModel>? list;

  SecuritiesRequestModel({this.list});

  SecuritiesRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <SecuritiesListRequestModel>[];
      json['list'].forEach((v) {
        list!.add(new SecuritiesListRequestModel.fromJson(v));
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

  factory SecuritiesRequestModel.fromEntity(
      SecuritiesRequestEntity securitiesRequestEntity) {
    return SecuritiesRequestModel(
      list: securitiesRequestEntity.list != null
          ? List<SecuritiesListRequestModel>.from(
              (securitiesRequestEntity.list as List<dynamic>)
                  .map<SecuritiesListRequestModel?>(
                (x) => SecuritiesListRequestModel.fromEntity(
                    x as SecuritiesListRequestEntity),
              ),
            )
          : null,
    );
  }
}

class SecuritiesListRequestModel {
  String? isin;
  double? quantity;
  double? price;
  double? qty;

  SecuritiesListRequestModel({
    this.isin,
    this.quantity,
    this.price,
    this.qty,
  });

  SecuritiesListRequestModel.fromJson(Map<String, dynamic> json) {
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

  factory SecuritiesListRequestModel.fromEntity(
      SecuritiesListRequestEntity securitiesListRequestEntity) {
    return SecuritiesListRequestModel(
      isin: securitiesListRequestEntity.isin != null
          ? securitiesListRequestEntity.isin as String
          : null,
      quantity: securitiesListRequestEntity.quantity != null
          ? securitiesListRequestEntity.quantity as double
          : null,
      price: securitiesListRequestEntity.price != null
          ? securitiesListRequestEntity.price as double
          : null,
      qty: securitiesListRequestEntity.qty != null
          ? securitiesListRequestEntity.qty as double
          : null,
    );
  }
}
