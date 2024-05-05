import 'package:choice/network/ModelWrapper.dart';

class ProcessCartResponse extends ModelWrapper<ProcessCartData> {
  String? message;
  ProcessCartData? processCartData;

  ProcessCartResponse({this.message, this.processCartData});

  ProcessCartResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    processCartData =
    json['data'] != null ? new ProcessCartData.fromJson(json['data']) : null;
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

class ProcessCartData {
  LoanApplication? loanApplication;
  String? mycamUrl;

  ProcessCartData({this.loanApplication, this.mycamUrl});

  ProcessCartData.fromJson(Map<String, dynamic> json) {
    loanApplication = json['loan_application'] != null ? new LoanApplication.fromJson(json['loan_application']) : null;
    mycamUrl = json['mycam_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loanApplication != null) {
      data['loan_application'] = this.loanApplication!.toJson();
    }
    data['mycam_url'] = this.mycamUrl;
    return data;
  }
}

class LoanApplication {
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

  LoanApplication(
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

  LoanApplication.fromJson(Map<String, dynamic> json) {
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
        this.lenderApprovalStatus});

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
    return data;
  }
}