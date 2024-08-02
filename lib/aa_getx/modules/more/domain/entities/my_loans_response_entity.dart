
class MyLoansResponseEntity {
  MessageEntity? message;

  MyLoansResponseEntity({this.message});
}

class MessageEntity {
  int? status;
  String? message;
  MyLoansDataEntity? data;

  MessageEntity({this.status, this.message, this.data});
}

class MyLoansDataEntity {
  List<LoansEntity>? loans;
  int? canPledge;
  double? totalOutstanding;
  double? totalDrawingPower;
  double? totalTotalCollateralValue;
  double? totalMarginShortfall;
  double? totalSanctionedLimit;

  MyLoansDataEntity({this.loans,
    this.canPledge,
    this.totalOutstanding,
    this.totalDrawingPower,
    this.totalTotalCollateralValue,
    this.totalMarginShortfall,
    this.totalSanctionedLimit});
}

class LoansEntity {
  double? totalCollateralValue;
  String? totalCollateralValueStr;
  String? name;
  double? shortfall;
  double? drawingPower;
  String? drawingPowerStr;
  double? shortfallPercentage;
  double? shortfallC;
  double? outstanding;
  double? sanctionedLimit;
  String? sanctionedLimitStr;
  double? topUpAmount;
  int? topUpAvailable;

  LoansEntity({this.totalCollateralValue,
    this.name,
    this.shortfall,
    this.drawingPower,
    this.shortfallPercentage,
    this.shortfallC, this.outstanding,
    this.sanctionedLimit, this.topUpAmount, this.topUpAvailable, this.drawingPowerStr, this.sanctionedLimitStr, this.totalCollateralValueStr});
}