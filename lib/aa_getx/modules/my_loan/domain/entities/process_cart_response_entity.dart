class ProcessCartResponseEntity {
  String? message;
  ProcessCartDataEntity? processCartData;

  ProcessCartResponseEntity({this.message, this.processCartData});
}

class ProcessCartDataEntity {
  LoanApplicationEntity? loanApplication;
  String? mycamUrl;

  ProcessCartDataEntity({this.loanApplication, this.mycamUrl});
}

class LoanApplicationEntity {
  double? allowableLtv;
  String? creation;
  String? customer;
  int? docstatus;
  String? doctype;
  double? drawingPower;
  String? expiryDate;
  int? idx;
  List<CommonItemsEntity>? items;
  String? loan;
  String? modified;
  String? modifiedBy;
  String? name;
  String? owner;

  // Null parent;
  // Null parentfield;
  // Null parenttype;
  String? pledgeeBoid;
  String? pledgorBoid;
  String? prfNumber;
  String? status;
  double? totalCollateralValue;
  String? workflowState;

  LoanApplicationEntity({
    this.allowableLtv,
    this.creation,
    this.customer,
    this.docstatus,
    this.doctype,
    this.drawingPower,
    this.expiryDate,
    this.idx,
    this.items,
    this.loan,
    this.modified,
    this.modifiedBy,
    this.name,
    this.owner,
    // this.parent,
    // this.parentfield,
    // this.parenttype,
    this.pledgeeBoid,
    this.pledgorBoid,
    this.prfNumber,
    this.status,
    this.totalCollateralValue,
    this.workflowState,
  });
}

class CommonItemsEntity {
  double? amount;
  String? creation;
  int? docstatus;
  String? doctype;
  String? errorCode;
  int? idx;
  String? isin;
  String? modified;
  String? modifiedBy;
  String? name;
  String? owner;
  String? parent;
  String? parentfield;
  String? parenttype;
  double? pledgedQuantity;
  double? price;
  String? psn;
  String? securityCategory;
  String? securityName;
  String? lenderApprovalStatus;

  CommonItemsEntity(
      {this.amount,
      this.creation,
      this.docstatus,
      this.doctype,
      this.errorCode,
      this.idx,
      this.isin,
      this.modified,
      this.modifiedBy,
      this.name,
      this.owner,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.pledgedQuantity,
      this.price,
      this.psn,
      this.securityCategory,
      this.securityName,
      this.lenderApprovalStatus});
}
