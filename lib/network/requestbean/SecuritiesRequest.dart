class SecuritiesRequest {
  String? lender;
  String? level;
  String? demat;

  SecuritiesRequest({this.lender, this.level, this.demat});

  SecuritiesRequest.fromJson(Map<String, dynamic> json) {
    lender = json['lender'];
    level = json['level'];
    demat = json['demat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lender'] = this.lender;
    data['level'] = this.level;
    data['demat'] = this.demat;
    return data;
  }
}
