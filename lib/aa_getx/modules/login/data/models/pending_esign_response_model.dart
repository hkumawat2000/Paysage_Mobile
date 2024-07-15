// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/login/data/models/common_items_response.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/pending_esign_entity.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class PendingEsigns {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  // Null parent;
  // Null parentfield;
  // Null parenttype;
  int? idx;
  double? total;
  String? pledgorBoid;
  // Null prfNumber;
  String? pledgeeBoid;
  String? expiryDate;
  String? status;
  // Null nUserTags;
  String? nComments;
  // Null nAssign;
  String? nLikedBy;
  String? workflowState;
  double? totalCollateralValue;
  double? overdraftLimit;
  String? customer;
  double? allowableLtv;
  String? loan;
  double? drawingPower;
  String? lender;
  String? customerEsignedDocument;
  String? lenderEsignedDocument;
  double? pledgedTotalCollateralValue;
  String? pledgeStatus;
  List<CommonItems>? items;


  PendingEsigns({this.name,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.owner,
    this.docstatus,
    // this.parent,
    // this.parentfield,
    // this.parenttype,
    this.idx,
    this.total,
    this.pledgorBoid,
    // this.prfNumber,
    this.pledgeeBoid,
    this.expiryDate,
    this.status,
    // this.nUserTags,
    this.nComments,
    // this.nAssign,
    this.nLikedBy,
    this.workflowState,
    this.totalCollateralValue,
    this.overdraftLimit,
    this.customer,
    this.allowableLtv,
    this.loan,
    this.drawingPower,
    this.lender,
    this.customerEsignedDocument,
    this.lenderEsignedDocument,
    this.pledgedTotalCollateralValue,
    this.pledgeStatus,
    this.items});

  PendingEsigns.fromJson(Map<dynamic, dynamic> json) {
    try {
      name = json['name'];
      creation = json['creation'];
      modified = json['modified'];
      modifiedBy = json['modified_by'];
      owner = json['owner'];
      docstatus = json['docstatus'];
      // parent = json['parent'];
      // parentfield = json['parentfield'];
      // parenttype = json['parenttype'];
      idx = json['idx'];
      total = json['total'];
      pledgorBoid = json['pledgor_boid'];
      // prfNumber = json['prf_number'];
      pledgeeBoid = json['pledgee_boid'];
      expiryDate = json['expiry_date'];
      status = json['status'];
      // nUserTags = json['_user_tags'];
      nComments = json['_comments'];
      // nAssign = json['_assign'];
      nLikedBy = json['_liked_by'];
      workflowState = json['workflow_state'];
      totalCollateralValue = json['total_collateral_value'];
      overdraftLimit = json['overdraft_limit'];
      customer = json['customer'];
      allowableLtv = json['allowable_ltv'];
      loan = json['loan'];
      drawingPower = json['drawing_power'];
      lender = json['lender'];
      customerEsignedDocument = json['customer_esigned_document'];
      lenderEsignedDocument = json['lender_esigned_document'];
      pledgedTotalCollateralValue = json['pledged_total_collateral_value'];
      pledgeStatus = json['pledge_status'];
      if (json['items'] != null) {
        items = <CommonItems>[];
        json['items'].forEach((v) {
          items!.add(new CommonItems.fromJson(v));
        });
      }
    } catch (e, s) {
      printLog(s.toString());
    }

  }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['name'] = this.name;
      data['creation'] = this.creation;
      data['modified'] = this.modified;
      data['modified_by'] = this.modifiedBy;
      data['owner'] = this.owner;
      data['docstatus'] = this.docstatus;
      // data['parent'] = this.parent;
      // data['parentfield'] = this.parentfield;
      // data['parenttype'] = this.parenttype;
      data['idx'] = this.idx;
      data['total'] = this.total;
      data['pledgor_boid'] = this.pledgorBoid;
      // data['prf_number'] = this.prfNumber;
      data['pledgee_boid'] = this.pledgeeBoid;
      data['expiry_date'] = this.expiryDate;
      data['status'] = this.status;
      // data['_user_tags'] = this.nUserTags;
      data['_comments'] = this.nComments;
      // data['_assign'] = this.nAssign;
      data['_liked_by'] = this.nLikedBy;
      data['workflow_state'] = this.workflowState;
      data['total_collateral_value'] = this.totalCollateralValue;
      data['overdraft_limit'] = this.overdraftLimit;
      data['customer'] = this.customer;
      data['allowable_ltv'] = this.allowableLtv;
      data['loan'] = this.loan;
      data['drawing_power'] = this.drawingPower;
      data['lender'] = this.lender;
      data['customer_esigned_document'] = this.customerEsignedDocument;
      data['lender_esigned_document'] = this.lenderEsignedDocument;
      data['pledged_total_collateral_value'] = this.pledgedTotalCollateralValue;
      data['pledge_status'] = this.pledgeStatus;
      if (this.items != null) {
        data['items'] = this.items!.map((v) => v.toJson()).toList();
      }
      return data;
    }

  PendingEsignsEntity toEntity() =>
  PendingEsignsEntity(
      name: name,
      creation: creation,
      modified: modified,
      modifiedBy: modifiedBy,
      owner: owner,
      docstatus: docstatus,
      idx: idx,
      total: total,
      pledgorBoid: pledgorBoid,
      pledgeeBoid: pledgeeBoid,
      expiryDate: expiryDate,
      status: status,
      nComments: nComments,
      nLikedBy: nLikedBy,
      workflowState: workflowState,
      totalCollateralValue: totalCollateralValue,
      overdraftLimit: overdraftLimit,
      customer: customer,
      allowableLtv: allowableLtv,
      loan: loan,
      drawingPower: drawingPower,
      lender: lender,
      customerEsignedDocument: customerEsignedDocument,
      lenderEsignedDocument: lenderEsignedDocument,
      pledgedTotalCollateralValue: pledgedTotalCollateralValue,
      pledgeStatus: pledgeStatus,
      items: items!.map((x) => x.toEntity()).toList(),
  
  );
  }
