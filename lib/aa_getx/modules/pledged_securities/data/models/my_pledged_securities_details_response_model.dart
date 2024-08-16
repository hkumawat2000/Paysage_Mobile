
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/my_pledged_securities_details_response_entity.dart';

class MyPledgedSecuritiesDetailsResponseModel {
  String? message;
  MyPledgedSecuritiesData? myPledgedSecuritiesData;

  MyPledgedSecuritiesDetailsResponseModel({this.message, this.myPledgedSecuritiesData});

  MyPledgedSecuritiesDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    myPledgedSecuritiesData = json['data'] != null ? new MyPledgedSecuritiesData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.myPledgedSecuritiesData != null) {
      data['data'] = this.myPledgedSecuritiesData!.toJson();
    }
    return data;
  }

  MyPledgedSecuritiesDetailsResponseEntity toEntity() =>
      MyPledgedSecuritiesDetailsResponseEntity(
        message: message,
        myPledgedSecuritiesData: myPledgedSecuritiesData?.toEntity(),

      );

  factory MyPledgedSecuritiesDetailsResponseModel.fromEntity(MyPledgedSecuritiesDetailsResponseEntity myPledgedSecuritiesDetailsResponse) {
    return MyPledgedSecuritiesDetailsResponseModel(
      message: myPledgedSecuritiesDetailsResponse.message != null ? myPledgedSecuritiesDetailsResponse.message as String : null,
      myPledgedSecuritiesData: myPledgedSecuritiesDetailsResponse.myPledgedSecuritiesData != null ? MyPledgedSecuritiesData.fromEntity(myPledgedSecuritiesDetailsResponse.myPledgedSecuritiesData as MyPledgedSecuritiesDataEntity) : null,
    );
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

  MyPledgedSecuritiesDataEntity toEntity() =>
      MyPledgedSecuritiesDataEntity(
        loanName: loanName,
        instrumentType: instrumentType,
        schemeType: schemeType,
        totalValue: totalValue,
        drawingPower: drawingPower,
        drawingPowerStr: drawingPowerStr,
        balance: balance,
        numberOfScrips: numberOfScrips,
        allPledgedSecurities: allPledgedSecurities?.map((x) => x.toEntity()).toList(),
        sellCollateral: sellCollateral,
        isSellTriggered: isSellTriggered,
        increaseLoan: increaseLoan,
        increaseLoanName: increaseLoanName,
        topUpApplication: topUpApplication,
        topUpApplicationName: topUpApplicationName,
        unpledge: unpledge?.toEntity(),

      );

  factory MyPledgedSecuritiesData.fromEntity(MyPledgedSecuritiesDataEntity myPledgedSecuritiesData) {
    return MyPledgedSecuritiesData(
      loanName: myPledgedSecuritiesData.loanName != null ? myPledgedSecuritiesData.loanName as String : null,
      instrumentType: myPledgedSecuritiesData.instrumentType != null ? myPledgedSecuritiesData.instrumentType as String : null,
      schemeType: myPledgedSecuritiesData.schemeType != null ? myPledgedSecuritiesData.schemeType as String : null,
      totalValue: myPledgedSecuritiesData.totalValue != null ? myPledgedSecuritiesData.totalValue as double : null,
      drawingPower: myPledgedSecuritiesData.drawingPower != null ? myPledgedSecuritiesData.drawingPower as double : null,
      drawingPowerStr: myPledgedSecuritiesData.drawingPowerStr != null ? myPledgedSecuritiesData.drawingPowerStr as String : null,
      balance: myPledgedSecuritiesData.balance != null ? myPledgedSecuritiesData.balance as double : null,
      numberOfScrips: myPledgedSecuritiesData.numberOfScrips != null ? myPledgedSecuritiesData.numberOfScrips as int : null,
      allPledgedSecurities: myPledgedSecuritiesData.allPledgedSecurities != null ? List<AllPledgedSecurities>.from((myPledgedSecuritiesData.allPledgedSecurities as List<dynamic>).map<AllPledgedSecurities?>((x) => AllPledgedSecurities.fromEntity(x as AllPledgedSecuritiesEntity),),) : null,
      sellCollateral: myPledgedSecuritiesData.sellCollateral != null ? myPledgedSecuritiesData.sellCollateral as int : null,
      isSellTriggered: myPledgedSecuritiesData.isSellTriggered != null ? myPledgedSecuritiesData.isSellTriggered as int : null,
      increaseLoan: myPledgedSecuritiesData.increaseLoan != null ? myPledgedSecuritiesData.increaseLoan as int : null,
      increaseLoanName: myPledgedSecuritiesData.increaseLoanName != null ? myPledgedSecuritiesData.increaseLoanName as String : null,
      topUpApplication: myPledgedSecuritiesData.topUpApplication != null ? myPledgedSecuritiesData.topUpApplication as int : null,
      topUpApplicationName: myPledgedSecuritiesData.topUpApplicationName != null ? myPledgedSecuritiesData.topUpApplicationName as String : null,
      unpledge: myPledgedSecuritiesData.unpledge != null ? Unpledge.fromEntity(myPledgedSecuritiesData.unpledge as UnpledgeEntity) : null,
    );
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

  AllPledgedSecuritiesEntity toEntity() =>
      AllPledgedSecuritiesEntity(
        securityName: securityName,
        pledgedQuantity: pledgedQuantity,
        securityCategory: securityCategory,
        price: price,
        amount: amount,
        isin: isin,
        folio: folio,
        eligiblePercentage: eligiblePercentage,

      );

  factory AllPledgedSecurities.fromEntity(AllPledgedSecuritiesEntity allPledgedSecurities) {
    return AllPledgedSecurities(
      securityName: allPledgedSecurities.securityName != null ? allPledgedSecurities.securityName as String : null,
      pledgedQuantity: allPledgedSecurities.pledgedQuantity != null ? allPledgedSecurities.pledgedQuantity as double : null,
      securityCategory: allPledgedSecurities.securityCategory != null ? allPledgedSecurities.securityCategory as String : null,
      price: allPledgedSecurities.price != null ? allPledgedSecurities.price as double : null,
      amount: allPledgedSecurities.amount != null ? allPledgedSecurities.amount as double : null,
      isin: allPledgedSecurities.isin != null ? allPledgedSecurities.isin as String : null,
      folio: allPledgedSecurities.folio != null ? allPledgedSecurities.folio as String : null,
      eligiblePercentage: allPledgedSecurities.eligiblePercentage != null ? allPledgedSecurities.eligiblePercentage as double : null,
    );
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

  UnpledgeEntity toEntity() => UnpledgeEntity(
        unpledgeMsgWhileMarginShortfall: unpledgeMsgWhileMarginShortfall,
        unpledgeValue: unpledgeValue?.toEntity(),
      );

  factory Unpledge.fromEntity(UnpledgeEntity unpledgeEntity){
    return Unpledge(
      unpledgeMsgWhileMarginShortfall: unpledgeEntity.unpledgeMsgWhileMarginShortfall != null ? unpledgeEntity.unpledgeMsgWhileMarginShortfall as String : null,
      unpledgeValue: unpledgeEntity.unpledgeValue != null ? UnpledgeValue.fromEntity(unpledgeEntity.unpledgeValue as UnpledgeValueEntity) : null ,
    );
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

  UnpledgeValueEntity toEntity() =>
      UnpledgeValueEntity(
        minimumCollateralValue: minimumCollateralValue,
        maximumUnpledgeAmount: maximumUnpledgeAmount,
      );

  factory UnpledgeValue.fromEntity(UnpledgeValueEntity unpledgeValueEntity) {
    return UnpledgeValue(
      minimumCollateralValue: unpledgeValueEntity.minimumCollateralValue != null ? unpledgeValueEntity.minimumCollateralValue as double : null,
      maximumUnpledgeAmount: unpledgeValueEntity.maximumUnpledgeAmount != null ? unpledgeValueEntity.maximumUnpledgeAmount as double : null,
    );
  }
}

