// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/domain/entities/image_details_response_entity.dart';

class ImageDetailsResponseModel {
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
  String? imageType;
  String? imageCode;
  String? imageName;
  String? globalFlag;
  String? branchCode;
  String? image;
  String? doctype;
  
  ImageDetailsResponseModel({
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
    this.imageType,
    this.imageCode,
    this.imageName,
    this.globalFlag,
    this.branchCode,
    this.image,
    this.doctype,
  });



  ImageDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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
    imageType = json['image_type'];
    imageCode = json['image_code'];
    imageName = json['image_name'];
    globalFlag = json['global_flag'];
    branchCode = json['branch_code'];
    image = json['image'];
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
    data['image_type'] = this.imageType;
    data['image_code'] = this.imageCode;
    data['image_name'] = this.imageName;
    data['global_flag'] = this.globalFlag;
    data['branch_code'] = this.branchCode;
    data['image'] = this.image;
    data['doctype'] = this.doctype;
    return data;
  }

  ImageDetailsResponseEntity toEntity() =>
  ImageDetailsResponseEntity(
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
      imageType: imageType,
      imageCode: imageCode,
      imageName: imageName,
      globalFlag: globalFlag,
      branchCode: branchCode,
      image: image,
      doctype: doctype,
  
  );

  factory ImageDetailsResponseModel.fromEntity(ImageDetailsResponseEntity imageDetailsResponseEntity) {
    return ImageDetailsResponseModel(
      name: imageDetailsResponseEntity.name != null ? imageDetailsResponseEntity.name as String : null,
      owner: imageDetailsResponseEntity.owner != null ? imageDetailsResponseEntity.owner as String : null,
      creation: imageDetailsResponseEntity.creation != null ? imageDetailsResponseEntity.creation as String : null,
      modified: imageDetailsResponseEntity.modified != null ? imageDetailsResponseEntity.modified as String : null,
      modifiedBy: imageDetailsResponseEntity.modifiedBy != null ? imageDetailsResponseEntity.modifiedBy as String : null,
      parent: imageDetailsResponseEntity.parent != null ? imageDetailsResponseEntity.parent as String : null,
      parentfield: imageDetailsResponseEntity.parentfield != null ? imageDetailsResponseEntity.parentfield as String : null,
      parenttype: imageDetailsResponseEntity.parenttype != null ? imageDetailsResponseEntity.parenttype as String : null,
      idx: imageDetailsResponseEntity.idx != null ? imageDetailsResponseEntity.idx as int : null,
      docstatus: imageDetailsResponseEntity.docstatus != null ? imageDetailsResponseEntity.docstatus as int : null,
      sequenceNo: imageDetailsResponseEntity.sequenceNo != null ? imageDetailsResponseEntity.sequenceNo as String : null,
      imageType: imageDetailsResponseEntity.imageType != null ? imageDetailsResponseEntity.imageType as String : null,
      imageCode: imageDetailsResponseEntity.imageCode != null ? imageDetailsResponseEntity.imageCode as String : null,
      imageName: imageDetailsResponseEntity.imageName != null ? imageDetailsResponseEntity.imageName as String : null,
      globalFlag: imageDetailsResponseEntity.globalFlag != null ? imageDetailsResponseEntity.globalFlag as String : null,
      branchCode: imageDetailsResponseEntity.branchCode != null ? imageDetailsResponseEntity.branchCode as String : null,
      image: imageDetailsResponseEntity.image != null ? imageDetailsResponseEntity.image as String : null,
      doctype: imageDetailsResponseEntity.doctype != null ? imageDetailsResponseEntity.doctype as String : null,
    );
  }
}
