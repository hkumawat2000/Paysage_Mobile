import 'package:lms/aa_getx/modules/withdraw/domain/entities/loan_withdraw_response_entity.dart';

class LoanWithdrawResponseModel {
  String? message;
  LoanWithDrawDetailDataResponseModel? loanWithDrawDetailDataResponseModel;

  LoanWithdrawResponseModel(
      {this.message, this.loanWithDrawDetailDataResponseModel});

  LoanWithdrawResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    loanWithDrawDetailDataResponseModel =
    json['data'] != null
        ? new LoanWithDrawDetailDataResponseModel.fromJson(
        json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.loanWithDrawDetailDataResponseModel != null) {
      data['LoanWithDrawDetailDataResponseModel'] =
          this.loanWithDrawDetailDataResponseModel!.toJson();
    }
    return data;
  }

  LoanWithdrawResponseEntity toEntity() => LoanWithdrawResponseEntity(
    message: message,
    loanWithDrawDetailDataResponseEntity:
    loanWithDrawDetailDataResponseModel?.toEntity(),
  );
}

class LoanWithDrawDetailDataResponseModel {
  Loan? loan;
  List<Banks>? banks;

  LoanWithDrawDetailDataResponseModel({this.loan, this.banks});

  LoanWithDrawDetailDataResponseModel.fromJson(Map<String, dynamic> json) {
    loan = json['loan'] != null ? new Loan.fromJson(json['loan']) : null;
    if (json['banks'] != null) {
      banks = <Banks>[];
      json['banks'].forEach((v) {
        banks!.add(new Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loan != null) {
      data['loan'] = this.loan!.toJson();
    }
    if (this.banks != null) {
      data['banks'] = this.banks!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  LoanWithDrawDetailDataResponseEntity toEntity() =>
      LoanWithDrawDetailDataResponseEntity(
        loanDataResponseEntity: loan?.toEntity(),
        banks: banks?.map((x) => x.toEntity()).toList(),
      );
}

class Loan {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  double? totalCollateralValue;
  String? totalCollateralValueStr;
  double? drawingPower;
  String? drawingPowerStr;
  String? lender;
  double? sanctionedLimit;
  String? sanctionedLimitStr;
  double? balance;
  String? balanceStr;
  int? isClosed;
  String? customer;
  String? customerName;
  double? availableTopupAmt;
  double? actualDrawingPower;
  String? expiryDate;
  String? loanAgreement;
  String? slCialEntries;
  double? marginShortfallAmount;
  String? instrumentType;
  String? schemeType;
  int? isEligibleForInterest;
  int? isIrregular;
  int? isPenalize;
  double? baseInterest;
  double? baseInterestConfig;
  double? baseInterestAmount;
  double? interestDue;
  double? penalInterestCharges;
  double? totalInterestInclPenalDue;
  double? rebateInterest;
  double? rebateInterestConfig;
  double? rebateInterestAmount;
  double? interestOverdue;
  int? dayPastDue;
  double? customBaseInterest;
  double? oldInterest;
  String? wefDate;
  int? isDefault;
  double? customRebateInterest;
  double? oldRebateInterest;
  String? oldWefDate;
  String? doctype;
  List<Items>? items;
  double? amountAvailableForWithdrawal;

  Loan(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.totalCollateralValue,
        this.totalCollateralValueStr,
        this.drawingPower,
        this.drawingPowerStr,
        this.lender,
        this.sanctionedLimit,
        this.sanctionedLimitStr,
        this.balance,
        this.balanceStr,
        this.isClosed,
        this.customer,
        this.customerName,
        this.availableTopupAmt,
        this.actualDrawingPower,
        this.expiryDate,
        this.loanAgreement,
        this.slCialEntries,
        this.marginShortfallAmount,
        this.instrumentType,
        this.schemeType,
        this.isEligibleForInterest,
        this.isIrregular,
        this.isPenalize,
        this.baseInterest,
        this.baseInterestConfig,
        this.baseInterestAmount,
        this.interestDue,
        this.penalInterestCharges,
        this.totalInterestInclPenalDue,
        this.rebateInterest,
        this.rebateInterestConfig,
        this.rebateInterestAmount,
        this.interestOverdue,
        this.dayPastDue,
        this.customBaseInterest,
        this.oldInterest,
        this.wefDate,
        this.isDefault,
        this.customRebateInterest,
        this.oldRebateInterest,
        this.oldWefDate,
        this.doctype,
        this.items,
        this.amountAvailableForWithdrawal});

  Loan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    totalCollateralValue = json['total_collateral_value'];
    totalCollateralValueStr = json['total_collateral_value_str'];
    drawingPower = json['drawing_power'];
    drawingPowerStr = json['drawing_power_str'];
    lender = json['lender'];
    sanctionedLimit = json['sanctioned_limit'];
    sanctionedLimitStr = json['sanctioned_limit_str'];
    balance = json['balance'];
    balanceStr = json['balance_str'];
    isClosed = json['is_closed'];
    customer = json['customer'];
    customerName = json['customer_name'];
    availableTopupAmt = json['available_topup_amt'];
    actualDrawingPower = json['actual_drawing_power'];
    expiryDate = json['expiry_date'];
    loanAgreement = json['loan_agreement'];
    slCialEntries = json['sl_cial_entries'];
    marginShortfallAmount = json['margin_shortfall_amount'];
    instrumentType = json['instrument_type'];
    schemeType = json['scheme_type'];
    isEligibleForInterest = json['is_eligible_for_interest'];
    isIrregular = json['is_irregular'];
    isPenalize = json['is_penalize'];
    baseInterest = json['base_interest'];
    baseInterestConfig = json['base_interest_config'];
    baseInterestAmount = json['base_interest_amount'];
    interestDue = json['interest_due'];
    penalInterestCharges = json['penal_interest_charges'];
    totalInterestInclPenalDue = json['total_interest_incl_penal_due'];
    rebateInterest = json['rebate_interest'];
    rebateInterestConfig = json['rebate_interest_config'];
    rebateInterestAmount = json['rebate_interest_amount'];
    interestOverdue = json['interest_overdue'];
    dayPastDue = json['day_past_due'];
    customBaseInterest = json['custom_base_interest'];
    oldInterest = json['old_interest'];
    wefDate = json['wef_date'];
    isDefault = json['is_default'];
    customRebateInterest = json['custom_rebate_interest'];
    oldRebateInterest = json['old_rebate_interest'];
    oldWefDate = json['old_wef_date'];
    doctype = json['doctype'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    amountAvailableForWithdrawal = json['amount_available_for_withdrawal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['total_collateral_value_str'] = this.totalCollateralValueStr;
    data['drawing_power'] = this.drawingPower;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['lender'] = this.lender;
    data['sanctioned_limit'] = this.sanctionedLimit;
    data['sanctioned_limit_str'] = this.sanctionedLimitStr;
    data['balance'] = this.balance;
    data['balance_str'] = this.balanceStr;
    data['is_closed'] = this.isClosed;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['available_topup_amt'] = this.availableTopupAmt;
    data['actual_drawing_power'] = this.actualDrawingPower;
    data['expiry_date'] = this.expiryDate;
    data['loan_agreement'] = this.loanAgreement;
    data['sl_cial_entries'] = this.slCialEntries;
    data['margin_shortfall_amount'] = this.marginShortfallAmount;
    data['instrument_type'] = this.instrumentType;
    data['scheme_type'] = this.schemeType;
    data['is_eligible_for_interest'] = this.isEligibleForInterest;
    data['is_irregular'] = this.isIrregular;
    data['is_penalize'] = this.isPenalize;
    data['base_interest'] = this.baseInterest;
    data['base_interest_config'] = this.baseInterestConfig;
    data['base_interest_amount'] = this.baseInterestAmount;
    data['interest_due'] = this.interestDue;
    data['penal_interest_charges'] = this.penalInterestCharges;
    data['total_interest_incl_penal_due'] = this.totalInterestInclPenalDue;
    data['rebate_interest'] = this.rebateInterest;
    data['rebate_interest_config'] = this.rebateInterestConfig;
    data['rebate_interest_amount'] = this.rebateInterestAmount;
    data['interest_overdue'] = this.interestOverdue;
    data['day_past_due'] = this.dayPastDue;
    data['custom_base_interest'] = this.customBaseInterest;
    data['old_interest'] = this.oldInterest;
    data['wef_date'] = this.wefDate;
    data['is_default'] = this.isDefault;
    data['custom_rebate_interest'] = this.customRebateInterest;
    data['old_rebate_interest'] = this.oldRebateInterest;
    data['old_wef_date'] = this.oldWefDate;
    data['doctype'] = this.doctype;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['amount_available_for_withdrawal'] = this.amountAvailableForWithdrawal;
    return data;
  }

  LoanDataResponseEntity toEntity() =>
      LoanDataResponseEntity(
        name: name,
        owner: owner,
        creation: creation,
        modified: modified,
        modifiedBy: modifiedBy,
        idx: idx,
        docstatus: docstatus,
        totalCollateralValue: totalCollateralValue,
        drawingPower: drawingPower,
        drawingPowerStr: drawingPowerStr,
        lender: lender,
        sanctionedLimit: sanctionedLimit,
        balance: balance,
        balanceStr: balanceStr,
        customer: customer,
        expiryDate: expiryDate,
        loanAgreement: loanAgreement,
        doctype: doctype,
        items: items?.map((x) => x.toEntity()).toList(),
        amountAvailableForWithdrawal: amountAvailableForWithdrawal,

      );
}

class Items {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? docstatus;
  int? idx;
  String? isin;
  String? securityName;
  String? securityCategory;
  double? pledgedQuantity;
  double? eligiblePercentage;
  double? eligibleAmount;
  double? price;
  double? amount;
  String? type;
  String? psn;
  String? parent;
  String? parentfield;
  String? parenttype;
  String? doctype;

  Items(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.docstatus,
        this.idx,
        this.isin,
        this.securityName,
        this.securityCategory,
        this.pledgedQuantity,
        this.eligiblePercentage,
        this.eligibleAmount,
        this.price,
        this.amount,
        this.type,
        this.psn,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.doctype});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    isin = json['isin'];
    securityName = json['security_name'];
    securityCategory = json['security_category'];
    pledgedQuantity = json['pledged_quantity'];
    eligiblePercentage = json['eligible_percentage'];
    eligibleAmount = json['eligible_amount'];
    price = json['price'];
    amount = json['amount'];
    type = json['type'];
    psn = json['psn'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['isin'] = this.isin;
    data['security_name'] = this.securityName;
    data['security_category'] = this.securityCategory;
    data['pledged_quantity'] = this.pledgedQuantity;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['eligible_amount'] = this.eligibleAmount;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['type'] = this.type;
    data['psn'] = this.psn;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['doctype'] = this.doctype;
    return data;
  }

  ItemsResponseEntity toEntity() =>
      ItemsResponseEntity(
        name: name,
        owner: owner,
        creation: creation,
        modified: modified,
        modifiedBy: modifiedBy,
        parent: parent,
        parentfield: parentfield,
        parenttype: parenttype,
        idx: idx,
        docstatus: docstatus,
        isin: isin,
        securityName: securityName,
        securityCategory: securityCategory,
        pledgedQuantity: pledgedQuantity,
        price: price,
        amount: amount,
        psn: psn,
        doctype: doctype,
      );
}

class Banks {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  String? bankStatus;
  String? bank;
  String? branch;
  String? accountNumber;
  String? ifsc;
  Null? bankCode;
  String? city;
  Null? state;
  int? isDefault;
  Null? isSparkDefault;
  String? pennyRequestId;
  String? bankTransactionStatus;
  String? accountHolderName;
  String? personalizedCheque;
  Null? bankAddress;
  Null? contact;
  String? accountType;
  Null? micr;
  Null? bankMode;
  Null? bankZipCode;
  Null? district;
  int? notificationSent;
  int? isRepeated;
  int? isMismatched;
  String? parent;
  String? parentfield;
  String? parenttype;

  Banks(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        this.idx,
        this.bankStatus,
        this.bank,
        this.branch,
        this.accountNumber,
        this.ifsc,
        this.bankCode,
        this.city,
        this.state,
        this.isDefault,
        this.isSparkDefault,
        this.pennyRequestId,
        this.bankTransactionStatus,
        this.accountHolderName,
        this.personalizedCheque,
        this.bankAddress,
        this.contact,
        this.accountType,
        this.micr,
        this.bankMode,
        this.bankZipCode,
        this.district,
        this.notificationSent,
        this.isRepeated,
        this.isMismatched,
        this.parent,
        this.parentfield,
        this.parenttype});

  Banks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    bankStatus = json['bank_status'];
    bank = json['bank'];
    branch = json['branch'];
    accountNumber = json['account_number'];
    ifsc = json['ifsc'];
    bankCode = json['bank_code'];
    city = json['city'];
    state = json['state'];
    isDefault = json['is_default'];
    isSparkDefault = json['is_spark_default'];
    pennyRequestId = json['penny_request_id'];
    bankTransactionStatus = json['bank_transaction_status'];
    accountHolderName = json['account_holder_name'];
    personalizedCheque = json['personalized_cheque'];
    bankAddress = json['bank_address'];
    contact = json['contact'];
    accountType = json['account_type'];
    micr = json['micr'];
    bankMode = json['bank_mode'];
    bankZipCode = json['bank_zip_code'];
    district = json['district'];
    notificationSent = json['notification_sent'];
    isRepeated = json['is_repeated'];
    isMismatched = json['is_mismatched'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['bank_status'] = this.bankStatus;
    data['bank'] = this.bank;
    data['branch'] = this.branch;
    data['account_number'] = this.accountNumber;
    data['ifsc'] = this.ifsc;
    data['bank_code'] = this.bankCode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['is_default'] = this.isDefault;
    data['is_spark_default'] = this.isSparkDefault;
    data['penny_request_id'] = this.pennyRequestId;
    data['bank_transaction_status'] = this.bankTransactionStatus;
    data['account_holder_name'] = this.accountHolderName;
    data['personalized_cheque'] = this.personalizedCheque;
    data['bank_address'] = this.bankAddress;
    data['contact'] = this.contact;
    data['account_type'] = this.accountType;
    data['micr'] = this.micr;
    data['bank_mode'] = this.bankMode;
    data['bank_zip_code'] = this.bankZipCode;
    data['district'] = this.district;
    data['notification_sent'] = this.notificationSent;
    data['is_repeated'] = this.isRepeated;
    data['is_mismatched'] = this.isMismatched;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    return data;
  }

  BanksResponseEntity toEntity() =>
      BanksResponseEntity(
        name: name,
        creation: creation,
        modified: modified,
        modifiedBy: modifiedBy,
        owner: owner,
        docstatus: docstatus,
        parent: parent,
        parentfield: parentfield,
        parenttype: parenttype,
        idx: idx,
        bank: bank,
        branch: branch,
        accountNumber: accountNumber,
        ifsc: ifsc,
        bankCode: bankCode,
        city: city,
        state: state,
        isDefault: isDefault,
        bankAddress: bankAddress,
        contact: contact,
        accountType: accountType,
        micr: micr,
        bankMode: bankMode,
        bankZipCode: bankZipCode,
        district: district,
      );
}
