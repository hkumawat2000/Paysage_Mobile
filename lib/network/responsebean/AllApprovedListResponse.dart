import 'package:lms/network/ModelWrapper.dart';

class AllApprovedListResponseBean extends ModelWrapper<List<AllApprovedList>> {
  List<AllApprovedList>? data;

  AllApprovedListResponseBean({this.data});

  AllApprovedListResponseBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AllApprovedList>[];
      json['data'].forEach((v) {
        data!.add(new AllApprovedList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllApprovedList {
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
  String? nseSymbol;
  String? category;
  String? securityName;
  // Null depository;
  int? isAllowed;
  String? isinNo;
  double? eligiblePercentage;
  String? type;
  String? isin;
  // Null nUserTags;
  // Null nComments;
  // Null nAssign;
  // Null nLikedBy;

  AllApprovedList(
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
        this.nseSymbol,
        this.category,
        this.securityName,
        // this.depository,
        this.isAllowed,
        this.isinNo,
        this.eligiblePercentage,
        this.type,
        this.isin,
        // this.nUserTags,
        // this.nComments,
        // this.nAssign,
        // this.nLikedBy
      });

  AllApprovedList.fromJson(Map<String, dynamic> json) {
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
    nseSymbol = json['nse_symbol'];
    category = json['category'];
    securityName = json['security_name'];
    // depository = json['depository'];
    isAllowed = json['is_allowed'];
    isinNo = json['isin_no'];
    eligiblePercentage = json['eligible_percentage'];
    type = json['type'];
    isin = json['isin'];
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
    data['nse_symbol'] = this.nseSymbol;
    data['category'] = this.category;
    data['security_name'] = this.securityName;
    // data['depository'] = this.depository;
    data['is_allowed'] = this.isAllowed;
    data['isin_no'] = this.isinNo;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['type'] = this.type;
    data['isin'] = this.isin;
    // data['_user_tags'] = this.nUserTags;
    // data['_comments'] = this.nComments;
    // data['_assign'] = this.nAssign;
    // data['_liked_by'] = this.nLikedBy;
    return data;
  }
}