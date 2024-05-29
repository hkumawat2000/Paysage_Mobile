import 'package:lms/network/ModelWrapper.dart';

class MyPledgedSecuritiesDetailsRespones extends ModelWrapper<MyPledgedSecuritiesData> {
  String? message;
  MyPledgedSecuritiesData? myPledgedSecuritiesData;

  MyPledgedSecuritiesDetailsRespones({this.message, this.myPledgedSecuritiesData});

  MyPledgedSecuritiesDetailsRespones.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    myPledgedSecuritiesData = json['data'] != null ? new MyPledgedSecuritiesData.fromJson(json['data']) : null;
    data = myPledgedSecuritiesData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MyPledgedSecuritiesData {
  String? loanName;
  String? instrumentType;
  String? schemeType;
  double? totalValue;
  double? drawingPower;
  String? drawingPowerStr;
  double? balance;
  int? numberOfScrips;
  List<AllPledgedSecurities>? allPledgedSecurities;
  int? sellCollateral;
  int? isSellTriggered;
  int? increaseLoan;
  String? increaseLoanName;
  int? topUpApplication;
  String? topUpApplicationName;
  Unpledge? unpledge;


  MyPledgedSecuritiesData(
      {this.loanName,
        this.instrumentType,
        this.schemeType,
        this.totalValue,
        this.drawingPower,
        this.balance,
        this.numberOfScrips,
        this.allPledgedSecurities,
        this.sellCollateral,
        this.isSellTriggered,
        this.increaseLoan,
        this.increaseLoanName,
        this.topUpApplication,
        this.topUpApplicationName,
        this.unpledge,this.drawingPowerStr});


  MyPledgedSecuritiesData.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    instrumentType = json['instrument_type'];
    schemeType = json['scheme_type'];
    totalValue = json['total_value'];
    drawingPower = json['drawing_power'];
    drawingPowerStr = json['drawing_power_str'];
    balance = json['balance'];
    numberOfScrips = json['number_of_scrips'];
    if (json['all_pledged_securities'] != null) {
      allPledgedSecurities = <AllPledgedSecurities>[];
      json['all_pledged_securities'].forEach((v) {
        allPledgedSecurities!.add(new AllPledgedSecurities.fromJson(v));
      });
    }
    sellCollateral = json['sell_collateral'];
    isSellTriggered = json['is_sell_triggered'];
    increaseLoan = json['increase_loan'];
    increaseLoanName = json['increase_loan_name'];
    topUpApplication = json['topup_application'];
    topUpApplicationName = json['topup_application_name'];
    unpledge = json['unpledge'] != null
        ? new Unpledge.fromJson(json['unpledge'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    data['instrument_type'] = this.instrumentType;
    data['scheme_type'] = this.schemeType;
    data['total_value'] = this.totalValue;
    data['drawing_power'] = this.drawingPower;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['balance'] = this.balance;
    data['number_of_scrips'] = this.numberOfScrips;
    if (this.allPledgedSecurities != null) {
      data['all_pledged_securities'] =
          this.allPledgedSecurities!.map((v) => v.toJson()).toList();
    }
    data['sell_collateral'] = this.sellCollateral;
    data['is_sell_triggered'] = this.isSellTriggered;
    data['increase_loan'] = this.increaseLoan;
    data['increase_loan_name'] = this.increaseLoanName;
    data['topup_application'] = this.topUpApplication;
    data['topup_application_name'] = this.topUpApplicationName;
    if (this.unpledge != null) {
      data['unpledge'] = this.unpledge!.toJson();
    }
    return data;
  }
}

class AllPledgedSecurities {
  String? securityName;
  double? pledgedQuantity;
  String? securityCategory;
  double? price;
  double? amount;
  String? isin;
  String? folio;
  double? eligiblePercentage;

  AllPledgedSecurities(
      {this.securityName,
        this.pledgedQuantity,
        this.securityCategory,
        this.price,
        this.amount,
        this.isin,
        this.folio,
        this.eligiblePercentage});

  AllPledgedSecurities.fromJson(Map<String, dynamic> json) {
    securityName = json['security_name'];
    pledgedQuantity = json['pledged_quantity'];
    securityCategory = json['security_category'];
    price = json['price'];
    amount = json['amount'];
    isin = json['isin'];
    folio = json['folio'];
    eligiblePercentage = json['eligible_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['security_name'] = this.securityName;
    data['pledged_quantity'] = this.pledgedQuantity;
    data['security_category'] = this.securityCategory;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['isin'] = this.isin;
    data['folio'] = this.folio;
    data['eligible_percentage'] = this.eligiblePercentage;
    return data;
  }
}


class Unpledge {
  String? unpledgeMsgWhileMarginShortfall;
  UnpledgeValue? unpledgeValue;

  Unpledge({this.unpledgeMsgWhileMarginShortfall, this.unpledgeValue});

  Unpledge.fromJson(Map<String, dynamic> json) {
    unpledgeMsgWhileMarginShortfall =
    json['unpledge_msg_while_margin_shortfall'];
    unpledgeValue = json['unpledge'] != null
        ? new UnpledgeValue.fromJson(json['unpledge'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unpledge_msg_while_margin_shortfall'] =
        this.unpledgeMsgWhileMarginShortfall;
    if (this.unpledgeValue != null) {
      data['unpledge'] = this.unpledgeValue!.toJson();
    }
    return data;
  }
}

class UnpledgeValue {
  double? minimumCollateralValue;
  double? maximumUnpledgeAmount;

  UnpledgeValue({this.minimumCollateralValue, this.maximumUnpledgeAmount});

  UnpledgeValue.fromJson(Map<String, dynamic> json) {
    minimumCollateralValue = json['minimum_collateral_value'];
    maximumUnpledgeAmount = json['maximum_unpledge_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['minimum_collateral_value'] = this.minimumCollateralValue;
    data['maximum_unpledge_amount'] = this.maximumUnpledgeAmount;
    return data;
  }
}