import 'MyCartRequestBean.dart';

class UnpledgeRequestBean {
  String? loanName;
  UnPledgeSecurities? securities;
  String? otp;

  UnpledgeRequestBean({this.loanName, this.securities, this.otp});

  UnpledgeRequestBean.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    securities = json['securities'] != null
        ? new UnPledgeSecurities.fromJson(json['securities'])
        : null;
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    if (this.securities != null) {
      data['securities'] = this.securities!.toJson();
    }
    data['otp'] = this.otp;
    return data;
  }
}

class UnPledgeSecurities {
  List<UnPledgeList>? list;

  UnPledgeSecurities({this.list});

  UnPledgeSecurities.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <UnPledgeList>[];
      json['list'].forEach((v) {
        list?.add(new UnPledgeList.fromJson(v));
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

class UnPledgeList {
  String? isin;
  String? folio;
  String? psn;
  double? quantity;

  UnPledgeList({this.isin,this.folio, this.psn,this.quantity});

  UnPledgeList.fromJson(Map<String, dynamic> json) {
    isin = json['isin'];
    folio = json['folio'];
    psn = json['date_of_pledge'];
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

