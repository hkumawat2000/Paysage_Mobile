
import 'package:lms/aa_getx/modules/sell_collateral/domain/entities/sell_collateral_response_entity.dart';

class SellCollateralResponseModel {
  String? message;
  SellData? sellData;

  SellCollateralResponseModel({this.message, this.sellData});

  SellCollateralResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    sellData = json['data'] != null ? new SellData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.sellData != null) {
      data['data'] = this.sellData!.toJson();
    }
    return data;
  }

  SellCollateralResponseEntity toEntity() =>
      SellCollateralResponseEntity(
        message: message,
        sellData: sellData?.toEntity(),

      );
}

class SellData {
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
  List<Items>? items;

  SellData(
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

  SellData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    workflowState = json['workflow_state'];
    loan = json['loan'];
    totalCollateralValue = json['total_collateral_value'];
    lender = json['lender'];
    customer = json['customer'];
    sellingCollateralValue = json['selling_collateral_value'];
    status = json['status'];
    doctype = json['doctype'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
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
    data['workflow_state'] = this.workflowState;
    data['loan'] = this.loan;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['lender'] = this.lender;
    data['customer'] = this.customer;
    data['selling_collateral_value'] = this.sellingCollateralValue;
    data['status'] = this.status;
    data['doctype'] = this.doctype;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SellDataEntity toEntity() =>
      SellDataEntity(
        name:name,
        owner:owner,
        creation:creation,
        modified:modified,
        modifiedBy:modifiedBy,
        idx:idx,
        docstatus:docstatus,
        workflowState:workflowState,
        loan:loan,
        totalCollateralValue:totalCollateralValue,
        lender:lender,
        customer:customer,
        sellingCollateralValue:sellingCollateralValue,
        status:status,
        doctype:doctype,
        items:items?.map((x) => x.toEntity()).toList(),

      );
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
  double? quantity;
  double? price;
  double? amount;
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
        this.quantity,
        this.price,
        this.amount,
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
    quantity = json['quantity'];
    price = json['price'];
    amount = json['amount'];
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
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['doctype'] = this.doctype;
    return data;
  }

  ItemsEntity toEntity() =>
      ItemsEntity(
        name:name,
        owner:owner,
        creation:creation,
        modified:modified,
        modifiedBy:modifiedBy,
        parent:parent,
        parentfield:parentfield,
        parenttype:parenttype,
        idx:idx,
        docstatus:docstatus,
        isin:isin,
        securityName:securityName,
        quantity:quantity,
        price:price,
        amount:amount,
        doctype:doctype,

      );
}

