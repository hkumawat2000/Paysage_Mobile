// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/domain/entities/identity_details_response_entity.dart';

class IdentityDetailsResponseModel {
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
  
  IdentityDetailsResponseModel({
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

 

  IdentityDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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

  IdentityDetailsResponseEntity toEntity() =>
  IdentityDetailsResponseEntity(
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

  factory IdentityDetailsResponseModel.fromEntity(IdentityDetailsResponseEntity identityDetailsResponseEntity) {
    return IdentityDetailsResponseModel(
      name: identityDetailsResponseEntity.name != null ? identityDetailsResponseEntity.name as String : null,
      owner: identityDetailsResponseEntity.owner != null ? identityDetailsResponseEntity.owner as String : null,
      creation: identityDetailsResponseEntity.creation != null ? identityDetailsResponseEntity.creation as String : null,
      modified: identityDetailsResponseEntity.modified != null ? identityDetailsResponseEntity.modified as String : null,
      modifiedBy: identityDetailsResponseEntity.modifiedBy != null ? identityDetailsResponseEntity.modifiedBy as String : null,
      parent: identityDetailsResponseEntity.parent != null ? identityDetailsResponseEntity.parent as String : null,
      parentfield: identityDetailsResponseEntity.parentfield != null ? identityDetailsResponseEntity.parentfield as String : null,
      parenttype: identityDetailsResponseEntity.parenttype != null ? identityDetailsResponseEntity.parenttype as String : null,
      idx: identityDetailsResponseEntity.idx != null ? identityDetailsResponseEntity.idx as int : null,
      docstatus: identityDetailsResponseEntity.docstatus != null ? identityDetailsResponseEntity.docstatus as int : null,
      sequenceNo: identityDetailsResponseEntity.sequenceNo != null ? identityDetailsResponseEntity.sequenceNo as String : null,
      identType: identityDetailsResponseEntity.identType != null ? identityDetailsResponseEntity.identType as String : null,
      identCategory: identityDetailsResponseEntity.identCategory != null ? identityDetailsResponseEntity.identCategory as String : null,
      identNum: identityDetailsResponseEntity.identNum != null ? identityDetailsResponseEntity.identNum as String : null,
      idverStatus: identityDetailsResponseEntity.idverStatus != null ? identityDetailsResponseEntity.idverStatus as String : null,
      doctype: identityDetailsResponseEntity.doctype != null ? identityDetailsResponseEntity.doctype as String : null,
    );
  }
}
