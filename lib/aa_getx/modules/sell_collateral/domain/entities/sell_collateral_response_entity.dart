
class SellCollateralResponseEntity {
  String? message;
  SellDataEntity? sellData;

  SellCollateralResponseEntity({this.message, this.sellData});
}

class SellDataEntity {
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
  double? sellingCollateralValue;
  String? status;
  String? doctype;
  List<ItemsEntity>? items;

  SellDataEntity(
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
        this.sellingCollateralValue,
        this.status,
        this.doctype,
        this.items});
}

class ItemsEntity {
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
  double? quantity;
  double? price;
  double? amount;
  String? doctype;

  ItemsEntity(
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
        this.quantity,
        this.price,
        this.amount,
        this.doctype});
}