class MyPledgedSecuritiesDetailsResponseEntity{
  String? message;
  MyPledgedSecuritiesDataEntity? myPledgedSecuritiesData;

  MyPledgedSecuritiesDetailsResponseEntity({this.message, this.myPledgedSecuritiesData});
}

class MyPledgedSecuritiesDataEntity {
  String? loanName;
  String? instrumentType;
  String? schemeType;
  double? totalValue;
  double? drawingPower;
  String? drawingPowerStr;
  double? balance;
  int? numberOfScrips;
  List<AllPledgedSecuritiesEntity>? allPledgedSecurities;
  int? sellCollateral;
  int? isSellTriggered;
  int? increaseLoan;
  String? increaseLoanName;
  int? topUpApplication;
  String? topUpApplicationName;
  UnpledgeEntity? unpledge;


  MyPledgedSecuritiesDataEntity(
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
}

class AllPledgedSecuritiesEntity {
  String? securityName;
  double? pledgedQuantity;
  String? securityCategory;
  double? price;
  double? amount;
  String? isin;
  String? folio;
  double? eligiblePercentage;

  AllPledgedSecuritiesEntity(
      {this.securityName,
        this.pledgedQuantity,
        this.securityCategory,
        this.price,
        this.amount,
        this.isin,
        this.folio,
        this.eligiblePercentage});
}

class UnpledgeEntity {
  String? unpledgeMsgWhileMarginShortfall;
  UnpledgeValueEntity? unpledgeValue;

  UnpledgeEntity({this.unpledgeMsgWhileMarginShortfall, this.unpledgeValue});
}

class UnpledgeValueEntity {
  double? minimumCollateralValue;
  double? maximumUnpledgeAmount;

  UnpledgeValueEntity({this.minimumCollateralValue, this.maximumUnpledgeAmount});
}