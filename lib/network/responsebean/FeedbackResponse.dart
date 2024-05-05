import 'package:choice/network/ModelWrapper.dart';

class FeedbackResponse extends ModelWrapper<FeedbackData>{
  FeedbackData? data;

  FeedbackResponse({this.data});

  FeedbackResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new FeedbackData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class FeedbackData {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  Null parent;
  Null parentfield;
  Null parenttype;
  int? idx;
  int? docstatus;
  String? rating;
  String? comment;
  String? doctype;

  FeedbackData(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.idx,
        this.docstatus,
        this.rating,
        this.comment,
        this.doctype});

  FeedbackData.fromJson(Map<String, dynamic> json) {
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
    rating = json['rating'];
    comment = json['comment'];
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
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['doctype'] = this.doctype;
    return data;
  }
}