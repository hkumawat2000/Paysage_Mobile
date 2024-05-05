import 'package:choice/network/ModelWrapper.dart';

class AllCartListResponse extends ModelWrapper<List<CartListData>> {
  List<CartListData>? cartListData;

  AllCartListResponse({this.cartListData});

  AllCartListResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      cartListData = <CartListData>[];
      json['data'].forEach((v) {
        cartListData!.add(new CartListData.fromJson(v));
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

class CartListData {
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
  // Null expiredon;
  // Null status;
  // Null platform;
  // Null user;
  int? cartTotal;
  int? converted;
  // Null nUserTags;
  // Null nComments;
  // Null nAssign;
  // Null nLikedBy;
  int? isPassing;
  // Null expiry;
  int? brePassing;
  double? total;
  double? eligibleAmount;

  CartListData(
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
        // this.expiredon,
        // this.status,
        // this.platform,
        // this.user,
        this.cartTotal,
        this.converted,
        // this.nUserTags,
        // this.nComments,
        // this.nAssign,
        // this.nLikedBy,
        this.isPassing,
        // this.expiry,
        this.brePassing,
        this.total,
        this.eligibleAmount});

  CartListData.fromJson(Map<String, dynamic> json) {
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
    // expiredon = json['expiredon'];
    // status = json['status'];
    // platform = json['platform'];
    // user = json['user'];
    cartTotal = json['cart_total'];
    converted = json['converted'];
    // nUserTags = json['_user_tags'];
    // nComments = json['_comments'];
    // nAssign = json['_assign'];
    // nLikedBy = json['_liked_by'];
    isPassing = json['is_passing'];
    // expiry = json['expiry'];
    brePassing = json['bre_passing'];
    total = json['total'];
    eligibleAmount = json['eligible_amount'];
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
    // data['expiredon'] = this.expiredon;
    // data['status'] = this.status;
    // data['platform'] = this.platform;
    // data['user'] = this.user;
    data['cart_total'] = this.cartTotal;
    data['converted'] = this.converted;
    // data['_user_tags'] = this.nUserTags;
    // data['_comments'] = this.nComments;
    // data['_assign'] = this.nAssign;
    // data['_liked_by'] = this.nLikedBy;
    data['is_passing'] = this.isPassing;
    // data['expiry'] = this.expiry;
    data['bre_passing'] = this.brePassing;
    data['total'] = this.total;
    data['eligible_amount'] = this.eligibleAmount;
    return data;
  }
}