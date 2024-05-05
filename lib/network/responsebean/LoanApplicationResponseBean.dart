import 'package:choice/network/ModelWrapper.dart';

import 'NewDashboardResponse.dart';

class LoanApplicationResponse extends ModelWrapper<LoanApplicationData> {
  String? message;
  LoanApplicationData? loanApplicationData;

  LoanApplicationResponse({this.message, this.loanApplicationData});

  LoanApplicationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    loanApplicationData = json['data'] != null ? new LoanApplicationData.fromJson(json['data']) : null;
    data = loanApplicationData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class LoanApplicationData {
  double? allowableLtv;
  String? creation;
  String? customer;
  int? docstatus;
  String? doctype;
  double? drawingPower;
  String? expiryDate;
  int? idx;
  List<CommonItems>? items;
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

  LoanApplicationData(
      {this.allowableLtv,
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
        this.workflowState});

  LoanApplicationData.fromJson(Map<String, dynamic> json) {
    allowableLtv = json['allowable_ltv'];
    creation = json['creation'];
    customer = json['customer'];
    docstatus = json['docstatus'];
    doctype = json['doctype'];
    drawingPower = json['drawing_power'];
    expiryDate = json['expiry_date'];
    idx = json['idx'];
    if (json['items'] != null) {
      items = <CommonItems>[];
      json['items'].forEach((v) {
        items!.add(new CommonItems.fromJson(v));
      });
    }
    loan = json['loan'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    name = json['name'];
    owner = json['owner'];
    // parent = json['parent'];
    // parentfield = json['parentfield'];
    // parenttype = json['parenttype'];
    pledgeeBoid = json['pledgee_boid'];
    pledgorBoid = json['pledgor_boid'];
    prfNumber = json['prf_number'];
    status = json['status'];
    totalCollateralValue = json['total_collateral_value'];
    workflowState = json['workflow_state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowable_ltv'] = this.allowableLtv;
    data['creation'] = this.creation;
    data['customer'] = this.customer;
    data['docstatus'] = this.docstatus;
    data['doctype'] = this.doctype;
    data['drawing_power'] = this.drawingPower;
    data['expiry_date'] = this.expiryDate;
    data['idx'] = this.idx;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['loan'] = this.loan;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['name'] = this.name;
    data['owner'] = this.owner;
    // data['parent'] = this.parent;
    // data['parentfield'] = this.parentfield;
    // data['parenttype'] = this.parenttype;
    data['pledgee_boid'] = this.pledgeeBoid;
    data['pledgor_boid'] = this.pledgorBoid;
    data['prf_number'] = this.prfNumber;
    data['status'] = this.status;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['workflow_state'] = this.workflowState;
    return data;
  }
}
