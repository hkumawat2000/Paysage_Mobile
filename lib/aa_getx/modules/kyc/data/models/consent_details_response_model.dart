// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/domain/entities/consent_details_response_entity.dart';

class ConsentDetailsResponseModel {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? consent;
  String? doctype;
  
  ConsentDetailsResponseModel({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.consent,
    this.doctype,
  });

  

  ConsentDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    consent = json['consent'];
    doctype = json['doctype'];
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
    data['consent'] = this.consent;
    data['doctype'] = this.doctype;
    return data;
  }

  ConsentDetailsResponseEntity toEntity() =>
  ConsentDetailsResponseEntity(
      name: name,
      owner: owner,
      creation: creation,
      modified: modified,
      modifiedBy: modifiedBy,
      idx: idx,
      docstatus: docstatus,
      consent: consent,
      doctype: doctype,
  
  );

  factory ConsentDetailsResponseModel.fromEntity(ConsentDetailsResponseEntity consentDetailsResponseEntity) {
    return ConsentDetailsResponseModel(
      name: consentDetailsResponseEntity.name != null ? consentDetailsResponseEntity.name as String : null,
      owner: consentDetailsResponseEntity.owner != null ? consentDetailsResponseEntity.owner as String : null,
      creation: consentDetailsResponseEntity.creation != null ? consentDetailsResponseEntity.creation as String : null,
      modified: consentDetailsResponseEntity.modified != null ? consentDetailsResponseEntity.modified as String : null,
      modifiedBy: consentDetailsResponseEntity.modifiedBy != null ? consentDetailsResponseEntity.modifiedBy as String : null,
      idx: consentDetailsResponseEntity.idx != null ? consentDetailsResponseEntity.idx as int : null,
      docstatus: consentDetailsResponseEntity.docstatus != null ? consentDetailsResponseEntity.docstatus as int : null,
      consent: consentDetailsResponseEntity.consent != null ? consentDetailsResponseEntity.consent as String : null,
      doctype: consentDetailsResponseEntity.doctype != null ? consentDetailsResponseEntity.doctype as String : null,
    );
  }
}
