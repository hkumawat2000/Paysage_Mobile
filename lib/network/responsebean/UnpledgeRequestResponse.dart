import 'package:lms/network/responsebean/UnpledgeDetailsResponse.dart';

import '../ModelWrapper.dart';

class UnpledgeRequestResponse extends ModelWrapper<UnpledgeRequestData>{
  String? message;
  UnpledgeRequestData? unpledgeRequestData;

  UnpledgeRequestResponse({this.message, this.unpledgeRequestData});

  UnpledgeRequestResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    unpledgeRequestData = json['data'] != null ? new UnpledgeRequestData.fromJson(json['data']) : null;
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
//  List<Null> unpledgeItems;

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
//        this.unpledgeItems
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
//    if (json['unpledge_items'] != null) {
//      unpledgeItems = new List<Null>();
//      json['unpledge_items'].forEach((v) {
//        unpledgeItems.add(new Null.fromJson(v));
//      });
//    }
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
//    if (this.unpledgeItems != null) {
//      data['unpledge_items'] =
//          this.unpledgeItems.map((v) => v.toJson()).toList();
//    }
    return data;
  }
}