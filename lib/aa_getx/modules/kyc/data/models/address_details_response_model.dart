// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/domain/entities/address_details_response_entity.dart';

class AddressDetailsResponseModel {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  int? isEdited;
  String? permLine1;
  String? permLine2;
  String? permLine3;
  String? permCity;
  String? permDist;
  String? permState;
  String? permCountry;
  String? permPin;
  String? permPoa;
  String? permImage;
  String? permCorresFlag;
  String? corresLine1;
  String? corresLine2;
  String? corresLine3;
  String? corresCity;
  String? corresDist;
  String? corresState;
  String? corresCountry;
  String? corresPin;
  String? corresPoa;
  String? corresPoaImage;
  String? doctype;

  AddressDetailsResponseModel({this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.isEdited,
    this.permLine1,
    this.permLine2,
    this.permLine3,
    this.permCity,
    this.permDist,
    this.permState,
    this.permCountry,
    this.permPin,
    this.permPoa,
    this.permImage,
    this.permCorresFlag,
    this.corresLine1,
    this.corresLine2,
    this.corresLine3,
    this.corresCity,
    this.corresDist,
    this.corresState,
    this.corresCountry,
    this.corresPin,
    this.corresPoa,
    this.corresPoaImage,
    this.doctype});

  AddressDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    isEdited = json['is_edited'];
    permLine1 = json['perm_line1'];
    permLine2 = json['perm_line2'];
    permLine3 = json['perm_line3'];
    permCity = json['perm_city'];
    permDist = json['perm_dist'];
    permState = json['perm_state'];
    permCountry = json['perm_country'];
    permPin = json['perm_pin'];
    permPoa = json['perm_poa'];
    permImage = json['perm_image'];
    permCorresFlag = json['perm_corres_flag'];
    corresLine1 = json['corres_line1'];
    corresLine2 = json['corres_line2'];
    corresLine3 = json['corres_line3'];
    corresCity = json['corres_city'];
    corresDist = json['corres_dist'];
    corresState = json['corres_state'];
    corresCountry = json['corres_country'];
    corresPin = json['corres_pin'];
    corresPoa = json['corres_poa'];
    corresPoaImage = json['corres_poa_image'];
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
    data['is_edited'] = this.isEdited;
    data['perm_line1'] = this.permLine1;
    data['perm_line2'] = this.permLine2;
    data['perm_line3'] = this.permLine3;
    data['perm_city'] = this.permCity;
    data['perm_dist'] = this.permDist;
    data['perm_state'] = this.permState;
    data['perm_country'] = this.permCountry;
    data['perm_pin'] = this.permPin;
    data['perm_poa'] = this.permPoa;
    data['perm_image'] = this.permImage;
    data['perm_corres_flag'] = this.permCorresFlag;
    data['corres_line1'] = this.corresLine1;
    data['corres_line2'] = this.corresLine2;
    data['corres_line3'] = this.corresLine3;
    data['corres_city'] = this.corresCity;
    data['corres_dist'] = this.corresDist;
    data['corres_state'] = this.corresState;
    data['corres_country'] = this.corresCountry;
    data['corres_pin'] = this.corresPin;
    data['corres_poa'] = this.corresPoa;
    data['corres_poa_image'] = this.corresPoaImage;
    data['doctype'] = this.doctype;
    return data;
  }

  AddressDetailsResponseEntity toEntity() =>
  AddressDetailsResponseEntity(
      name: name,
      owner: owner,
      creation: creation,
      modified: modified,
      modifiedBy: modifiedBy,
      idx: idx,
      docstatus: docstatus,
      isEdited: isEdited,
      permLine1: permLine1,
      permLine2: permLine2,
      permLine3: permLine3,
      permCity: permCity,
      permDist: permDist,
      permState: permState,
      permCountry: permCountry,
      permPin: permPin,
      permPoa: permPoa,
      permImage: permImage,
      permCorresFlag: permCorresFlag,
      corresLine1: corresLine1,
      corresLine2: corresLine2,
      corresLine3: corresLine3,
      corresCity: corresCity,
      corresDist: corresDist,
      corresState: corresState,
      corresCountry: corresCountry,
      corresPin: corresPin,
      corresPoa: corresPoa,
      corresPoaImage: corresPoaImage,
      doctype: doctype,
  
  );

  factory AddressDetailsResponseModel.fromEntity(AddressDetailsResponseEntity addressDetailsResponseEntity) {
    return AddressDetailsResponseModel(
      name: addressDetailsResponseEntity.name != null ? addressDetailsResponseEntity.name as String : null,
      owner: addressDetailsResponseEntity.owner != null ? addressDetailsResponseEntity.owner as String : null,
      creation: addressDetailsResponseEntity.creation != null ? addressDetailsResponseEntity.creation as String : null,
      modified: addressDetailsResponseEntity.modified != null ? addressDetailsResponseEntity.modified as String : null,
      modifiedBy: addressDetailsResponseEntity.modifiedBy != null ? addressDetailsResponseEntity.modifiedBy as String : null,
      idx: addressDetailsResponseEntity.idx != null ? addressDetailsResponseEntity.idx as int : null,
      docstatus: addressDetailsResponseEntity.docstatus != null ? addressDetailsResponseEntity.docstatus as int : null,
      isEdited: addressDetailsResponseEntity.isEdited != null ? addressDetailsResponseEntity.isEdited as int : null,
      permLine1: addressDetailsResponseEntity.permLine1 != null ? addressDetailsResponseEntity.permLine1 as String : null,
      permLine2: addressDetailsResponseEntity.permLine2 != null ? addressDetailsResponseEntity.permLine2 as String : null,
      permLine3: addressDetailsResponseEntity.permLine3 != null ? addressDetailsResponseEntity.permLine3 as String : null,
      permCity: addressDetailsResponseEntity.permCity != null ? addressDetailsResponseEntity.permCity as String : null,
      permDist: addressDetailsResponseEntity.permDist != null ? addressDetailsResponseEntity.permDist as String : null,
      permState: addressDetailsResponseEntity.permState != null ? addressDetailsResponseEntity.permState as String : null,
      permCountry: addressDetailsResponseEntity.permCountry != null ? addressDetailsResponseEntity.permCountry as String : null,
      permPin: addressDetailsResponseEntity.permPin != null ? addressDetailsResponseEntity.permPin as String : null,
      permPoa: addressDetailsResponseEntity.permPoa != null ? addressDetailsResponseEntity.permPoa as String : null,
      permImage: addressDetailsResponseEntity.permImage != null ? addressDetailsResponseEntity.permImage as String : null,
      permCorresFlag: addressDetailsResponseEntity.permCorresFlag != null ? addressDetailsResponseEntity.permCorresFlag as String : null,
      corresLine1: addressDetailsResponseEntity.corresLine1 != null ? addressDetailsResponseEntity.corresLine1 as String : null,
      corresLine2: addressDetailsResponseEntity.corresLine2 != null ? addressDetailsResponseEntity.corresLine2 as String : null,
      corresLine3: addressDetailsResponseEntity.corresLine3 != null ? addressDetailsResponseEntity.corresLine3 as String : null,
      corresCity: addressDetailsResponseEntity.corresCity != null ? addressDetailsResponseEntity.corresCity as String : null,
      corresDist: addressDetailsResponseEntity.corresDist != null ? addressDetailsResponseEntity.corresDist as String : null,
      corresState: addressDetailsResponseEntity.corresState != null ? addressDetailsResponseEntity.corresState as String : null,
      corresCountry: addressDetailsResponseEntity.corresCountry != null ? addressDetailsResponseEntity.corresCountry as String : null,
      corresPin: addressDetailsResponseEntity.corresPin != null ? addressDetailsResponseEntity.corresPin as String : null,
      corresPoa: addressDetailsResponseEntity.corresPoa != null ? addressDetailsResponseEntity.corresPoa as String : null,
      corresPoaImage: addressDetailsResponseEntity.corresPoaImage != null ? addressDetailsResponseEntity.corresPoaImage as String : null,
      doctype: addressDetailsResponseEntity.doctype != null ? addressDetailsResponseEntity.doctype as String : null,
    );
  }
}
