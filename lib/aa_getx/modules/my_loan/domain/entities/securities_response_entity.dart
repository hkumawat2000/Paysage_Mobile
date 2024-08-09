
class SecuritiesResponseEntity {
  String? message;
  SecurityDataEntity? securityData;

  SecuritiesResponseEntity({this.message, this.securityData});
}


class SecurityDataEntity {
  List<SecuritiesListDataEntity>? securities;
  List<LenderInfoEntity>? lenderInfo;

  SecurityDataEntity({this.securities, this.lenderInfo});
}

class SecuritiesListDataEntity {
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

  SecuritiesListDataEntity(
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
}


class LenderInfoEntity {
  String? name;
  double? minimumSanctionedLimit;
  double? maximumSanctionedLimit;
  double? rateOfInterest;

  LenderInfoEntity(
      {this.name,
        this.minimumSanctionedLimit,
        this.maximumSanctionedLimit,
        this.rateOfInterest});
}