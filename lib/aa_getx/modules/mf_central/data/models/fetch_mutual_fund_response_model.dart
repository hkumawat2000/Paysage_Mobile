import 'package:lms/aa_getx/modules/mf_central/domain/entities/fetch_mutual_fund_response_entity.dart';

class FetchMutualFundResponseModel {
  String? message;
  List<FetchMutualFundResponseData>? fetchMutualFundResponseData;

  FetchMutualFundResponseModel({this.message, this.fetchMutualFundResponseData});

  FetchMutualFundResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      fetchMutualFundResponseData = <FetchMutualFundResponseData>[];
      json['data'].forEach((v) {
        fetchMutualFundResponseData!.add(new FetchMutualFundResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.fetchMutualFundResponseData != null) {
      data['data'] = this.fetchMutualFundResponseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  FetchMutualFundResponseEntity toEntity() =>
      FetchMutualFundResponseEntity(
        message: message,
        fetchMutualFundResponseData: fetchMutualFundResponseData?.map((x) => x.toEntity()).toList(),
      );
}

class FetchMutualFundResponseData {
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

  FetchMutualFundResponseData(
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

  FetchMutualFundResponseData.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    amc = json['amc'];
    amcName = json['amcName'];
    folio = json['folio'];
    scheme = json['scheme'];
    schemeName = json['schemeName'];
    kycStatus = json['kycStatus'];
    brokerCode = json['brokerCode'];
    brokerName = json['brokerName'];
    rtaCode = json['rtaCode'];
    decimalUnits = json['decimalUnits'];
    decimalAmount = json['decimalAmount'];
    decimalNav = json['decimalNav'];
    lastTrxnDate = json['lastTrxnDate'];
    openingBal = json['openingBal'];
    marketValue = json['marketValue'];
    nav = json['nav'];
    closingBalance = json['closingBalance'];
    lastNavDate = json['lastNavDate'];
    isDemat = json['isDemat'];
    assetType = json['assetType'];
    isin = json['isin'];
    nomineeStatus = json['nomineeStatus'];
    taxStatus = json['taxStatus'];
    costValue = json['costValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['amc'] = this.amc;
    data['amcName'] = this.amcName;
    data['folio'] = this.folio;
    data['scheme'] = this.scheme;
    data['schemeName'] = this.schemeName;
    data['kycStatus'] = this.kycStatus;
    data['brokerCode'] = this.brokerCode;
    data['brokerName'] = this.brokerName;
    data['rtaCode'] = this.rtaCode;
    data['decimalUnits'] = this.decimalUnits;
    data['decimalAmount'] = this.decimalAmount;
    data['decimalNav'] = this.decimalNav;
    data['lastTrxnDate'] = this.lastTrxnDate;
    data['openingBal'] = this.openingBal;
    data['marketValue'] = this.marketValue;
    data['nav'] = this.nav;
    data['closingBalance'] = this.closingBalance;
    data['lastNavDate'] = this.lastNavDate;
    data['isDemat'] = this.isDemat;
    data['assetType'] = this.assetType;
    data['isin'] = this.isin;
    data['nomineeStatus'] = this.nomineeStatus;
    data['taxStatus'] = this.taxStatus;
    data['costValue'] = this.costValue;
    return data;
  }

  FetchMutualFundResponseDataEntity toEntity() =>
      FetchMutualFundResponseDataEntity(
        email: email,
        amc: amc,
        amcName: amcName,
        folio: folio,
        scheme: scheme,
        schemeName: schemeName,
        kycStatus: kycStatus,
        brokerCode: brokerCode,
        brokerName: brokerName,
        rtaCode: rtaCode,
        decimalUnits: decimalUnits,
        decimalAmount: decimalAmount,
        decimalNav: decimalNav,
        lastTrxnDate: lastTrxnDate,
        openingBal: openingBal,
        marketValue: marketValue,
        nav: nav,
        closingBalance: closingBalance,
        lastNavDate: lastNavDate,
        isDemat: isDemat,
        assetType: assetType,
        isin: isin,
        nomineeStatus: nomineeStatus,
        taxStatus: taxStatus,
        costValue: costValue,
      );
}

