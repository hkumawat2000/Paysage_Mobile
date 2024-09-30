
class UnpledgeRequestResponseEntity {
  String? message;
  UnpledgeRequestDataEntity? unpledgeRequestData;

  UnpledgeRequestResponseEntity({this.message, this.unpledgeRequestData});
}

class UnpledgeRequestDataEntity {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? workflowState;
  String? loan;
  double? totalCollateralValue;
  String? lender;
  String? customer;
  double? unpledgeCollateralValue;
  String? status;
  String? doctype;
  List<UnpledgeItemsEntity>? items;

  UnpledgeRequestDataEntity(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.workflowState,
        this.loan,
        this.totalCollateralValue,
        this.lender,
        this.customer,
        this.unpledgeCollateralValue,
        this.status,
        this.doctype,
        this.items,
      });
}

class UnpledgeItemsEntity {
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
  double? eligiblePercentage;
  double? price;
  double? amount;
  String? doctype;
  String? folio;
  String? psn;
  int? remainingQty;
  int? qty;
  bool? check;

  UnpledgeItemsEntity(
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
        this.eligiblePercentage,
        this.price,
        this.amount,
        this.doctype,
        this.folio,
        this.psn,
        this.remainingQty,
        this.qty,
        this.check});
}