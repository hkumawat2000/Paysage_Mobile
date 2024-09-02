
import 'package:lms/aa_getx/modules/account_statement/domain/entities/recent_transactions_response_entity.dart';

class RecentTransactionResponseModel {
  String? message;
  LoanData? loanData;
  String? pdfFileUrl;
  String? excelFileUrl;

  RecentTransactionResponseModel(
      {this.message, this.loanData, this.pdfFileUrl, this.excelFileUrl});

  RecentTransactionResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    loanData = json['data'] != null
        ? new LoanData.fromJson(json['data'])
        : null;
    pdfFileUrl = json['pdf_file_url'];
    excelFileUrl = json['excel_file_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.loanData != null) {
      data['data'] = this.loanData!.toJson();
    }
    data['pdf_file_url'] = this.pdfFileUrl;
    data['excel_file_url'] = this.excelFileUrl;
    return data;
  }


  RecentTransactionResponseEntity toEntity() =>
      RecentTransactionResponseEntity(
        message:message,
        loanData:loanData?.toEntity(),
        pdfFileUrl:pdfFileUrl,
        excelFileUrl:excelFileUrl,

      );
}

class LoanData {
  Loan? loan;
  List<PledgedSecuritiesTransactions>? pledgedSecuritiesTransactions;

  LoanData({this.loan, this.pledgedSecuritiesTransactions});

  LoanData.fromJson(Map<String, dynamic> json) {
    loan = json['loan'] != null ? new Loan.fromJson(json['loan']) : null;
    if (json['pledged_securities_transactions'] != null) {
      pledgedSecuritiesTransactions = <PledgedSecuritiesTransactions>[];
      json['pledged_securities_transactions'].forEach((v) {
        pledgedSecuritiesTransactions!
            .add(new PledgedSecuritiesTransactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loan != null) {
      data['loan'] = this.loan!.toJson();
    }
    if (this.pledgedSecuritiesTransactions != null) {
      data['pledged_securities_transactions'] =
          this.pledgedSecuritiesTransactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  LoanDataEntity toEntity() =>
      LoanDataEntity(
        loan: loan?.toEntity(),
        pledgedSecuritiesTransactions: pledgedSecuritiesTransactions?.map((x) => x.toEntity()).toList(),

      );
}

class Loan {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  double? totalCollateralValue;
  String? totalCollateralValueStr;
  double? drawingPower;
  String? drawingPowerStr;
  String? lender;
  double? sanctionedLimit;
  String? sanctionedLimitStr;
  double? balance;
  String? balanceStr;
  String? customer;
  String? customerName;
  double? allowableLtv;
  String? expiryDate;
  String? loanAgreement;
  int? isEligibleForInterest;
  int? isIrregular;
  int? isPenalize;
  String? doctype;
  List<Items>? items;

  Loan(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.totalCollateralValue,
        this.totalCollateralValueStr,
        this.drawingPower,
        this.drawingPowerStr,
        this.lender,
        this.sanctionedLimit,
        this.sanctionedLimitStr,
        this.balance,
        this.balanceStr,
        this.customer,
        this.customerName,
        this.allowableLtv,
        this.expiryDate,
        this.loanAgreement,
        this.isEligibleForInterest,
        this.isIrregular,
        this.isPenalize,
        this.doctype,
        this.items});

  Loan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    totalCollateralValue = json['total_collateral_value'];
    totalCollateralValueStr = json['total_collateral_value_str'];
    drawingPower = json['drawing_power'];
    drawingPowerStr = json['drawing_power_str'];
    lender = json['lender'];
    sanctionedLimit = json['sanctioned_limit'];
    sanctionedLimitStr = json['sanctioned_limit_str'];
    balance = json['balance'];
    balanceStr = json['balance_str'];
    customer = json['customer'];
    customerName = json['customer_name'];
    allowableLtv = json['allowable_ltv'];
    expiryDate = json['expiry_date'];
    loanAgreement = json['loan_agreement'];
    isEligibleForInterest = json['is_eligible_for_interest'];
    isIrregular = json['is_irregular'];
    isPenalize = json['is_penalize'];
    doctype = json['doctype'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['idx'] = this.idx;
    data['docstatus'] = this.docstatus;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['total_collateral_value_str'] = this.totalCollateralValueStr;
    data['drawing_power'] = this.drawingPower;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['lender'] = this.lender;
    data['sanctioned_limit'] = this.sanctionedLimit;
    data['sanctioned_limit_str'] = this.sanctionedLimitStr;
    data['balance'] = this.balance;
    data['balance_str'] = this.balanceStr;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['allowable_ltv'] = this.allowableLtv;
    data['expiry_date'] = this.expiryDate;
    data['loan_agreement'] = this.loanAgreement;
    data['is_eligible_for_interest'] = this.isEligibleForInterest;
    data['is_irregular'] = this.isIrregular;
    data['is_penalize'] = this.isPenalize;
    data['doctype'] = this.doctype;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  LoanEntity toEntity() =>
      LoanEntity(
        name:name,
        owner:owner,
        creation:creation,
        modified:modified,
        modifiedBy:modifiedBy,
        idx:idx,
        docstatus:docstatus,
        totalCollateralValue:totalCollateralValue,
        totalCollateralValueStr:totalCollateralValueStr,
        drawingPower:drawingPower,
        drawingPowerStr:drawingPowerStr,
        lender:lender,
        sanctionedLimit:sanctionedLimit,
        sanctionedLimitStr:sanctionedLimitStr,
        balance:balance,
        balanceStr:balanceStr,
        customer:customer,
        customerName:customerName,
        allowableLtv:allowableLtv,
        expiryDate:expiryDate,
        loanAgreement:loanAgreement,
        isEligibleForInterest:isEligibleForInterest,
        isIrregular:isIrregular,
        isPenalize:isPenalize,
        doctype:doctype,
        items:items?.map((x) => x.toEntity()).toList(),

      );
}

class Items {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  int? docstatus;
  String? isin;
  String? securityName;
  String? securityCategory;
  double? pledgedQuantity;
  double? price;
  double? amount;
  String? doctype;

  Items(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.idx,
        this.docstatus,
        this.isin,
        this.securityName,
        this.securityCategory,
        this.pledgedQuantity,
        this.price,
        this.amount,
        this.doctype});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    isin = json['isin'];
    securityName = json['security_name'];
    securityCategory = json['security_category'];
    pledgedQuantity = json['pledged_quantity'];
    price = json['price'];
    amount = json['amount'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['docstatus'] = this.docstatus;
    data['isin'] = this.isin;
    data['security_name'] = this.securityName;
    data['security_category'] = this.securityCategory;
    data['pledged_quantity'] = this.pledgedQuantity;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['doctype'] = this.doctype;
    return data;
  }

  ItemsEntity toEntity() =>
      ItemsEntity(
        name:name,
        owner:owner,
        creation:creation,
        modified:modified,
        modifiedBy:modifiedBy,
        parent:parent,
        parentfield:parentfield,
        parenttype:parenttype,
        idx:idx,
        docstatus:docstatus,
        isin:isin,
        securityName:securityName,
        securityCategory:securityCategory,
        pledgedQuantity:pledgedQuantity,
        price:price,
        amount:amount,
        doctype:doctype,

      );
}

class PledgedSecuritiesTransactions {
  String? creation;
  String? securityName;
  String? isin;
  double? quantity;
  String? requestType;
  String? folio;
  String? securityCategory;
  double? eligiblePercentage;

  PledgedSecuritiesTransactions(
      {this.creation,
        this.securityName,
        this.isin,
        this.quantity,
        this.requestType,
        this.folio,
        this.securityCategory,
        this.eligiblePercentage});

  PledgedSecuritiesTransactions.fromJson(Map<String, dynamic> json) {
    creation = json['creation'];
    securityName = json['security_name'];
    isin = json['isin'];
    quantity = json['quantity'];
    requestType = json['request_type'];
    folio = json['folio'];
    securityCategory = json['security_category'];
    eligiblePercentage = json['eligible_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['creation'] = this.creation;
    data['security_name'] = this.securityName;
    data['isin'] = this.isin;
    data['quantity'] = this.quantity;
    data['request_type'] = this.requestType;
    data['folio'] = this.folio;
    data['security_category'] = this.securityCategory;
    data['eligible_percentage'] = this.eligiblePercentage;
    return data;
  }

  PledgedSecuritiesTransactionsEntity toEntity() =>
      PledgedSecuritiesTransactionsEntity(
        creation:creation,
        securityName:securityName,
        isin:isin,
        quantity:quantity,
        requestType:requestType,
        folio:folio,
        securityCategory:securityCategory,
        eligiblePercentage:eligiblePercentage,

      );
}
