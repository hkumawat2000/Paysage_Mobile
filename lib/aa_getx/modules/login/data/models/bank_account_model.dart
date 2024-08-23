// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/login/domain/entity/bank_account_entity.dart';

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
  String? bankStatus;
  String? bank;
  String? branch;
  String? accountNumber;
  String? ifsc;
  String? city;
  int? isDefault;
  String? razorpayFundAccountId;
  String? accountHolderName;
  String? personalizedCheque;
  String? accountType;
  String? razorpayFundAccountValidationId;
  int? notificationSent;
  String? doctype;
  String? bankCode;
  String? state;
  String? bankAddress;
  String? contact;
  String? micr;
  String? bankMode;
  String? bankZipCode;
  String? district;

  BankAccount({this.name, this.owner, this.creation, this.modified, this.modifiedBy, this.parent, this.parentfield, this.parenttype, this.idx, this.docstatus, this.bankStatus, this.bank, this.branch, this.accountNumber, this.ifsc, this.city, this.isDefault, this.razorpayFundAccountId, this.accountHolderName, this.personalizedCheque, this.accountType, this.razorpayFundAccountValidationId, this.notificationSent, this.doctype, this.bankCode, this.state, this.bankAddress, this.contact, this.micr, this.bankMode, this.bankZipCode, this.district});

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
    bankStatus = json['bank_status'];
    bank = json['bank'];
    branch = json['branch'];
    accountNumber = json['account_number'];
    ifsc = json['ifsc'];
    city = json['city'];
    isDefault = json['is_default'];
    razorpayFundAccountId = json['razorpay_fund_account_id'];
    accountHolderName = json['account_holder_name'];
    personalizedCheque = json['personalized_cheque'];
    accountType = json['account_type'];
    razorpayFundAccountValidationId = json['razorpay_fund_account_validation_id'];
    notificationSent = json['notification_sent'];
    doctype = json['doctype'];
    bankCode = json['bank_code'];
    state = json['state'];
    bankAddress = json['bank_address'];
    contact = json['contact'];
    micr = json['micr'];
    bankMode = json['bank_mode'];
    bankZipCode = json['bank_zip_code'];
    district = json['district'];
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
    data['bank_status'] = this.bankStatus;
    data['bank'] = this.bank;
    data['branch'] = this.branch;
    data['account_number'] = this.accountNumber;
    data['ifsc'] = this.ifsc;
    data['city'] = this.city;
    data['is_default'] = this.isDefault;
    data['razorpay_fund_account_id'] = this.razorpayFundAccountId;
    data['account_holder_name'] = this.accountHolderName;
    data['personalized_cheque'] = this.personalizedCheque;
    data['account_type'] = this.accountType;
    data['razorpay_fund_account_validation_id'] = this.razorpayFundAccountValidationId;
    data['notification_sent'] = this.notificationSent;
    data['doctype'] = this.doctype;
    data['bank_code'] = this.bankCode;
    data['state'] = this.state;
    data['bank_address'] = this.bankAddress;
    data['contact'] = this.contact;
    data['micr'] = this.micr;
    data['bank_mode'] = this.bankMode;
    data['bank_zip_code'] = this.bankZipCode;
    data['district'] = this.district;
    return data;
  }

  BankAccountEntity toEntity() =>
  BankAccountEntity(
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
      bankStatus: bankStatus,
      bank: bank,
      branch: branch,
      accountNumber: accountNumber,
      ifsc: ifsc,
      city: city,
      isDefault: isDefault,
      razorpayFundAccountId: razorpayFundAccountId,
      accountHolderName: accountHolderName,
      personalizedCheque: personalizedCheque,
      accountType: accountType,
      razorpayFundAccountValidationId: razorpayFundAccountValidationId,
      notificationSent: notificationSent,
      doctype: doctype,
      bankCode: bankCode,
      state: state,
      bankAddress: bankAddress,
      contact: contact,
      micr: micr,
      bankMode: bankMode,
      bankZipCode: bankZipCode,
      district: district,
  
  );

  factory BankAccount.fromEntity(BankAccount bankAccount) {
    return BankAccount(
      name: bankAccount.name != null ? bankAccount.name as String : null,
      owner: bankAccount.owner != null ? bankAccount.owner as String : null,
      creation: bankAccount.creation != null ? bankAccount.creation as String : null,
      modified: bankAccount.modified != null ? bankAccount.modified as String : null,
      modifiedBy: bankAccount.modifiedBy != null ? bankAccount.modifiedBy as String : null,
      parent: bankAccount.parent != null ? bankAccount.parent as String : null,
      parentfield: bankAccount.parentfield != null ? bankAccount.parentfield as String : null,
      parenttype: bankAccount.parenttype != null ? bankAccount.parenttype as String : null,
      idx: bankAccount.idx != null ? bankAccount.idx as int : null,
      docstatus: bankAccount.docstatus != null ? bankAccount.docstatus as int : null,
      bankStatus: bankAccount.bankStatus != null ? bankAccount.bankStatus as String : null,
      bank: bankAccount.bank != null ? bankAccount.bank as String : null,
      branch: bankAccount.branch != null ? bankAccount.branch as String : null,
      accountNumber: bankAccount.accountNumber != null ? bankAccount.accountNumber as String : null,
      ifsc: bankAccount.ifsc != null ? bankAccount.ifsc as String : null,
      city: bankAccount.city != null ? bankAccount.city as String : null,
      isDefault: bankAccount.isDefault != null ? bankAccount.isDefault as int : null,
      razorpayFundAccountId: bankAccount.razorpayFundAccountId != null ? bankAccount.razorpayFundAccountId as String : null,
      accountHolderName: bankAccount.accountHolderName != null ? bankAccount.accountHolderName as String : null,
      personalizedCheque: bankAccount.personalizedCheque != null ? bankAccount.personalizedCheque as String : null,
      accountType: bankAccount.accountType != null ? bankAccount.accountType as String : null,
      razorpayFundAccountValidationId: bankAccount.razorpayFundAccountValidationId != null ? bankAccount.razorpayFundAccountValidationId as String : null,
      notificationSent: bankAccount.notificationSent != null ? bankAccount.notificationSent as int : null,
      doctype: bankAccount.doctype != null ? bankAccount.doctype as String : null,
      bankCode: bankAccount.bankCode != null ? bankAccount.bankCode as String : null,
      state: bankAccount.state != null ? bankAccount.state as String : null,
      bankAddress: bankAccount.bankAddress != null ? bankAccount.bankAddress as String : null,
      contact: bankAccount.contact != null ? bankAccount.contact as String : null,
      micr: bankAccount.micr != null ? bankAccount.micr as String : null,
      bankMode: bankAccount.bankMode != null ? bankAccount.bankMode as String : null,
      bankZipCode: bankAccount.bankZipCode != null ? bankAccount.bankZipCode as String : null,
      district: bankAccount.district != null ? bankAccount.district as String : null,
    );
  }
}
