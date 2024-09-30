
class UnpledgeRequestReqEntity {
  String? loanName;
  UnPledgeSecuritiesEntity? securities;
  String? otp;

  UnpledgeRequestReqEntity({required this.loanName,required this.securities, required this.otp});
}

class UnPledgeSecuritiesEntity {
  List<UnPledgeListEntity>? list;

  UnPledgeSecuritiesEntity({this.list});
}

class UnPledgeListEntity {
  String? isin;
  String? folio;
  String? psn;
  double? quantity;

  UnPledgeListEntity({this.isin,this.folio, this.psn,this.quantity});

}