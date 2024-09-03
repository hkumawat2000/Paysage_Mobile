// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoanWithdrawResponseEntity {
  String? message;
  LoanWithDrawDetailDataResponseEntity? loanWithDrawDetailDataResponseEntity;
  LoanWithdrawResponseEntity({
    this.message,
    this.loanWithDrawDetailDataResponseEntity,
  });
}

class LoanWithDrawDetailDataResponseEntity {
  LoanDataResponseEntity? loanDataResponseEntity;
  List<BanksResponseEntity>? banks;

  LoanWithDrawDetailDataResponseEntity({
    this.loanDataResponseEntity,
    this.banks,
  });
}

class LoanDataResponseEntity {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
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
  List<ItemsResponseEntity>? items;
  double? amountAvailableForWithdrawal;
  LoanDataResponseEntity({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.totalCollateralValue,
    this.drawingPower,
    this.drawingPowerStr,
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
    this.amountAvailableForWithdrawal,
  });
}

class ItemsResponseEntity {
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
  ItemsResponseEntity({
    this.name,
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
    this.doctype,
  });
}

class BanksResponseEntity {
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
  BanksResponseEntity({
    this.name,
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
  });
}
