import 'package:choice/network/ModelWrapper.dart';

class ProfileResposoneBean extends ModelWrapper<ProfileData>{
  ProfileData? profileData;

  ProfileResposoneBean({this.profileData});

  ProfileResposoneBean.fromJson(Map<String, dynamic> json) {
    profileData = json['data'] != null ? new ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profileData != null) {
      data['data'] = this.profileData!.toJson();
    }
    return data;
  }
}

class ProfileData {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? userStatus;
  String? choiceKyc;
  String? ckcy;
  String? kra;
  String? firstName;
  int? age;
  String? phone;
  String? gender;
  String? lastName;
  String? martialStatus;
  String? username;
  int? aadhaarNumber;
  String? accountType;
  String? email;
  int? registeration;
  int? isEmailVerified;
  int? kycUpdate;
  int? creditCheck;
  int? pledgeSecurities;
  int? loanOpen;
  String? doctype;

  ProfileData(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.userStatus,
        this.choiceKyc,
        this.ckcy,
        this.kra,
        this.firstName,
        this.age,
        this.phone,
        this.gender,
        this.lastName,
        this.martialStatus,
        this.username,
        this.aadhaarNumber,
        this.accountType,
        this.email,
        this.registeration,
        this.isEmailVerified,
        this.kycUpdate,
        this.creditCheck,
        this.pledgeSecurities,
        this.loanOpen,
        this.doctype,
        });

  ProfileData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    userStatus = json['user_status'];
    choiceKyc = json['choice_kyc'];
    ckcy = json['ckcy'];
    kra = json['kra'];
    firstName = json['first_name'];
    age = json['age'];
    phone = json['phone'];
    gender = json['gender'];
    lastName = json['last_name'];
    martialStatus = json['martial_status'];
    username = json['username'];
    aadhaarNumber = json['aadhaar_number'];
    accountType = json['account_type'];
    email = json['email'];
    registeration = json['registeration'];
    isEmailVerified = json['is_email_verified'];
    kycUpdate = json['kyc_update'];
    creditCheck = json['credit_check'];
    pledgeSecurities = json['pledge_securities'];
    loanOpen = json['loan_open'];
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
    data['user_status'] = this.userStatus;
    data['choice_kyc'] = this.choiceKyc;
    data['ckcy'] = this.ckcy;
    data['kra'] = this.kra;
    data['first_name'] = this.firstName;
    data['age'] = this.age;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['last_name'] = this.lastName;
    data['martial_status'] = this.martialStatus;
    data['username'] = this.username;
    data['aadhaar_number'] = this.aadhaarNumber;
    data['account_type'] = this.accountType;
    data['email'] = this.email;
    data['registeration'] = this.registeration;
    data['is_email_verified'] = this.isEmailVerified;
    data['kyc_update'] = this.kycUpdate;
    data['credit_check'] = this.creditCheck;
    data['pledge_securities'] = this.pledgeSecurities;
    data['loan_open'] = this.loanOpen;
    data['doctype'] = this.doctype;
    return data;
  }
}