// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/login/domain/entity/identity_details_entity.dart';

class IdentityDetails {
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
  String? sequenceNo;
  String? identType;
  String? identCategory;
  String? identNum;
  String? idverStatus;
  String? doctype;
  IdentityDetails({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.docstatus,
    this.sequenceNo,
    this.identType,
    this.identCategory,
    this.identNum,
    this.idverStatus,
    this.doctype,
  });

  // IdentityDetails(
  //     {this.name,
  //     this.owner,
  //     this.creation,
  //     this.modified,
  //     this.modifiedBy,
  //     this.parent,
  //     this.parentfield,
  //     this.parenttype,
  //     this.idx,
  //     this.docstatus,
  //     this.sequenceNo,
  //     this.identType,
  //     this.identCategory,
  //     this.identNum,
  //     this.idverStatus,
  //     this.doctype});

  IdentityDetails.fromJson(Map<String, dynamic> json) {
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
    sequenceNo = json['sequence_no'];
    identType = json['ident_type'];
    identCategory = json['ident_category'];
    identNum = json['ident_num'];
    idverStatus = json['idver_status'];
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
    data['sequence_no'] = this.sequenceNo;
    data['ident_type'] = this.identType;
    data['ident_category'] = this.identCategory;
    data['ident_num'] = this.identNum;
    data['idver_status'] = this.idverStatus;
    data['doctype'] = this.doctype;
    return data;
  }

  IdentityDetailsEntity toEntity() => IdentityDetailsEntity(
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
        sequenceNo: sequenceNo,
        identType: identType,
        identCategory: identCategory,
        identNum: identNum,
        idverStatus: idverStatus,
        doctype: doctype,
      );

  factory IdentityDetails.fromEntity(IdentityDetails identityDetails) {
    return IdentityDetails(
      name: identityDetails.name != null ? identityDetails.name as String : null,
      owner: identityDetails.owner != null ? identityDetails.owner as String : null,
      creation: identityDetails.creation != null ? identityDetails.creation as String : null,
      modified: identityDetails.modified != null ? identityDetails.modified as String : null,
      modifiedBy: identityDetails.modifiedBy != null ? identityDetails.modifiedBy as String : null,
      parent: identityDetails.parent != null ? identityDetails.parent as String : null,
      parentfield: identityDetails.parentfield != null ? identityDetails.parentfield as String : null,
      parenttype: identityDetails.parenttype != null ? identityDetails.parenttype as String : null,
      idx: identityDetails.idx != null ? identityDetails.idx as int : null,
      docstatus: identityDetails.docstatus != null ? identityDetails.docstatus as int : null,
      sequenceNo: identityDetails.sequenceNo != null ? identityDetails.sequenceNo as String : null,
      identType: identityDetails.identType != null ? identityDetails.identType as String : null,
      identCategory: identityDetails.identCategory != null ? identityDetails.identCategory as String : null,
      identNum: identityDetails.identNum != null ? identityDetails.identNum as String : null,
      idverStatus: identityDetails.idverStatus != null ? identityDetails.idverStatus as String : null,
      doctype: identityDetails.doctype != null ? identityDetails.doctype as String : null,
    );
  }
}
