
import 'package:lms/aa_getx/modules/my_loan/domain/entities/securities_response_entity.dart';

class SecuritiesResponseModel {
  String? message;
  SecurityData? securityData;

  SecuritiesResponseModel({this.message, this.securityData});

  SecuritiesResponseModel.fromJson(Map<String, dynamic> json) {
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

  SecuritiesResponseEntity toEntity() =>
      SecuritiesResponseEntity(
        message: message,
        securityData: securityData?.toEntity(),

      );

  factory SecuritiesResponseModel.fromEntity(SecuritiesResponseEntity securitiesResponseEntity) {
    return SecuritiesResponseModel(
      message: securitiesResponseEntity.message != null ? securitiesResponseEntity.message as String : null,
      securityData: securitiesResponseEntity.securityData != null ? SecurityData.fromEntity(securitiesResponseEntity.securityData as SecurityData) : null,
    );
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


  factory SecurityData.fromEntity(SecurityData securityData) {
    return SecurityData(
      securities: securityData.securities != null ? List<SecuritiesListData>.from((securityData.securities as List<dynamic>).map<SecuritiesListData?>((x) => SecuritiesListData.fromEntity(x as SecuritiesListDataEntity),),) : null,
      lenderInfo: securityData.lenderInfo != null ? List<LenderInfo>.from((securityData.lenderInfo as List<dynamic>).map<LenderInfo?>((x) => LenderInfo.fromEntity(x as LenderInfoEntity),),) : null,
    );
  }

  SecurityDataEntity toEntity() =>
      SecurityDataEntity(
        securities: securities?.map((x) => x.toEntity()).toList(),
        lenderInfo: lenderInfo?.map((x) => x.toEntity()).toList(),

      );
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

  SecuritiesListDataEntity toEntity() => SecuritiesListDataEntity(
        iSIN: iSIN,
        category: category,
        scripName: scripName,
        price: price,
        lenders: lenders,
        amcImage: amcImage,
        branch: branch,
        clientCode: clientCode,
        clientName: clientName,
        depository: depository,
        stockAt: stockAt,
        quantity: quantity,
        scripValue: scripValue,
        holdingAsOn: holdingAsOn,
        isEligible: isEligible,
        totalQty: totalQty,
        waitingToBePledgedQty: waitingToBePledgedQty,
        waitingForApprovalPledgedQty: waitingForApprovalPledgedQty,
        unpledgedQuantity: unpledgedQuantity,
        isChoice: isChoice,
        eligiblePercentage: eligiblePercentage,
        eligibleLoan: eligibleLoan,
        securityValue: securityValue,
        isShowWarning: isShowWarning,
        forSearch: forSearch,
      );

  factory SecuritiesListData.fromEntity(SecuritiesListDataEntity securitiesListData) {
    return SecuritiesListData(
      iSIN: securitiesListData.iSIN != null ? securitiesListData.iSIN as String : null,
      category:securitiesListData.category != null ? securitiesListData.category as String : null,
      scripName:securitiesListData.scripName != null ? securitiesListData.scripName as String : null,
      price:securitiesListData.price != null ? securitiesListData.price as double : null,
      lenders:securitiesListData.lenders != null ? securitiesListData.lenders as String : null,
      amcImage:securitiesListData.amcImage != null ? securitiesListData.amcImage as String : null,
      branch:securitiesListData.branch != null ? securitiesListData.branch as String : null,
      clientCode:securitiesListData.clientCode != null ? securitiesListData.clientCode as String : null,
      clientName:securitiesListData.clientName != null ? securitiesListData.clientName as String : null,
      depository:securitiesListData.depository != null ? securitiesListData.depository as String : null,
      stockAt:securitiesListData.stockAt != null ? securitiesListData.stockAt as String : null,
      quantity:securitiesListData.quantity != null ? securitiesListData.quantity as double : null,
      scripValue:securitiesListData.scripValue != null ? securitiesListData.scripValue as double : null,
      holdingAsOn:securitiesListData.holdingAsOn != null ? securitiesListData.holdingAsOn as String : null,
      isEligible:securitiesListData.isEligible != null ? securitiesListData.isEligible as bool : null,
      totalQty:securitiesListData.totalQty != null ? securitiesListData.totalQty as double : null,
      waitingToBePledgedQty: securitiesListData.waitingToBePledgedQty != null ? securitiesListData.waitingToBePledgedQty as int : null,
      waitingForApprovalPledgedQty:securitiesListData.waitingForApprovalPledgedQty != null ? securitiesListData.waitingForApprovalPledgedQty as int : null,
      unpledgedQuantity: securitiesListData.unpledgedQuantity != null ? securitiesListData.unpledgedQuantity as int : null,
      isChoice: securitiesListData.isChoice != null ? securitiesListData.isChoice as int : null,
      eligiblePercentage:securitiesListData.eligiblePercentage != null ? securitiesListData.eligiblePercentage as double : null,
      eligibleLoan:securitiesListData.eligibleLoan != null ? securitiesListData.eligibleLoan as double : null,
      securityValue:securitiesListData.securityValue != null ? securitiesListData.securityValue as double : null,
      isShowWarning:securitiesListData.isShowWarning != null ? securitiesListData.isShowWarning as bool : null,
      forSearch:securitiesListData.forSearch != null ? securitiesListData.forSearch as bool : null,
    );
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

  factory LenderInfo.fromEntity(LenderInfoEntity lenderInfo) {
    return LenderInfo(
      name:lenderInfo.name != null ? lenderInfo.name as String : null,
      minimumSanctionedLimit:lenderInfo.minimumSanctionedLimit != null ? lenderInfo.minimumSanctionedLimit as double : null,
      maximumSanctionedLimit:lenderInfo.maximumSanctionedLimit != null ? lenderInfo.maximumSanctionedLimit as double : null,
      rateOfInterest:lenderInfo.rateOfInterest != null ? lenderInfo.rateOfInterest as double : null,
    );
  }

  LenderInfoEntity toEntity() =>
      LenderInfoEntity(
        name:name,
        minimumSanctionedLimit: minimumSanctionedLimit,
        maximumSanctionedLimit:maximumSanctionedLimit ,
        rateOfInterest: rateOfInterest,

      );
}

class CategoryWiseSecurityList{
  String? categoryName;
  List<SecuritiesListData>? items;

  CategoryWiseSecurityList(this.categoryName, this.items);
}

