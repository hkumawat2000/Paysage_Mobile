

class AtrinaBankResponseEntity {
  String? message;
  AtrinaBankDataEntity? atrinaBankData;

  AtrinaBankResponseEntity({this.message, this.atrinaBankData});
}

class AtrinaBankDataEntity {
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
  List<BankAccountEntity>? bankAccount;

  AtrinaBankDataEntity(
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
}

class BankAccountEntity {
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

  BankAccountEntity(
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
}