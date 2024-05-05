import '../ModelWrapper.dart';

class MyCartResponseBean extends ModelWrapper<MyCartData> {
  String? message;
  MyCartData? myCartData;

  MyCartResponseBean({this.message, this.myCartData});

  MyCartResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    myCartData = json['data'] != null ? new MyCartData.fromJson(json['data']) : null;
    data = myCartData;
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

class MyCartData {
  Cart? cart;
  LoanMarginShortfallObj? loanMarginShortfallObj;
  double? minSanctionedLimit;
  double? maxSanctionedLimit;
  double? roi;

  MyCartData({this.cart, this.loanMarginShortfallObj, this.minSanctionedLimit, this.maxSanctionedLimit, this.roi});

  MyCartData.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ? new Cart.fromJson(json['cart']) : null;
    loanMarginShortfallObj = json['loan_margin_shortfall_obj'] != null
        ? new LoanMarginShortfallObj.fromJson(json['loan_margin_shortfall_obj'])
        : null;
    minSanctionedLimit = json['min_sanctioned_limit'];
    maxSanctionedLimit = json['max_sanctioned_limit'];
    roi = json['roi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    if (this.loanMarginShortfallObj != null) {
      data['loan_margin_shortfall_obj'] = this.loanMarginShortfallObj!.toJson();
    }
    data['min_sanctioned_limit'] = this.minSanctionedLimit;
    data['max_sanctioned_limit'] = this.maxSanctionedLimit;
    data['roi'] = this.roi;
    return data;
  }
}

class Cart {
  double? allowableLtv;
  String? creation;
  String? customer;
  int? docstatus;
  String? doctype;
  double? eligibleLoan;
  String? expiry;
  int? idx;
  int? isProcessed;
  List<CartItems>? items;
  String? lender;
  String? loan;
  String? modified;
  String? modifiedBy;
  String? name;
  String? owner;
  Null parent;
  Null parentfield;
  Null parenttype;
  String? pledgeeBoid;
  String? pledgorBoid;
  Null prfNumber;
  String? status;
  double? totalCollateralValue;
  String? totalCollateralValueStr;
  String? approvedTotalCollateralValueStr;
  String? eligibleLoanStr;
  String? approvedEligibleLoanStr;

  Cart(
      {this.allowableLtv,
        this.creation,
        this.customer,
        this.docstatus,
        this.doctype,
        this.eligibleLoan,
        this.expiry,
        this.idx,
        this.isProcessed,
        this.items,
        this.lender,
        this.loan,
        this.modified,
        this.modifiedBy,
        this.name,
        this.owner,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.pledgeeBoid,
        this.pledgorBoid,
        this.prfNumber,
        this.status,
        this.totalCollateralValue,
      this.approvedTotalCollateralValueStr,
      this.approvedEligibleLoanStr,
      this.eligibleLoanStr,
      this.totalCollateralValueStr});

  Cart.fromJson(Map<String, dynamic> json) {
    allowableLtv = json['allowable_ltv'];
    creation = json['creation'];
    customer = json['customer'];
    docstatus = json['docstatus'];
    doctype = json['doctype'];
    eligibleLoan = json['eligible_loan'];
    expiry = json['expiry'];
    idx = json['idx'];
    isProcessed = json['is_processed'];
    if (json['items'] != null) {
      items = <CartItems>[];
      json['items'].forEach((v) {
        items!.add(new CartItems.fromJson(v));
      });
    }
    lender = json['lender'];
    loan = json['loan'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    name = json['name'];
    owner = json['owner'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    pledgeeBoid = json['pledgee_boid'];
    pledgorBoid = json['pledgor_boid'];
    prfNumber = json['prf_number'];
    status = json['status'];
    totalCollateralValue = json['total_collateral_value'];
    approvedTotalCollateralValueStr = json['approved_total_collateral_value_str'];
    approvedEligibleLoanStr = json['approved_eligible_loan_str'];
    eligibleLoanStr = json['eligible_loan_str'];
    totalCollateralValueStr = json['total_collateral_value_str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowable_ltv'] = this.allowableLtv;
    data['creation'] = this.creation;
    data['customer'] = this.customer;
    data['docstatus'] = this.docstatus;
    data['doctype'] = this.doctype;
    data['eligible_loan'] = this.eligibleLoan;
    data['expiry'] = this.expiry;
    data['idx'] = this.idx;
    data['is_processed'] = this.isProcessed;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['lender'] = this.lender;
    data['loan'] = this.loan;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['pledgee_boid'] = this.pledgeeBoid;
    data['pledgor_boid'] = this.pledgorBoid;
    data['prf_number'] = this.prfNumber;
    data['status'] = this.status;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['approved_total_collateral_value_str'] = approvedTotalCollateralValueStr;
    data['approved_eligible_loan_str'] = approvedEligibleLoanStr;
    data['eligible_loan_str'] = eligibleLoanStr;
    data['total_collateral_value_str'] = totalCollateralValueStr;
    return data;
  }
}

class CartItems {
  double? amount;
  String? creation;
  int? docstatus;
  String? doctype;
  double? eligiblePercentage;
  Null errorCode;
  int? idx;
  String? isin;
  String? modified;
  String? modifiedBy;
  String? name;
  String? owner;
  String? parent;
  String? parentfield;
  String? parenttype;
  double? pledgedQuantity;
  int? remaningQty;
  double? price;
  Null psn;
  String? securityCategory;
  String?securityName;
  bool? check;

  CartItems(
      {this.amount,
        this.creation,
        this.docstatus,
        this.doctype,
        this.eligiblePercentage,
        this.errorCode,
        this.idx,
        this.isin,
        this.modified,
        this.modifiedBy,
        this.name,
        this.owner,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.pledgedQuantity,
        this.price,
        this.psn,
        this.securityCategory,
        this.securityName,
      this.check,
      this.remaningQty});

  CartItems.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    creation = json['creation'];
    docstatus = json['docstatus'];
    doctype = json['doctype'];
    eligiblePercentage = json['eligible_percentage'];
    errorCode = json['error_code'];
    idx = json['idx'];
    isin = json['isin'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    name = json['name'];
    owner = json['owner'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    pledgedQuantity = json['pledged_quantity'];
    price = json['price'];
    psn = json['psn'];
    securityCategory = json['security_category'];
    securityName = json['security_name'];
    check = json['check'];
    remaningQty = json['remaning_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['creation'] = this.creation;
    data['docstatus'] = this.docstatus;
    data['doctype'] = this.doctype;
    data['eligible_percentage'] = this.eligiblePercentage;
    data['error_code'] = this.errorCode;
    data['idx'] = this.idx;
    data['isin'] = this.isin;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['pledged_quantity'] = this.pledgedQuantity;
    data['price'] = this.price;
    data['psn'] = this.psn;
    data['security_category'] = this.securityCategory;
    data['security_name'] = this.securityName;
    data['check'] = this.check;
    data['remaning_qty'] = this.remaningQty;
    return data;
  }
}

class LoanMarginShortfallObj {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? loan;
  double? totalCollateralValue;
  double? allowableLtv;
  double? drawingPower;
  double? loanBalance;
  double? minimumCollateralValue;
  double? ltv;
  double? surplusMargin;
  double? shortfall;
  double? shortfallC;
  double? minimumPledgeAmount;
  double? minimumCashAmount;
  double? shortfallPercentage;
  String? marginShortfallAction;
  double? advisablePledgeAmount;
  double? advisableCashAmount;
  String? status;
  String? doctype;

  LoanMarginShortfallObj({this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.loan,
    this.totalCollateralValue,
    this.allowableLtv,
    this.drawingPower,
    this.loanBalance,
    this.minimumCollateralValue,
    this.ltv,
    this.surplusMargin,
    this.shortfall,
    this.shortfallC,
    this.minimumPledgeAmount,
    this.minimumCashAmount,
    this.shortfallPercentage,
    this.marginShortfallAction,
    this.advisablePledgeAmount,
    this.advisableCashAmount,
    this.status,
    this.doctype});

  LoanMarginShortfallObj.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    loan = json['loan'];
    totalCollateralValue = json['total_collateral_value'];
    allowableLtv = json['allowable_ltv'];
    drawingPower = json['drawing_power'];
    loanBalance = json['loan_balance'];
    minimumCollateralValue = json['minimum_collateral_value'];
    ltv = json['ltv'];
    surplusMargin = json['surplus_margin'];
    shortfall = json['shortfall'];
    shortfallC = json['shortfall_c'];
    minimumPledgeAmount = json['minimum_pledge_amount'];
    minimumCashAmount = json['minimum_cash_amount'];
    shortfallPercentage = json['shortfall_percentage'];
    marginShortfallAction = json['margin_shortfall_action'];
    advisablePledgeAmount = json['advisable_pledge_amount'];
    advisableCashAmount = json['advisable_cash_amount'];
    status = json['status'];
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
    data['loan'] = this.loan;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['allowable_ltv'] = this.allowableLtv;
    data['drawing_power'] = this.drawingPower;
    data['loan_balance'] = this.loanBalance;
    data['minimum_collateral_value'] = this.minimumCollateralValue;
    data['ltv'] = this.ltv;
    data['surplus_margin'] = this.surplusMargin;
    data['shortfall'] = this.shortfall;
    data['shortfall_c'] = this.shortfallC;
    data['minimum_pledge_amount'] = this.minimumPledgeAmount;
    data['minimum_cash_amount'] = this.minimumCashAmount;
    data['shortfall_percentage'] = this.shortfallPercentage;
    data['margin_shortfall_action'] = this.marginShortfallAction;
    data['advisable_pledge_amount'] = this.advisablePledgeAmount;
    data['advisable_cash_amount'] = this.advisableCashAmount;
    data['status'] = this.status;
    data['doctype'] = this.doctype;
    return data;
  }
}

class CategoryWiseList{
  String? categoryName;
  List<CartItems>? items;

  CategoryWiseList(this.categoryName, this.items);
}