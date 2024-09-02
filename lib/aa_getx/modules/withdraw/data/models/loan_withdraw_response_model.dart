import 'dart:convert';

import 'package:lms/aa_getx/modules/withdraw/domain/entities/loan_withdraw_response_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoanWithdrawResponseModel {
  String? message;
  LoanWithDrawDetailDataResponseModel? loanWithDrawDetailDataResponseModel;

  LoanWithdrawResponseModel({
    this.message,
    this.loanWithDrawDetailDataResponseModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': loanWithDrawDetailDataResponseModel?.toMap(),
    };
  }

  factory LoanWithdrawResponseModel.fromMap(Map<String, dynamic> map) {
    return LoanWithdrawResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      loanWithDrawDetailDataResponseModel: map['data'] != null
          ? LoanWithDrawDetailDataResponseModel.fromMap(
              map['data']
                  as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanWithdrawResponseModel.fromJson(String source) =>
      LoanWithdrawResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  LoanWithdrawResponseEntity toEntity() => LoanWithdrawResponseEntity(
        message: message,
        loanWithDrawDetailDataResponseEntity:
            loanWithDrawDetailDataResponseModel?.toEntity(),
      );
}






class LoanWithDrawDetailDataResponseModel {
  LoanDataResponseModel? loanDataResponseModel;
  List<BanksResponseModel>? banks;
  LoanWithDrawDetailDataResponseModel({
    this.loanDataResponseModel,
    this.banks,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loan': loanDataResponseModel?.toMap(),
      'banks': banks!.map((x) => x?.toMap()).toList(),
    };
  }

  factory LoanWithDrawDetailDataResponseModel.fromMap(Map<String, dynamic> map) {
    return LoanWithDrawDetailDataResponseModel(
      loanDataResponseModel: map['loan'] != null ? LoanDataResponseModel.fromMap(map['loan'] as Map<String,dynamic>) : null,
      banks: map['banks'] != null ? List<BanksResponseModel>.from((map['banks'] as List<int>).map<BanksResponseModel?>((x) => BanksResponseModel.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanWithDrawDetailDataResponseModel.fromJson(String source) => LoanWithDrawDetailDataResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  LoanWithDrawDetailDataResponseEntity toEntity() =>
  LoanWithDrawDetailDataResponseEntity(
      loanDataResponseEntity: loanDataResponseModel?.toEntity(),
      banks: banks?.map((x) => x.toEntity()).toList(),
  
  );
}






class LoanDataResponseModel {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  double? totalCollateralValue;
  double? drawingPower;
  String? drawingPowerStr;
  String? lender;
  double? sanctionedLimit;
  double? balance;
  String? balanceStr;
  String? customer;
  double? allowableLtv;
  String? expiryDate;
  String? loanAgreement;
  String? doctype;
  List<ItemsResponseModel>? items;
  double? amountAvailableForWithdrawal;
  LoanDataResponseModel({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.totalCollateralValue,
    this.drawingPower,
    this.drawingPowerStr,
    this.lender,
    this.sanctionedLimit,
    this.balance,
    this.balanceStr,
    this.customer,
    this.allowableLtv,
    this.expiryDate,
    this.loanAgreement,
    this.doctype,
    this.items,
    this.amountAvailableForWithdrawal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'owner': owner,
      'creation': creation,
      'modified': modified,
      'modified_by': modifiedBy,
      'idx': idx,
      'docstatus': docstatus,
      'total_collateral_value': totalCollateralValue,
      'drawing_power': drawingPower,
      'drawing_power_str': drawingPowerStr,
      'lender': lender,
      'sanctioned_limit': sanctionedLimit,
      'balance': balance,
      'balance_str': balanceStr,
      'customer': customer,
      'allowable_ltv': allowableLtv,
      'expiry_date': expiryDate,
      'loan_agreement': loanAgreement,
      'doctype': doctype,
      'items': items!.map((x) => x?.toMap()).toList(),
      'amount_available_for_withdrawal': amountAvailableForWithdrawal,
    };
  }

  factory LoanDataResponseModel.fromMap(Map<String, dynamic> map) {
    return LoanDataResponseModel(
      name: map['name'] != null ? map['name'] as String : null,
      owner: map['owner'] != null ? map['owner'] as String : null,
      creation: map['creation'] != null ? map['creation'] as String : null,
      modified: map['modified'] != null ? map['modified'] as String : null,
      modifiedBy: map['modified_by'] != null ? map['modified_by'] as String : null,
      idx: map['idx'] != null ? map['idx'] as int : null,
      docstatus: map['docstatus'] != null ? map['docstatus'] as int : null,
      totalCollateralValue: map['total_collateral_value'] != null ? map['total_collateral_value'] as double : null,
      drawingPower: map['drawing_power'] != null ? map['drawing_power'] as double : null,
      drawingPowerStr: map['drawing_power_str'] != null ? map['drawing_power_str'] as String : null,
      lender: map['lender'] != null ? map['lender'] as String : null,
      sanctionedLimit: map['sanctioned_limit'] != null ? map['sanctioned_limit'] as double : null,
      balance: map['balance'] != null ? map['balance'] as double : null,
      balanceStr: map['balance_str'] != null ? map['balance_str'] as String : null,
      customer: map['customer'] != null ? map['customer'] as String : null,
      allowableLtv: map['allowable_ltv'] != null ? map['allowable_ltv'] as double : null,
      expiryDate: map['expiry_date'] != null ? map['expiry_date'] as String : null,
      loanAgreement: map['loan_agreement'] != null ? map['loan_agreement'] as String : null,
      doctype: map['doctype'] != null ? map['doctype'] as String : null,
      items: map['items'] != null ? List<ItemsResponseModel>.from((map['items'] as List<int>).map<ItemsResponseModel?>((x) => ItemsResponseModel.fromMap(x as Map<String,dynamic>),),) : null,
      amountAvailableForWithdrawal: map['amount_available_for_withdrawal'] != null ? map['amount_available_for_withdrawal'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanDataResponseModel.fromJson(String source) => LoanDataResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  LoanDataResponseEntity toEntity() =>
  LoanDataResponseEntity(
      name: name,
      owner: owner,
      creation: creation,
      modified: modified,
      modifiedBy: modifiedBy,
      idx: idx,
      docstatus: docstatus,
      totalCollateralValue: totalCollateralValue,
      drawingPower: drawingPower,
      drawingPowerStr: drawingPowerStr,
      lender: lender,
      sanctionedLimit: sanctionedLimit,
      balance: balance,
      balanceStr: balanceStr,
      customer: customer,
      allowableLtv: allowableLtv,
      expiryDate: expiryDate,
      loanAgreement: loanAgreement,
      doctype: doctype,
      items: items?.map((x) => x.toEntity()).toList(),
      amountAvailableForWithdrawal: amountAvailableForWithdrawal,
  
  );
}




class ItemsResponseModel {
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
  double? pledgedQuantity;
  double? price;
  double? amount;
  String? psn;
  String? errorCode;
  String? doctype;
  ItemsResponseModel({
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
    this.isin,
    this.securityName,
    this.securityCategory,
    this.pledgedQuantity,
    this.price,
    this.amount,
    this.psn,
    this.errorCode,
    this.doctype,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'owner': owner,
      'creation': creation,
      'modified': modified,
      'modified_by': modifiedBy,
      'parent': parent,
      'parentfield': parentfield,
      'parenttype': parenttype,
      'idx': idx,
      'docstatus': docstatus,
      'isin': isin,
      'security_name': securityName,
      'security_category': securityCategory,
      'pledged_quantity': pledgedQuantity,
      'price': price,
      'amount': amount,
      'psn': psn,
      'error_code': errorCode,
      'doctype': doctype,
    };
  }

  factory ItemsResponseModel.fromMap(Map<String, dynamic> map) {
    return ItemsResponseModel(
      name: map['name'] != null ? map['name'] as String : null,
      owner: map['owner'] != null ? map['owner'] as String : null,
      creation: map['creation'] != null ? map['creation'] as String : null,
      modified: map['modified'] != null ? map['modified'] as String : null,
      modifiedBy: map['modified_by'] != null ? map['modified_by'] as String : null,
      parent: map['parent'] != null ? map['parent'] as String : null,
      parentfield: map['parentfield'] != null ? map['parentfield'] as String : null,
      parenttype: map['parenttype'] != null ? map['parenttype'] as String : null,
      idx: map['idx'] != null ? map['idx'] as int : null,
      docstatus: map['docstatus'] != null ? map['docstatus'] as int : null,
      isin: map['isin'] != null ? map['isin'] as String : null,
      securityName: map['security_name'] != null ? map['security_name'] as String : null,
      securityCategory: map['security_category'] != null ? map['security_category'] as String : null,
      pledgedQuantity: map['pledged_quantity'] != null ? map['pledged_quantity'] as double : null,
      price: map['price'] != null ? map['price'] as double : null,
      amount: map['amount'] != null ? map['amount'] as double : null,
      psn: map['psn'] != null ? map['psn'] as String : null,
      errorCode: map['error_code'] != null ? map['error_code'] as String : null,
      doctype: map['doctype'] != null ? map['doctype'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemsResponseModel.fromJson(String source) => ItemsResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ItemsResponseEntity toEntity() =>
  ItemsResponseEntity(
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
      isin: isin,
      securityName: securityName,
      securityCategory: securityCategory,
      pledgedQuantity: pledgedQuantity,
      price: price,
      amount: amount,
      psn: psn,
      errorCode: errorCode,
      doctype: doctype,
  
  );
}





class BanksResponseModel {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  String? parent;
  String? parentfield;
  String? parenttype;
  int? idx;
  String? bank;
  String? branch;
  String? accountNumber;
  String? ifsc;
  String? bankCode;
  String? city;
  String? state;
  int? isDefault;
  String? bankAddress;
  String? contact;
  String? accountType;
  String? micr;
  String? bankMode;
  String? bankZipCode;
  String? district;
  String? userKyc;
  BanksResponseModel({
    this.name,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.owner,
    this.docstatus,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.bank,
    this.branch,
    this.accountNumber,
    this.ifsc,
    this.bankCode,
    this.city,
    this.state,
    this.isDefault,
    this.bankAddress,
    this.contact,
    this.accountType,
    this.micr,
    this.bankMode,
    this.bankZipCode,
    this.district,
    this.userKyc,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'creation': creation,
      'modified': modified,
      'modified_by': modifiedBy,
      'owner': owner,
      'docstatus': docstatus,
      'parent': parent,
      'parentfield': parentfield,
      'parenttype': parenttype,
      'idx': idx,
      'bank': bank,
      'branch': branch,
      'account_number': accountNumber,
      'ifsc': ifsc,
      'bank_code': bankCode,
      'city': city,
      'state': state,
      'is_default': isDefault,
      'bank_address': bankAddress,
      'contact': contact,
      'account_type': accountType,
      'micr': micr,
      'bank_mode': bankMode,
      'bank_zip_code': bankZipCode,
      'district': district,
      'user_kyc': userKyc,
    };
  }

  factory BanksResponseModel.fromMap(Map<String, dynamic> map) {
    return BanksResponseModel(
      name: map['name'] != null ? map['name'] as String : null,
      creation: map['creation'] != null ? map['creation'] as String : null,
      modified: map['modified'] != null ? map['modified'] as String : null,
      modifiedBy: map['modified_by'] != null ? map['modified_by'] as String : null,
      owner: map['owner'] != null ? map['owner'] as String : null,
      docstatus: map['docstatus'] != null ? map['docstatus'] as int : null,
      parent: map['parent'] != null ? map['parent'] as String : null,
      parentfield: map['parentfield'] != null ? map['parentfield'] as String : null,
      parenttype: map['parenttype'] != null ? map['parenttype'] as String : null,
      idx: map['idx'] != null ? map['idx'] as int : null,
      bank: map['bank'] != null ? map['bank'] as String : null,
      branch: map['branch'] != null ? map['branch'] as String : null,
      accountNumber: map['account_number'] != null ? map['account_number'] as String : null,
      ifsc: map['ifsc'] != null ? map['ifsc'] as String : null,
      bankCode: map['bank_code'] != null ? map['bank_code'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      isDefault: map['is_default'] != null ? map['is_default'] as int : null,
      bankAddress: map['bank_address'] != null ? map['bank_address'] as String : null,
      contact: map['contact'] != null ? map['contact'] as String : null,
      accountType: map['account_type'] != null ? map['account_type'] as String : null,
      micr: map['micr'] != null ? map['micr'] as String : null,
      bankMode: map['bank_mode'] != null ? map['bank_mode'] as String : null,
      bankZipCode: map['bank_zip_code'] != null ? map['bank_zip_code'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      userKyc: map['user_kyc'] != null ? map['user_kyc'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BanksResponseModel.fromJson(String source) => BanksResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  BanksResponseEntity toEntity() =>
  BanksResponseEntity(
      name: name,
      creation: creation,
      modified: modified,
      modifiedBy: modifiedBy,
      owner: owner,
      docstatus: docstatus,
      parent: parent,
      parentfield: parentfield,
      parenttype: parenttype,
      idx: idx,
      bank: bank,
      branch: branch,
      accountNumber: accountNumber,
      ifsc: ifsc,
      bankCode: bankCode,
      city: city,
      state: state,
      isDefault: isDefault,
      bankAddress: bankAddress,
      contact: contact,
      accountType: accountType,
      micr: micr,
      bankMode: bankMode,
      bankZipCode: bankZipCode,
      district: district,
      userKyc: userKyc,
  
  );
}
