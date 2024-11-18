// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/my_cart_response_entity.dart';

class MyCartResponseModel {
  String? message;
  MyCartDataResponseModel? myCartData;

  MyCartResponseModel({this.message, this.myCartData});

  MyCartResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    myCartData = json['data'] != null
        ? new MyCartDataResponseModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.myCartData != null) {
      data['data'] = this.myCartData!.toJson();
    }
    return data;
  }

  MyCartResponseEntity toEntity() => MyCartResponseEntity(
        message: message,
        myCartData: myCartData?.toEntity(),
      );
}

class MyCartDataResponseModel {
  CartResponseModel? cart;
  LoanMarginShortfallResponseModel? loanMarginShortfallObj;
  double? minSanctionedLimit;
  double? maxSanctionedLimit;
  double? roi;

  MyCartDataResponseModel(
      {this.cart,
      this.loanMarginShortfallObj,
      this.minSanctionedLimit,
      this.maxSanctionedLimit,
      this.roi});

  MyCartDataResponseModel.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null
        ? new CartResponseModel.fromJson(json['cart'])
        : null;
    loanMarginShortfallObj = json['loan_margin_shortfall_obj'] != null
        ? new LoanMarginShortfallResponseModel.fromJson(
            json['loan_margin_shortfall_obj'])
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

  MyCartDataResponseEntity toEntity() => MyCartDataResponseEntity(
        cart: cart?.toEntity(),
        loanMarginShortfallObj: loanMarginShortfallObj?.toEntity(),
        minSanctionedLimit: minSanctionedLimit,
        maxSanctionedLimit: maxSanctionedLimit,
        roi: roi,
      );
}

class CartResponseModel {
  double? allowableLtv;
  String? creation;
  String? customer;
  int? docstatus;
  String? doctype;
  double? eligibleLoan;
  String? expiry;
  int? idx;
  int? isProcessed;
  List<CartItemsResponseModel>? items;
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

  CartResponseModel(
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

  CartResponseModel.fromJson(Map<String, dynamic> json) {
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
      items = <CartItemsResponseModel>[];
      json['items'].forEach((v) {
        items!.add(new CartItemsResponseModel.fromJson(v));
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
    approvedTotalCollateralValueStr =
        json['approved_total_collateral_value_str'];
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
    data['approved_total_collateral_value_str'] =
        approvedTotalCollateralValueStr;
    data['approved_eligible_loan_str'] = approvedEligibleLoanStr;
    data['eligible_loan_str'] = eligibleLoanStr;
    data['total_collateral_value_str'] = totalCollateralValueStr;
    return data;
  }

  CartResponseEntity toEntity() => CartResponseEntity(
        allowableLtv: allowableLtv,
        creation: creation,
        customer: customer,
        docstatus: docstatus,
        doctype: doctype,
        eligibleLoan: eligibleLoan,
        expiry: expiry,
        idx: idx,
        isProcessed: isProcessed,
        items: items?.map((x) => x.toEntity()).toList(),
        lender: lender,
        loan: loan,
        modified: modified,
        modifiedBy: modifiedBy,
        name: name,
        owner: owner,
        parent: parent,
        parentfield: parentfield,
        parenttype: parenttype,
        pledgeeBoid: pledgeeBoid,
        pledgorBoid: pledgorBoid,
        prfNumber: prfNumber,
        status: status,
        totalCollateralValue: totalCollateralValue,
        totalCollateralValueStr: totalCollateralValueStr,
        approvedTotalCollateralValueStr: approvedTotalCollateralValueStr,
        eligibleLoanStr: eligibleLoanStr,
        approvedEligibleLoanStr: approvedEligibleLoanStr,
      );
}

class CartItemsResponseModel {
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
  String? securityName;
  bool? check;

  CartItemsResponseModel(
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

  CartItemsResponseModel.fromJson(Map<String, dynamic> json) {
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

  CartItemsResponseEntity toEntity() => CartItemsResponseEntity(
        amount: amount,
        creation: creation,
        docstatus: docstatus,
        doctype: doctype,
        eligiblePercentage: eligiblePercentage,
        errorCode: errorCode,
        idx: idx,
        isin: isin,
        modified: modified,
        modifiedBy: modifiedBy,
        name: name,
        owner: owner,
        parent: parent,
        parentfield: parentfield,
        parenttype: parenttype,
        pledgedQuantity: pledgedQuantity,
        remaningQty: remaningQty,
        price: price,
        psn: psn,
        securityCategory: securityCategory,
        check: check,
      );
}

class LoanMarginShortfallResponseModel {
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

  LoanMarginShortfallResponseModel(
      {this.name,
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

  LoanMarginShortfallResponseModel.fromJson(Map<String, dynamic> json) {
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

  LoanMarginShortfallResponseEntity toEntity() =>
      LoanMarginShortfallResponseEntity(
        name: name,
        owner: owner,
        creation: creation,
        modified: modified,
        modifiedBy: modifiedBy,
        idx: idx,
        docstatus: docstatus,
        loan: loan,
        totalCollateralValue: totalCollateralValue,
        allowableLtv: allowableLtv,
        drawingPower: drawingPower,
        loanBalance: loanBalance,
        minimumCollateralValue: minimumCollateralValue,
        ltv: ltv,
        surplusMargin: surplusMargin,
        shortfall: shortfall,
        shortfallC: shortfallC,
        minimumPledgeAmount: minimumPledgeAmount,
        minimumCashAmount: minimumCashAmount,
        shortfallPercentage: shortfallPercentage,
        marginShortfallAction: marginShortfallAction,
        advisablePledgeAmount: advisablePledgeAmount,
        advisableCashAmount: advisableCashAmount,
        status: status,
        doctype: doctype,
      );
}

class CategoryWiseListModel {
  String? categoryName;
  List<CartItemsResponseModel>? items;

  CategoryWiseListModel(this.categoryName, this.items);
}
