// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/domain/entities/bank_account_response_entity.dart';

class BankAccountDetailsResponseModel {
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

  BankAccountDetailsResponseModel(
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

  BankAccountDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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

  BankAccountDetailsResponseEntity toEntity() =>
      BankAccountDetailsResponseEntity(
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
        doctype: doctype,
      );

  factory BankAccountDetailsResponseModel.fromEntity(
      BankAccountDetailsResponseEntity bankAccountDetailsResponseEntity) {
    return BankAccountDetailsResponseModel(
      name: bankAccountDetailsResponseEntity.name != null
          ? bankAccountDetailsResponseEntity.name as String
          : null,
      owner: bankAccountDetailsResponseEntity.owner != null
          ? bankAccountDetailsResponseEntity.owner as String
          : null,
      creation: bankAccountDetailsResponseEntity.creation != null
          ? bankAccountDetailsResponseEntity.creation as String
          : null,
      modified: bankAccountDetailsResponseEntity.modified != null
          ? bankAccountDetailsResponseEntity.modified as String
          : null,
      modifiedBy: bankAccountDetailsResponseEntity.modifiedBy != null
          ? bankAccountDetailsResponseEntity.modifiedBy as String
          : null,
      parent: bankAccountDetailsResponseEntity.parent != null
          ? bankAccountDetailsResponseEntity.parent as String
          : null,
      parentfield: bankAccountDetailsResponseEntity.parentfield != null
          ? bankAccountDetailsResponseEntity.parentfield as String
          : null,
      parenttype: bankAccountDetailsResponseEntity.parenttype != null
          ? bankAccountDetailsResponseEntity.parenttype as String
          : null,
      idx: bankAccountDetailsResponseEntity.idx != null
          ? bankAccountDetailsResponseEntity.idx as int
          : null,
      docstatus: bankAccountDetailsResponseEntity.docstatus != null
          ? bankAccountDetailsResponseEntity.docstatus as int
          : null,
      bank: bankAccountDetailsResponseEntity.bank != null
          ? bankAccountDetailsResponseEntity.bank as String
          : null,
      branch: bankAccountDetailsResponseEntity.branch != null
          ? bankAccountDetailsResponseEntity.branch as String
          : null,
      accountNumber: bankAccountDetailsResponseEntity.accountNumber != null
          ? bankAccountDetailsResponseEntity.accountNumber as String
          : null,
      ifsc: bankAccountDetailsResponseEntity.ifsc != null
          ? bankAccountDetailsResponseEntity.ifsc as String
          : null,
      bankCode: bankAccountDetailsResponseEntity.bankCode != null
          ? bankAccountDetailsResponseEntity.bankCode as String
          : null,
      city: bankAccountDetailsResponseEntity.city != null
          ? bankAccountDetailsResponseEntity.city as String
          : null,
      state: bankAccountDetailsResponseEntity.state != null
          ? bankAccountDetailsResponseEntity.state as String
          : null,
      isDefault: bankAccountDetailsResponseEntity.isDefault != null
          ? bankAccountDetailsResponseEntity.isDefault as int
          : null,
      bankAddress: bankAccountDetailsResponseEntity.bankAddress != null
          ? bankAccountDetailsResponseEntity.bankAddress as String
          : null,
      contact: bankAccountDetailsResponseEntity.contact != null
          ? bankAccountDetailsResponseEntity.contact as String
          : null,
      accountType: bankAccountDetailsResponseEntity.accountType != null
          ? bankAccountDetailsResponseEntity.accountType as String
          : null,
      micr: bankAccountDetailsResponseEntity.micr != null
          ? bankAccountDetailsResponseEntity.micr as String
          : null,
      bankMode: bankAccountDetailsResponseEntity.bankMode != null
          ? bankAccountDetailsResponseEntity.bankMode as String
          : null,
      bankZipCode: bankAccountDetailsResponseEntity.bankZipCode != null
          ? bankAccountDetailsResponseEntity.bankZipCode as String
          : null,
      district: bankAccountDetailsResponseEntity.district != null
          ? bankAccountDetailsResponseEntity.district as String
          : null,
      doctype: bankAccountDetailsResponseEntity.doctype != null
          ? bankAccountDetailsResponseEntity.doctype as String
          : null,
    );
  }
}
