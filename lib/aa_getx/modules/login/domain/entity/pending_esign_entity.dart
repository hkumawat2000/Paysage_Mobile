import 'package:lms/aa_getx/modules/login/domain/entity/common_items_response_entity.dart';

class PendingEsignsEntity {
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
  List<CommonItemsEntity>? items;

  PendingEsignsEntity(
      {this.name,
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
}