import 'package:choice/network/ModelWrapper.dart';

class CheckEligibilityResponseBean extends ModelWrapper<List<EligibilityData>>{
  List<EligibilityData>? eligibilityData;

  CheckEligibilityResponseBean({this.eligibilityData});

  CheckEligibilityResponseBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      eligibilityData = <EligibilityData>[];
      json['data'].forEach((v) {
        eligibilityData!.add(new EligibilityData.fromJson(v));

      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eligibilityData != null) {
      data['data'] = this.eligibilityData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EligibilityData {
  String? securityName;
  double? eligiblePercentage;
  String? lender;
  String? securityCategory;
  double? price;
  bool? isSecurityCheck = true;
  bool? isEligible = true;
  bool? isApprovedCheck = false;
  int? quantitySelected;
  double? totalMarketValue = 0;
  double? quantity;
  String? stock_at;

  EligibilityData(
      {this.securityName, this.eligiblePercentage, this.lender, this.securityCategory, this.price, this.isEligible, this.isApprovedCheck,this.isSecurityCheck,this.quantitySelected, this.quantity, this.stock_at});

  EligibilityData.fromJson(Map<String, dynamic> json) {
    securityName = json['Scrip_Name'];
    eligiblePercentage = json['eligible_percentage'];
    isEligible = json['Is_Eligible'];
    lender = json['lender'];
    securityCategory = json['Category'];
    price = json['Price'];
    quantity = json['Quantity'];
    stock_at = json['Stock_At'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Scrip_Name'] = this.securityName;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['Is_Eligible'] = this.isEligible;
    data['lender'] = this.lender;
    data['Category'] = this.securityCategory;
    data['Price'] = this.price;
    data['Quantity'] = this.quantity;
    data['Stock_At'] = this.stock_at;
    return data;
  }
}
