import 'package:lms/network/ModelWrapper.dart';

class ContactUsResponseBean extends ModelWrapper<ContactUsData>{
  String? message;
  List<ContactUsData>? contactUsData;

  ContactUsResponseBean({this.message, this.contactUsData});

  ContactUsResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      contactUsData = <ContactUsData>[];
      json['data'].forEach((v) {
        contactUsData!.add(new ContactUsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.contactUsData != null) {
      data['data'] = this.contactUsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactUsData {
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
  String? topic;
  String? description;
  String? resolution;
  // Null nUserTags;
  // Null nComments;
  // Null nAssign;
  // Null nLikedBy;

  ContactUsData(
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
        this.topic,
        this.description,
        this.resolution,
        // this.nUserTags,
        // this.nComments,
        // this.nAssign,
        // this.nLikedBy
      });

  ContactUsData.fromJson(Map<String, dynamic> json) {
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
    topic = json['topic'];
    description = json['description'];
    resolution = json['resolution'];
    // nUserTags = json['_user_tags'];
    // nComments = json['_comments'];
    // nAssign = json['_assign'];
    // nLikedBy = json['_liked_by'];
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
    data['topic'] = this.topic;
    data['description'] = this.description;
    data['resolution'] = this.resolution;
    // data['_user_tags'] = this.nUserTags;
    // data['_comments'] = this.nComments;
    // data['_assign'] = this.nAssign;
    // data['_liked_by'] = this.nLikedBy;
    return data;
  }
}
