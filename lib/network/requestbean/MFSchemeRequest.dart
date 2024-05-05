class MFSchemeRequest {
  String? schemeType;
  String? lender;
  String? level;

  MFSchemeRequest(this.schemeType, this.lender, this.level);

  MFSchemeRequest.fromJson(Map<String, dynamic> json) {
    schemeType = json['scheme_type'];
    lender = json['lender'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheme_type'] = this.schemeType;
    data['lender'] = this.lender;
    data['level'] = this.level;
    return data;
  }
}