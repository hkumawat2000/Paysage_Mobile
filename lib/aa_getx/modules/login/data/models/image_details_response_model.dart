// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/login/domain/entity/image_details_entity.dart';

class ImageDetails {
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
  ImageDetails({
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

  // ImageDetails(
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
  //     this.imageType,
  //     this.imageCode,
  //     this.imageName,
  //     this.globalFlag,
  //     this.branchCode,
  //     this.image,
  //     this.doctype});

  ImageDetails.fromJson(Map<String, dynamic> json) {
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

  ImageDetailsEntity toEntity() => ImageDetailsEntity(
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

  factory ImageDetails.fromEntity(ImageDetails imageDetails) {
    return ImageDetails(
      name: imageDetails.name != null ? imageDetails.name as String : null,
      owner: imageDetails.owner != null ? imageDetails.owner as String : null,
      creation: imageDetails.creation != null ? imageDetails.creation as String : null,
      modified: imageDetails.modified != null ? imageDetails.modified as String : null,
      modifiedBy: imageDetails.modifiedBy != null ? imageDetails.modifiedBy as String : null,
      parent: imageDetails.parent != null ? imageDetails.parent as String : null,
      parentfield: imageDetails.parentfield != null ? imageDetails.parentfield as String : null,
      parenttype: imageDetails.parenttype != null ? imageDetails.parenttype as String : null,
      idx: imageDetails.idx != null ? imageDetails.idx as int : null,
      docstatus: imageDetails.docstatus != null ? imageDetails.docstatus as int : null,
      sequenceNo: imageDetails.sequenceNo != null ? imageDetails.sequenceNo as String : null,
      imageType: imageDetails.imageType != null ? imageDetails.imageType as String : null,
      imageCode: imageDetails.imageCode != null ? imageDetails.imageCode as String : null,
      imageName: imageDetails.imageName != null ? imageDetails.imageName as String : null,
      globalFlag: imageDetails.globalFlag != null ? imageDetails.globalFlag as String : null,
      branchCode: imageDetails.branchCode != null ? imageDetails.branchCode as String : null,
      image: imageDetails.image != null ? imageDetails.image as String : null,
      doctype: imageDetails.doctype != null ? imageDetails.doctype as String : null,
    );
  }
}
