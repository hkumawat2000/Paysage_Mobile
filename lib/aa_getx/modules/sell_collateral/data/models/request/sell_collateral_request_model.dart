import 'package:lms/aa_getx/modules/sell_collateral/domain/entities/request/sell_collateral_request_entity.dart';

class SellCollateralRequestModel {
  Securities? securities;
  String? loanName;
  String? otp;
  String? loanMarginShortfallName;


  SellCollateralRequestModel({this.securities, this.loanName, this.otp,this.loanMarginShortfallName});

  SellCollateralRequestModel.fromJson(Map<String, dynamic> json) {
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

  factory SellCollateralRequestModel.fromEntity(SellCollateralRequestEntity sellCollateralRequestEntity) {
    return SellCollateralRequestModel(
      securities: sellCollateralRequestEntity.securities != null ? Securities.fromEntity(sellCollateralRequestEntity.securities as SecuritiesEntity) : null,
      loanName: sellCollateralRequestEntity.loanName != null ? sellCollateralRequestEntity.loanName as String : null,
      otp: sellCollateralRequestEntity.otp != null ? sellCollateralRequestEntity.otp as String : null,
      loanMarginShortfallName: sellCollateralRequestEntity.loanMarginShortfallName != null ? sellCollateralRequestEntity.loanMarginShortfallName as String : null,
    );
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

  factory Securities.fromEntity(SecuritiesEntity securitiesEntity) {
    return Securities(
      list: securitiesEntity.list != null ? List<SellList>.from((securitiesEntity.list as List<dynamic>).map<SellList?>((x) => SellList.fromEntity(x as SellListEntity),),) : null,
    );
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

  factory SellList.fromEntity(SellListEntity sellListEntity) {
    return SellList(
      isin: sellListEntity.isin != null ? sellListEntity.isin as String : null,
      folio: sellListEntity.folio != null ? sellListEntity.folio as String : null,
      psn: sellListEntity.psn != null ? sellListEntity.psn as String : null,
      quantity: sellListEntity.quantity != null ? sellListEntity.quantity as double : null,
    );
  }
}

