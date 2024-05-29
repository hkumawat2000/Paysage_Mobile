import 'package:lms/network/responsebean/UserKYCResponse.dart';

class UserKYCRequest {
  UserKyc? userKyc;
  int? acceptTerms;

  UserKYCRequest(this.userKyc, this.acceptTerms);

  UserKYCRequest.fromJson(Map<String, dynamic> json) {
    userKyc = json['user_kyc'] != null
        ? new UserKyc.fromJson(json['user_kyc'])
        : null;
    acceptTerms = json['accept_terms'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userKyc != null) {
      data['user_kyc'] = this.userKyc!.toJson();
    }
    data['accept_terms'] = this.acceptTerms;
    return data;
  }
}

// class UserKycReq {
//   String aadharNo;
//   String address;
//   String city;
//   String creation;
//   int docstatus;
//   String doctype;
//   String fatherName;
//   int idx;
//   String investorName;
//   String kycType;
//   String mobileNumber;
//   String modified;
//   String modifiedBy;
//   String motherName;
//   String name;
//   String owner;
//   String panNo;
//   Null parent;
//   Null parentfield;
//   Null parenttype;
//   String user;
//   List<BanksReq> banks;
//
//   UserKycReq(
//       {this.aadharNo,
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
//   UserKycReq.fromJson(Map<String, dynamic> json) {
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
//       banks = new List<BanksReq>();
//       json['bank_account'].forEach((v) {
//         banks.add(new BanksReq.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
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
// class BanksReq {
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
//   String bank;
//   String branch;
//   String accountNumber;
//   String ifsc;
//   String bankCode;
//   String city;
//   String state;
//   // int isDefault;
//   String bankAddress;
//   String contact;
//   String accountType;
//   String micr;
//   String bankMode;
//   String bankZipCode;
//   String district;
//   String userKyc;
//   Null nUserTags;
//   Null nComments;
//   Null nAssign;
//   Null nLikedBy;
//
//   BanksReq(
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
//   BanksReq.fromJson(Map<String, dynamic> json) {
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