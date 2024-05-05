import '../ModelWrapper.dart';

class TDSListResponseBean extends ModelWrapper<List<TDS>> {
  List<TDS>? tdsdata;

  TDSListResponseBean({this.tdsdata});

  TDSListResponseBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      tdsdata = <TDS>[];
      json['data'].forEach((v) {
        tdsdata!.add(new TDS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tdsdata != null) {
      data['data'] = this.tdsdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TDS {
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
  String? tdsFileUpload;
  double? tdsAmount;
  String? year;
  // Null nUserTags;
  // Null nComments;
  // Null nAssign;
  // Null nLikedBy;

  TDS(
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
      this.tdsFileUpload,
      this.tdsAmount,
      this.year,
      // this.nUserTags,
      // this.nComments,
      // this.nAssign,
      // this.nLikedBy
      });

  TDS.fromJson(Map<String, dynamic> json) {
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
    tdsFileUpload = json['tds_file_upload'];
    tdsAmount = json['tds_amount'];
    year = json['year'];
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
    data['tds_file_upload'] = this.tdsFileUpload;
    data['tds_amount'] = this.tdsAmount;
    data['year'] = this.year;
    // data['_user_tags'] = this.nUserTags;
    // data['_comments'] = this.nComments;
    // data['_assign'] = this.nAssign;
    // data['_liked_by'] = this.nLikedBy;
    return data;
  }
}
