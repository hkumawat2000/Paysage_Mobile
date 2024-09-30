
import 'package:lms/aa_getx/modules/unpledge/domain/entities/unpledge_request_response_entity.dart';

class UnpledgeRequestResponseModel {
  String? message;
  UnpledgeRequestData? unpledgeRequestData;

  UnpledgeRequestResponseModel({this.message, this.unpledgeRequestData});

  UnpledgeRequestResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    unpledgeRequestData = json['data'] != null ? new UnpledgeRequestData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.unpledgeRequestData != null) {
      data['data'] = this.unpledgeRequestData!.toJson();
    }
    return data;
  }

  UnpledgeRequestResponseEntity toEntity() =>
      UnpledgeRequestResponseEntity(
        message: message,
        unpledgeRequestData: unpledgeRequestData?.toEntity(),

      );
}

class UnpledgeRequestData {
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
  List<UnpledgeItems>? items;

  UnpledgeRequestData(
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

  UnpledgeRequestData.fromJson(Map<String, dynamic> json) {
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
    unpledgeCollateralValue = json['unpledge_collateral_value'];
    status = json['status'];
    doctype = json['doctype'];
    if (json['items'] != null) {
      items = <UnpledgeItems>[];
      json['items'].forEach((v) {
        items!.add(new UnpledgeItems.fromJson(v));
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
    data['unpledge_collateral_value'] = this.unpledgeCollateralValue;
    data['status'] = this.status;
    data['doctype'] = this.doctype;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  UnpledgeRequestDataEntity toEntity() =>
      UnpledgeRequestDataEntity(
        name: name,
        owner: owner,
        creation: creation,
        modified: modified,
        modifiedBy: modifiedBy,
        idx: idx,
        docstatus: docstatus,
        workflowState: workflowState,
        loan: loan,
        totalCollateralValue: totalCollateralValue,
        lender: lender,
        customer: customer,
        unpledgeCollateralValue: unpledgeCollateralValue,
        status: status,
        doctype: doctype,
        items: items?.map((x) => x.toEntity()).toList(),

      );
}

class UnpledgeItems {
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

  UnpledgeItems(
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

  UnpledgeItems.fromJson(Map<String, dynamic> json) {
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
    eligiblePercentage = json['eligible_percentage'];
    price = json['price'];
    amount = json['amount'];
    doctype = json['doctype'];
    folio = json['folio'];
    psn = json['psn'];
    remainingQty = json['remaining_qty'];
    qty = json['qty'];
    check = json['check'];
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
    data['eligible_percentage'] = this.eligiblePercentage;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['doctype'] = this.doctype;
    data['folio'] = this.folio;
    data['psn'] = this.psn;
    data['remaining_qty'] = this.remainingQty;
    data['qty'] = this.qty;
    data['check'] = this.check;
    return data;
  }

  UnpledgeItemsEntity toEntity() => UnpledgeItemsEntity(
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
    isin: isin,
    securityName: securityName,
    securityCategory: securityCategory,
    pledgedQuantity: pledgedQuantity,
    eligiblePercentage: eligiblePercentage,
    price: price,
    amount: amount,
    doctype: doctype,
    folio: folio,
    psn: psn,
    remainingQty: remainingQty,
    qty: qty,
    check: check,
  );
}
