import 'package:lms/network/ModelWrapper.dart';

class SecuritiesResponseBean extends ModelWrapper<List<SecurityData>>{
  String? message;
  SecurityData? securityData;

  SecuritiesResponseBean({this.message, this.securityData});

  SecuritiesResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    securityData = json['data'] != null ? new SecurityData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.securityData != null) {
      data['data'] = this.securityData!.toJson();
    }
    return data;
  }
}

class SecurityData {
  List<SecuritiesListData>? securities;
  List<LenderInfo>? lenderInfo;

  SecurityData({this.securities, this.lenderInfo});

  SecurityData.fromJson(Map<String, dynamic> json) {
    if (json['Securities'] != null) {
      securities = <SecuritiesListData>[];
      json['Securities'].forEach((v) {
        securities!.add(new SecuritiesListData.fromJson(v));
      });
    }
    if (json['lender_info'] != null) {
      lenderInfo = <LenderInfo>[];
      json['lender_info'].forEach((v) {
        lenderInfo!.add(new LenderInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.securities != null) {
      data['Securities'] = this.securities!.map((v) => v.toJson()).toList();
    }
    if (this.lenderInfo != null) {
      data['lender_info'] = this.lenderInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SecuritiesListData {
  String? iSIN;
  String? category;
  String? scripName;
  double? price;
  String? lenders;
  String? amcImage;
  String? branch;
  String? clientCode;
  String? clientName;
  String? depository;
  String? stockAt;
  double? quantity;
  double? scripValue;
  String? holdingAsOn;
  bool? isEligible;
  double? totalQty;
  int? waitingToBePledgedQty;
  int? waitingForApprovalPledgedQty;
  int? unpledgedQuantity;
  int? isChoice;
  double? eligiblePercentage;
  double? eligibleLoan;
  double? securityValue;
  bool? isShowWarning = false;
  bool? forSearch = false;

  SecuritiesListData(
      {this.iSIN,
        this.category,
        this.scripName,
        this.price,
        this.lenders,
        this.amcImage,
        this.branch,
        this.clientCode,
        this.clientName,
        this.depository,
        this.stockAt,
        this.quantity,
        this.scripValue,
        this.holdingAsOn,
        this.isEligible,
        this.totalQty,
        this.waitingToBePledgedQty,
        this.waitingForApprovalPledgedQty,
        this.unpledgedQuantity,
        this.isChoice,
        this.eligiblePercentage,
        this.eligibleLoan,
        this.securityValue,
        this.isShowWarning,
        this.forSearch});

  SecuritiesListData.fromJson(Map<String, dynamic> json) {
    iSIN = json['ISIN'];
    category = json['Category'];
    scripName = json['Scrip_Name'];
    price = json['Price'];
    lenders = json['lenders'];
    amcImage = json['amc_image'];
    branch = json['Branch'];
    clientCode = json['Client_Code'];
    clientName = json['Client_Name'];
    depository = json['Depository'];
    stockAt = json['Stock_At'];
    quantity = json['Quantity'];
    scripValue = json['Scrip_Value'];
    holdingAsOn = json['Holding_As_On'];
    isEligible = json['Is_Eligible'];
    totalQty = json['Total_Qty'];
    // waitingToBePledgedQty = json['waiting_to_be_pledged_qty'];
    // waitingForApprovalPledgedQty = json['waiting_for_approval_pledged_qty'];
    // unpledgedQuantity = json['unpledged_quantity'];
    eligiblePercentage = json['eligible_percentage'];
    isChoice = json['is_choice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ISIN'] = this.iSIN;
    data['Category'] = this.category;
    data['Scrip_Name'] = this.scripName;
    data['Price'] = this.price;
    data['lenders'] = this.lenders;
    data['amc_image'] = this.amcImage;
    data['Branch'] = this.branch;
    data['Client_Code'] = this.clientCode;
    data['Client_Name'] = this.clientName;
    data['Depository'] = this.depository;
    data['Stock_At'] = this.stockAt;
    data['Quantity'] = this.quantity;
    data['Scrip_Value'] = this.scripValue;
    data['Holding_As_On'] = this.holdingAsOn;
    data['Is_Eligible'] = this.isEligible;
    data['Total_Qty'] = this.totalQty;
    data['waiting_to_be_pledged_qty'] = this.waitingToBePledgedQty;
    data['waiting_for_approval_pledged_qty'] =
        this.waitingForApprovalPledgedQty;
    data['unpledged_quantity'] = this.unpledgedQuantity;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['is_choice'] = this.isChoice;
    return data;
  }
}

class LenderInfo {
  String? name;
  double? minimumSanctionedLimit;
  double? maximumSanctionedLimit;
  double? rateOfInterest;

  LenderInfo(
      {this.name,
        this.minimumSanctionedLimit,
        this.maximumSanctionedLimit,
        this.rateOfInterest});

  LenderInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    minimumSanctionedLimit = json['minimum_sanctioned_limit'];
    maximumSanctionedLimit = json['maximum_sanctioned_limit'];
    rateOfInterest = json['rate_of_interest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['minimum_sanctioned_limit'] = this.minimumSanctionedLimit;
    data['maximum_sanctioned_limit'] = this.maximumSanctionedLimit;
    data['rate_of_interest'] = this.rateOfInterest;
    return data;
  }
}

class CategoryWiseSecurityList{
  String? categoryName;
  List<SecuritiesListData>? items;

  CategoryWiseSecurityList(this.categoryName, this.items);
}

