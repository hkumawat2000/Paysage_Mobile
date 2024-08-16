
class MyPledgedSecuritiesRequestModel {
  String? loanName;

  MyPledgedSecuritiesRequestModel({this.loanName});

  MyPledgedSecuritiesRequestModel.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    return data;
  }

  MyPledgedSecuritiesRequestEntity toEntity() =>
      MyPledgedSecuritiesRequestEntity(
        loanName: loanName,
      );

  factory MyPledgedSecuritiesRequestModel.fromEntity(MyPledgedSecuritiesRequestEntity myPledgedSecuritiesRequestEntity) {
    return MyPledgedSecuritiesRequestModel(
      loanName: myPledgedSecuritiesRequestEntity.loanName != null ? myPledgedSecuritiesRequestEntity.loanName as String : null,
    );
  }
}

class MyPledgedSecuritiesRequestEntity {
  String? loanName;

  MyPledgedSecuritiesRequestEntity({required this.loanName});
}