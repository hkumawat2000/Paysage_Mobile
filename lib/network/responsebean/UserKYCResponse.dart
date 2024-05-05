import 'package:choice/network/ModelWrapper.dart';

class UserKYCResponseBean extends ModelWrapper<UserKYCData>{
  String? message;
  UserKYCData? userKYCData;

  UserKYCResponseBean({this.message, this.userKYCData});

  UserKYCResponseBean.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userKYCData = json['data'] != null
        ? new UserKYCData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.userKYCData != null) {
      data['UserKYCData'] = this.userKYCData!.toJson();
    }
    return data;
  }
}

class UserKYCData {
  UserKyc? userKyc;

  UserKYCData({this.userKyc});

  UserKYCData.fromJson(Map<String, dynamic> json) {
    userKyc = json['user_kyc'] != null
        ? new UserKyc.fromJson(json['user_kyc'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userKyc != null) {
      data['user_kyc'] = this.userKyc!.toJson();
    }
    return data;
  }
}

class UserKyc {
  String? kycType;
  String? investorName;
  String? fatherName;
  String? motherName;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? mobileNumber;
  String? choiceClientId;
  String? panNo;
  String? dateOfBirth;
  List<BankAccount>? bankAccount;

  UserKyc(
      {this.kycType,
        this.investorName,
        this.fatherName,
        this.motherName,
        this.address,
        this.city,
        this.state,
        this.pincode,
        this.mobileNumber,
        this.choiceClientId,
        this.panNo,
        this.dateOfBirth,
        this.bankAccount});

  UserKyc.fromJson(Map<String, dynamic> json) {
    kycType = json['kyc_type'];
    investorName = json['investor_name'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    mobileNumber = json['mobile_number'];
    choiceClientId = json['choice_client_id'];
    panNo = json['pan_no'];
    dateOfBirth = json['date_of_birth'];
    if (json['bank_account'] != null) {
      bankAccount = <BankAccount>[];
      json['bank_account'].forEach((v) {
        bankAccount!.add(new BankAccount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kyc_type'] = this.kycType;
    data['investor_name'] = this.investorName;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['mobile_number'] = this.mobileNumber;
    data['choice_client_id'] = this.choiceClientId;
    data['pan_no'] = this.panNo;
    data['date_of_birth'] = this.dateOfBirth;
    if (this.bankAccount != null) {
      data['bank_account'] = this.bankAccount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankAccount {
  String? bank;
  String? bankAddress;
  String? branch;
  String? contact;
  String? accountType;
  String? accountNumber;
  String? ifsc;
  String? micr;
  String? bankMode;
  String? bankCode;
  String? bankZipCode;
  String? city;
  String? district;
  String? state;
  bool? isDefault;

  BankAccount(
      {this.bank,
        this.bankAddress,
        this.branch,
        this.contact,
        this.accountType,
        this.accountNumber,
        this.ifsc,
        this.micr,
        this.bankMode,
        this.bankCode,
        this.bankZipCode,
        this.city,
        this.district,
        this.state,
        this.isDefault});

  BankAccount.fromJson(Map<String, dynamic> json) {
    bank = json['bank'];
    bankAddress = json['bank_address'];
    branch = json['branch'];
    contact = json['contact'];
    accountType = json['account_type'];
    accountNumber = json['account_number'];
    ifsc = json['ifsc'];
    micr = json['micr'];
    bankMode = json['bank_mode'];
    bankCode = json['bank_code'];
    bankZipCode = json['bank_zip_code'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bank'] = this.bank;
    data['bank_address'] = this.bankAddress;
    data['branch'] = this.branch;
    data['contact'] = this.contact;
    data['account_type'] = this.accountType;
    data['account_number'] = this.accountNumber;
    data['ifsc'] = this.ifsc;
    data['micr'] = this.micr;
    data['bank_mode'] = this.bankMode;
    data['bank_code'] = this.bankCode;
    data['bank_zip_code'] = this.bankZipCode;
    data['city'] = this.city;
    data['district'] = this.district;
    data['state'] = this.state;
    data['is_default'] = this.isDefault;
    return data;
  }
}




// class UserKYCResponseBean extends ModelWrapper<UserKYCData> {
//   String message;
//   UserKYCData data;
//
//   UserKYCResponseBean({this.message, this.data});
//
//   UserKYCResponseBean.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     data = json['data'] != null ? new UserKYCData.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }
//
// class UserKYCData {
//   KycUser userKyc;
//
//   UserKYCData({this.userKyc});
//
//   UserKYCData.fromJson(Map<String, dynamic> json) {
//     userKyc = json['user_kyc'] != null
//         ? new KycUser.fromJson(json['user_kyc'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.userKyc != null) {
//       data['user_kyc'] = this.userKyc.toJson();
//     }
//     return data;
//   }
// }
//
// class KycUser {
//   String kycType;
//   String investorName;
//   String fatherName;
//   String motherName;
//   String address;
//   String city;
//
//   String state;
//   String pinCode;
//   String choiceClienID;
//   String DOB;
//
//   String mobileNumber;
//   String panNo;
//   List<Banks> banks;
//
//
//   String aadharNo;
//   String creation;
//   int docstatus;
//   String doctype;
//   int idx;
//   String modified;
//   String modifiedBy;
//   String name;
//   String owner;
//   Null parent;
//   Null parentfield;
//   Null parenttype;
//   String user;
//
//   KycUser(
//       {this.state,
//       this.pinCode,
//       this.choiceClienID,
//       this.DOB,
//         this.aadharNo,
//         this.address,
//         this.city,
//         this.creation,
//         this.docstatus,
//         this.doctype,
//         this.fatherName,
//         this.idx,
//         this.investorName,
//         this.kycType,
//         this.mobileNumber,
//         this.modified,
//         this.modifiedBy,
//         this.motherName,
//         this.name,
//         this.owner,
//         this.panNo,
//         this.parent,
//         this.parentfield,
//         this.parenttype,
//         this.user,
//         this.banks});
//
//   KycUser.fromJson(Map<String, dynamic> json) {
//     state = json['state'];
//     pinCode = json['pincode'];
//     choiceClienID = json['choice_client_id'];
//     DOB = json['date_of_birth'];
//     aadharNo = json['aadhar_no'];
//     address = json['address'];
//     city = json['city'];
//     creation = json['creation'];
//     docstatus = json['docstatus'];
//     doctype = json['doctype'];
//     fatherName = json['father_name'];
//     idx = json['idx'];
//     investorName = json['investor_name'];
//     kycType = json['kyc_type'];
//     mobileNumber = json['mobile_number'];
//     modified = json['modified'];
//     modifiedBy = json['modified_by'];
//     motherName = json['mother_name'];
//     name = json['name'];
//     owner = json['owner'];
//     panNo = json['pan_no'];
//     parent = json['parent'];
//     parentfield = json['parentfield'];
//     parenttype = json['parenttype'];
//     user = json['user'];
//     if (json['bank_account'] != null) {
//       banks = new List<Banks>();
//       json['bank_account'].forEach((v) {
//         banks.add(new Banks.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['state'] = state;
//     data['pincode'] = pinCode;
//     data['choice_client_id'] = choiceClienID;
//     data['date_of_birth'] = DOB;
//     data['aadhar_no'] = this.aadharNo;
//     data['address'] = this.address;
//     data['city'] = this.city;
//     data['creation'] = this.creation;
//     data['docstatus'] = this.docstatus;
//     data['doctype'] = this.doctype;
//     data['father_name'] = this.fatherName;
//     data['idx'] = this.idx;
//     data['investor_name'] = this.investorName;
//     data['kyc_type'] = this.kycType;
//     data['mobile_number'] = this.mobileNumber;
//     data['modified'] = this.modified;
//     data['modified_by'] = this.modifiedBy;
//     data['mother_name'] = this.motherName;
//     data['name'] = this.name;
//     data['owner'] = this.owner;
//     data['pan_no'] = this.panNo;
//     data['parent'] = this.parent;
//     data['parentfield'] = this.parentfield;
//     data['parenttype'] = this.parenttype;
//     data['user'] = this.user;
//     if (this.banks != null) {
//       data['banks'] = this.banks.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Banks {
//   String bank;
//   String bankAddress;
//   String branch;
//   String contact;
//   String accountType;
//   String accountNumber;
//   String ifsc;
//   String micr;
//   String bankMode;
//   String bankCode;
//   String city;
//   String district;
//   String state;
//   bool isDefault;
//
//   String name;
//   String creation;
//   String modified;
//   String modifiedBy;
//   String owner;
//   int docstatus;
//   String parent;
//   String parentfield;
//   String parenttype;
//   int idx;
//   String bankZipCode;
//   String userKyc;
//   Null nUserTags;
//   Null nComments;
//   Null nAssign;
//   Null nLikedBy;
//
//   Banks(
//       {this.name,
//         this.creation,
//         this.modified,
//         this.modifiedBy,
//         this.owner,
//         this.docstatus,
//         this.parent,
//         this.parentfield,
//         this.parenttype,
//         this.idx,
//         this.bank,
//         this.branch,
//         this.accountNumber,
//         this.ifsc,
//         this.bankCode,
//         this.city,
//         this.state,
//         // this.isDefault,
//         this.bankAddress,
//         this.contact,
//         this.accountType,
//         this.micr,
//         this.bankMode,
//         this.bankZipCode,
//         this.district,
//         this.userKyc,
//         this.nUserTags,
//         this.nComments,
//         this.nAssign,
//         this.nLikedBy});
//
//   Banks.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     creation = json['creation'];
//     modified = json['modified'];
//     modifiedBy = json['modified_by'];
//     owner = json['owner'];
//     docstatus = json['docstatus'];
//     parent = json['parent'];
//     parentfield = json['parentfield'];
//     parenttype = json['parenttype'];
//     idx = json['idx'];
//     bank = json['bank'];
//     branch = json['branch'];
//     accountNumber = json['account_number'];
//     ifsc = json['ifsc'];
//     bankCode = json['bank_code'];
//     city = json['city'];
//     state = json['state'];
//     // isDefault = json['is_default'];
//     bankAddress = json['bank_address'];
//     contact = json['contact'];
//     accountType = json['account_type'];
//     micr = json['micr'];
//     bankMode = json['bank_mode'];
//     bankZipCode = json['bank_zip_code'];
//     district = json['district'];
//     userKyc = json['user_kyc'];
//     nUserTags = json['_user_tags'];
//     nComments = json['_comments'];
//     nAssign = json['_assign'];
//     nLikedBy = json['_liked_by'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['creation'] = this.creation;
//     data['modified'] = this.modified;
//     data['modified_by'] = this.modifiedBy;
//     data['owner'] = this.owner;
//     data['docstatus'] = this.docstatus;
//     data['parent'] = this.parent;
//     data['parentfield'] = this.parentfield;
//     data['parenttype'] = this.parenttype;
//     data['idx'] = this.idx;
//     data['bank'] = this.bank;
//     data['branch'] = this.branch;
//     data['account_number'] = this.accountNumber;
//     data['ifsc'] = this.ifsc;
//     data['bank_code'] = this.bankCode;
//     data['city'] = this.city;
//     data['state'] = this.state;
//     // data['is_default'] = this.isDefault;
//     data['bank_address'] = this.bankAddress;
//     data['contact'] = this.contact;
//     data['account_type'] = this.accountType;
//     data['micr'] = this.micr;
//     data['bank_mode'] = this.bankMode;
//     data['bank_zip_code'] = this.bankZipCode;
//     data['district'] = this.district;
//     data['user_kyc'] = this.userKyc;
//     data['_user_tags'] = this.nUserTags;
//     data['_comments'] = this.nComments;
//     data['_assign'] = this.nAssign;
//     data['_liked_by'] = this.nLikedBy;
//     return data;
//   }
// }