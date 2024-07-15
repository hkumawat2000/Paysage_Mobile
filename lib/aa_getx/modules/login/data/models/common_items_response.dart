// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/login/domain/entity/common_items_response_entity.dart';

class CommonItems {
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
  String? folio;

  CommonItems(
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
      this.lenderApprovalStatus,
      this.folio});

  CommonItems.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    creation = json['creation'];
    docstatus = json['docstatus'];
    doctype = json['doctype'];
    errorCode = json['error_code'];
    idx = json['idx'];
    isin = json['isin'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    name = json['name'];
    owner = json['owner'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    pledgedQuantity = json['pledged_quantity'];
    price = json['price'];
    psn = json['psn'];
    securityCategory = json['security_category'];
    securityName = json['security_name'];
    lenderApprovalStatus = json['lender_approval_status'];
    folio = json['folio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['creation'] = this.creation;
    data['docstatus'] = this.docstatus;
    data['doctype'] = this.doctype;
    data['error_code'] = this.errorCode;
    data['idx'] = this.idx;
    data['isin'] = this.isin;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['pledged_quantity'] = this.pledgedQuantity;
    data['price'] = this.price;
    data['psn'] = this.psn;
    data['security_category'] = this.securityCategory;
    data['security_name'] = this.securityName;
    data['lender_approval_status'] = this.lenderApprovalStatus;
    data['folio'] = this.folio;
    return data;
  }

  CommonItemsEntity toEntity() => CommonItemsEntity(
        amount: amount,
        creation: creation,
        docstatus: docstatus,
        doctype: doctype,
        errorCode: errorCode,
        idx: idx,
        isin: isin,
        modified: modified,
        modifiedBy: modifiedBy,
        name: name,
        owner: owner,
        parent: parent,
        parentfield: parentfield,
        parenttype: parenttype,
        pledgedQuantity: pledgedQuantity,
        price: price,
        psn: psn,
        securityCategory: securityCategory,
        securityName: securityName,
        lenderApprovalStatus: lenderApprovalStatus,
        folio: folio,
      );
}
