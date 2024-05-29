import 'package:lms/network/ModelWrapper.dart';

class WithdrawDetailsResponse extends ModelWrapper<WithdrawDetailsData> {
  String? message;
  WithdrawDetailsData? withdrawDetailsData;

  WithdrawDetailsResponse({this.message, this.withdrawDetailsData});

  WithdrawDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    withdrawDetailsData = json['data'] != null ? new WithdrawDetailsData.fromJson(json['data']) : null;
    data = withdrawDetailsData;
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

class WithdrawDetailsData {
  Loan? loan;
  List<Banks>? banks;

  WithdrawDetailsData({this.loan, this.banks});

  WithdrawDetailsData.fromJson(Map<String, dynamic> json) {
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
}

class Loan {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  // Null parent;
  // Null parentfield;
  // Null parenttype;
  int? idx;
  int? docstatus;
  double? totalCollateralValue;
  double? drawingPower;
  String? drawingPowerStr;
  String? lender;
  double? sanctionedLimit;
  double? balance;
  String? balanceStr;
  String? customer;
  double? allowableLtv;
  String? expiryDate;
  String? loanAgreement;
  String? doctype;
  List<Items>? items;
  double? amountAvailableForWithdrawal;

  Loan(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        // this.parent,
        // this.parentfield,
        // this.parenttype,
        this.idx,
        this.docstatus,
        this.totalCollateralValue,
        this.drawingPower,
        this.lender,
        this.sanctionedLimit,
        this.balance,
        this.balanceStr,
        this.customer,
        this.allowableLtv,
        this.expiryDate,
        this.loanAgreement,
        this.doctype,
        this.items,
        this.amountAvailableForWithdrawal,this.drawingPowerStr});

  Loan.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    // parent = json['parent'];
    // parentfield = json['parentfield'];
    // parenttype = json['parenttype'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    totalCollateralValue = json['total_collateral_value'];
    drawingPower = json['drawing_power'];
    lender = json['lender'];
    sanctionedLimit = json['sanctioned_limit'];
    balance = json['balance'];
    balanceStr = json['balance_str'];
    customer = json['customer'];
    allowableLtv = json['allowable_ltv'];
    expiryDate = json['expiry_date'];
    loanAgreement = json['loan_agreement'];
    drawingPowerStr = json['drawing_power_str'];
    doctype = json['doctype'];
    if (json['items'] != null) {
      items =  <Items>[];
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
    // data['parent'] = this.parent;
    // data['parentfield'] = this.parentfield;
    // data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['docstatus'] = this.docstatus;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['drawing_power'] = this.drawingPower;
    data['lender'] = this.lender;
    data['sanctioned_limit'] = this.sanctionedLimit;
    data['balance'] = this.balance;
    data['balance_str'] = this.balanceStr;
    data['customer'] = this.customer;
    data['allowable_ltv'] = this.allowableLtv;
    data['expiry_date'] = this.expiryDate;
    data['loan_agreement'] = this.loanAgreement;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['doctype'] = this.doctype;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['amount_available_for_withdrawal'] = this.amountAvailableForWithdrawal;
    return data;
  }
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
  String? psn;
  String? errorCode;
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
        this.psn,
        this.errorCode,
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
    psn = json['psn'];
    errorCode = json['error_code'];
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
    data['psn'] = this.psn;
    data['error_code'] = this.errorCode;
    data['doctype'] = this.doctype;
    return data;
  }
}

class Banks {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  String? bank;
  String? branch;
  String? accountNumber;
  String? ifsc;
  String? bankCode;
  String? city;
  String? state;
  int? isDefault;
  String? bankAddress;
  String? contact;
  String? accountType;
  String? micr;
  String? bankMode;
  String? bankZipCode;
  String? district;
  String? userKyc;
  // Null nUserTags;
  // Null nComments;
  // Null nAssign;
  // Null nLikedBy;

  Banks(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.idx,
        this.bank,
        this.branch,
        this.accountNumber,
        this.ifsc,
        this.bankCode,
        this.city,
        this.state,
        this.isDefault,
        this.bankAddress,
        this.contact,
        this.accountType,
        this.micr,
        this.bankMode,
        this.bankZipCode,
        this.district,
        this.userKyc,
        // this.nUserTags,
        // this.nComments,
        // this.nAssign,
        // this.nLikedBy
      });

  Banks.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    idx = json['idx'];
    bank = json['bank'];
    branch = json['branch'];
    accountNumber = json['account_number'];
    ifsc = json['ifsc'];
    bankCode = json['bank_code'];
    city = json['city'];
    state = json['state'];
    isDefault = json['is_default'];
    bankAddress = json['bank_address'];
    contact = json['contact'];
    accountType = json['account_type'];
    micr = json['micr'];
    bankMode = json['bank_mode'];
    bankZipCode = json['bank_zip_code'];
    district = json['district'];
    userKyc = json['user_kyc'];
    // nUserTags = json['_user_tags'];
    // nComments = json['_comments'];
    // nAssign = json['_assign'];
    // nLikedBy = json['_liked_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['bank'] = this.bank;
    data['branch'] = this.branch;
    data['account_number'] = this.accountNumber;
    data['ifsc'] = this.ifsc;
    data['bank_code'] = this.bankCode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['is_default'] = this.isDefault;
    data['bank_address'] = this.bankAddress;
    data['contact'] = this.contact;
    data['account_type'] = this.accountType;
    data['micr'] = this.micr;
    data['bank_mode'] = this.bankMode;
    data['bank_zip_code'] = this.bankZipCode;
    data['district'] = this.district;
    data['user_kyc'] = this.userKyc;
    // data['_user_tags'] = this.nUserTags;
    // data['_comments'] = this.nComments;
    // data['_assign'] = this.nAssign;
    // data['_liked_by'] = this.nLikedBy;
    return data;
  }
}