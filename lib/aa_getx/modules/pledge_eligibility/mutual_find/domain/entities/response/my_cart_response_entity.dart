class MyCartResponseEntity {
  String? message;
  MyCartDataResponseEntity? myCartData;

  MyCartResponseEntity({this.message, this.myCartData});
}

class MyCartDataResponseEntity {
  CartResponseEntity? cart;
  LoanMarginShortfallResponseEntity? loanMarginShortfallObj;
  double? minSanctionedLimit;
  double? maxSanctionedLimit;
  double? roi;

  MyCartDataResponseEntity(
      {this.cart,
      this.loanMarginShortfallObj,
      this.minSanctionedLimit,
      this.maxSanctionedLimit,
      this.roi});
}

class CartResponseEntity {
  double? allowableLtv;
  String? creation;
  String? customer;
  int? docstatus;
  String? doctype;
  double? eligibleLoan;
  String? expiry;
  int? idx;
  int? isProcessed;
  List<CartItemsResponseEntity>? items;
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

  CartResponseEntity(
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
}

class CartItemsResponseEntity {
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

  CartItemsResponseEntity(
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
}

class LoanMarginShortfallResponseEntity {
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

  LoanMarginShortfallResponseEntity(
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
}

class CategoryWiseListEntity {
  String? categoryName;
  List<CartItemsResponseEntity>? items;

  CategoryWiseListEntity(this.categoryName, this.items);
}
