class TopUpRequest {
  String? loanName;
  double? topupAmount;

  TopUpRequest({this.loanName, this.topupAmount});

  TopUpRequest.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    topupAmount = json['topup_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    data['topup_amount'] = this.topupAmount;
    return data;
  }
}
