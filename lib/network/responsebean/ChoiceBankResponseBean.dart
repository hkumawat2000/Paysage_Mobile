import 'package:choice/network/ModelWrapper.dart';

class ChoiceBankResponseBean extends ModelWrapper<List<ChoiceBankData>>{
  String? message;
  ChoiceBankData? choiceBankData;

  ChoiceBankResponseBean({this.message, this.choiceBankData});

  ChoiceBankResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    choiceBankData = json['data'] != null ? new ChoiceBankData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.choiceBankData != null) {
      data['data'] = this.choiceBankData!.toJson();
    }
    return data;
  }
}

class ChoiceBankData {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? user;
  String? kycType;
  String? investorName;
  String? panNo;
  String? mobileNumber;
  String? dateOfBirth;
  String? email;
  String? address;
  String? city;
  String? doctype;
  List<BankAccount>? bankAccount;

  ChoiceBankData(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.user,
        this.kycType,
        this.investorName,
        this.panNo,
        this.mobileNumber,
        this.dateOfBirth,
        this.email,
        this.address,
        this.city,
        this.doctype,
        this.bankAccount});

  ChoiceBankData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    user = json['user'];
    kycType = json['kyc_type'];
    investorName = json['investor_name'];
    panNo = json['pan_no'];
    mobileNumber = json['mobile_number'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    doctype = json['doctype'];
    if (json['bank_account'] != null) {
      bankAccount = <BankAccount>[];
      json['bank_account'].forEach((v) {
        bankAccount!.add(new BankAccount.fromJson(v));
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
    data['user'] = this.user;
    data['kyc_type'] = this.kycType;
    data['investor_name'] = this.investorName;
    data['pan_no'] = this.panNo;
    data['mobile_number'] = this.mobileNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['address'] = this.address;
    data['city'] = this.city;
    data['doctype'] = this.doctype;
    if (this.bankAccount != null) {
      data['bank_account'] = this.bankAccount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankAccount {
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
  String? doctype;

  BankAccount(
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
        this.doctype});

  BankAccount.fromJson(Map<String, dynamic> json) {
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
    data['doctype'] = this.doctype;
    return data;
  }
}
