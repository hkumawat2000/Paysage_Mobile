import 'package:lms/network/ModelWrapper.dart';

class MarginShortfallCartResponse extends ModelWrapper<MarginShortfallCartData>{
  String? message;
  MarginShortfallCartData? marginShortfallCartData;

  MarginShortfallCartResponse({this.message, this.marginShortfallCartData});

  MarginShortfallCartResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    marginShortfallCartData = json['data'] != null ? new MarginShortfallCartData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MarginShortfallCartData {
  Cart? cart;
  bool? minimumPledgeAmountPresent;
  double? minimumPledgeAmount;

  MarginShortfallCartData({this.cart, this.minimumPledgeAmountPresent, this.minimumPledgeAmount});

  MarginShortfallCartData.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    minimumPledgeAmountPresent = json['minimum_pledge_amount_present'];
    minimumPledgeAmount = json['minimum_pledge_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    data['minimum_pledge_amount_present'] = this.minimumPledgeAmountPresent;
    data['minimum_pledge_amount'] = this.minimumPledgeAmount;
    return data;
  }
}

class Cart {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  double? totalCollateralValue;
  double? allowableLtv;
  int? isProcessed;
  double? eligibleLoan;
  String? customer;
  String? loan;
  String? doctype;
  List<Items>? items;

  Cart(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.totalCollateralValue,
        this.allowableLtv,
        this.isProcessed,
        this.eligibleLoan,
        this.customer,
        this.loan,
        this.doctype,
        this.items});

  Cart.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    totalCollateralValue = json['total_collateral_value'];
    allowableLtv = json['allowable_ltv'];
    isProcessed = json['is_processed'];
    eligibleLoan = json['eligible_loan'];
    customer = json['customer'];
    loan = json['loan'];
    doctype = json['doctype'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
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
    data['total_collateral_value'] = this.totalCollateralValue;
    data['allowable_ltv'] = this.allowableLtv;
    data['is_processed'] = this.isProcessed;
    data['eligible_loan'] = this.eligibleLoan;
    data['customer'] = this.customer;
    data['loan'] = this.loan;
    data['doctype'] = this.doctype;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
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
  String? isin;
  String? securityName;
  String? securityCategory;
  int? pledgedQuantity;
  double? price;
  double? amount;
  double? eligiblePercentage;
  String? doctype;

  Items(
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
        this.isin,
        this.securityName,
        this.securityCategory,
        this.pledgedQuantity,
        this.price,
        this.amount,
        this.eligiblePercentage,
        this.doctype});

  Items.fromJson(Map<String, dynamic> json) {
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
    isin = json['isin'];
    securityName = json['security_name'];
    securityCategory = json['security_category'];
    pledgedQuantity = json['pledged_quantity'];
    price = json['price'];
    amount = json['amount'];
    eligiblePercentage = json['eligible_percentage'];
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
    data['isin'] = this.isin;
    data['security_name'] = this.securityName;
    data['security_category'] = this.securityCategory;
    data['pledged_quantity'] = this.pledgedQuantity;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['doctype'] = this.doctype;
    return data;
  }
}