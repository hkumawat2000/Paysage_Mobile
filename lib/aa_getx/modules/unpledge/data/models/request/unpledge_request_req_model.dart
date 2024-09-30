
import 'package:lms/aa_getx/modules/unpledge/domain/entities/request/unpledge_request_req_entity.dart';

class UnpledgeRequestReqModel {
  String? loanName;
  UnPledgeSecurities? securities;
  String? otp;

  UnpledgeRequestReqModel({this.loanName, this.securities, this.otp});

  UnpledgeRequestReqModel.fromJson(Map<String, dynamic> json) {
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

  factory UnpledgeRequestReqModel.fromEntity(UnpledgeRequestReqEntity unpledgeRequestReqEntity) {
    return UnpledgeRequestReqModel(
      loanName: unpledgeRequestReqEntity.loanName != null ? unpledgeRequestReqEntity.loanName as String : null,
      securities: unpledgeRequestReqEntity.securities != null ? UnPledgeSecurities.fromEntity(unpledgeRequestReqEntity.securities as UnPledgeSecuritiesEntity) : null,
      otp: unpledgeRequestReqEntity.otp != null ? unpledgeRequestReqEntity.otp as String : null,
    );
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

  factory UnPledgeSecurities.fromEntity(UnPledgeSecuritiesEntity unPledgeSecuritiesEntity) {
    return UnPledgeSecurities(
      list: unPledgeSecuritiesEntity.list != null ? List<UnPledgeList>.from((unPledgeSecuritiesEntity.list as List<dynamic>).map<UnPledgeList?>((x) => UnPledgeList.fromEntity(x as UnPledgeListEntity),),) : null,
    );
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

  factory UnPledgeList.fromEntity(UnPledgeListEntity unPledgeListEntity) {
    return UnPledgeList(
      isin: unPledgeListEntity.isin != null ? unPledgeListEntity.isin as String : null,
      folio: unPledgeListEntity.folio != null ? unPledgeListEntity.folio as String : null,
      psn: unPledgeListEntity.psn != null ? unPledgeListEntity.psn as String : null,
      quantity: unPledgeListEntity.quantity != null ? unPledgeListEntity.quantity as double : null,
    );
  }
}