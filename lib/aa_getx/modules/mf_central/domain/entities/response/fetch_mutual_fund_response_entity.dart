
class FetchMutualFundResponseEntity {
  String? message;
  List<FetchMutualFundResponseDataEntity>? fetchMutualFundResponseData;

  FetchMutualFundResponseEntity({this.message, this.fetchMutualFundResponseData});
}

class FetchMutualFundResponseDataEntity {
  String? email;
  String? amc;
  String? amcName;
  String? folio;
  String? scheme;
  String? schemeName;
  String? kycStatus;
  String? brokerCode;
  String? brokerName;
  String? rtaCode;
  String? decimalUnits;
  String? decimalAmount;
  String? decimalNav;
  String? lastTrxnDate;
  String? openingBal;
  String? marketValue;
  String? nav;
  String? closingBalance;
  String? lastNavDate;
  String? isDemat;
  String? assetType;
  String? isin;
  String? nomineeStatus;
  String? taxStatus;
  String? costValue;

  FetchMutualFundResponseDataEntity(
      {this.email,
        this.amc,
        this.amcName,
        this.folio,
        this.scheme,
        this.schemeName,
        this.kycStatus,
        this.brokerCode,
        this.brokerName,
        this.rtaCode,
        this.decimalUnits,
        this.decimalAmount,
        this.decimalNav,
        this.lastTrxnDate,
        this.openingBal,
        this.marketValue,
        this.nav,
        this.closingBalance,
        this.lastNavDate,
        this.isDemat,
        this.assetType,
        this.isin,
        this.nomineeStatus,
        this.taxStatus,
        this.costValue});
}