import 'dart:convert';

import 'package:lms/network/ModelWrapper.dart';
import 'package:lms/widgets/WidgetCommon.dart';

import '../NewDashboardResponse.dart';

class AuthLoginResponse extends ModelWrapper<RegisterData>{
  String? message;
  RegisterData? registerData;
  Errors? errors;

  AuthLoginResponse({this.message, this.registerData,this.errors});

  AuthLoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data =
    json['data'] != null ? new RegisterData.fromJson(json['data']) : null;
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    } if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}

class RegisterData {
  String? token;
  Customer? customer;
  UserKyc? userKyc;
  List<PendingEsigns>? pendingEsigns;

  RegisterData({this.token, this.customer, this.userKyc,this.pendingEsigns});

  RegisterData.fromJson(Map<String, dynamic> json) {
    try {
      token = json['token'];
      if(json['customer'] != null && json['customer'] != ""){
        customer = new Customer.fromJson(json['customer']);
      }
      userKyc = json['user_kyc'] != null
          ? new UserKyc.fromJson(json['user_kyc'])
          : null;
      if (json['pending_esigns'] != null && json['pending_esigns'] != "") {
        pendingEsigns = <PendingEsigns>[];
        json['pending_esigns'].forEach((v) {
          pendingEsigns!.add(new PendingEsigns.fromJson(v));
        });
      }
    } catch (e, s) {
      printLog(s.toString());
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.userKyc != null) {
      data['user_kyc'] = this.userKyc!.toJson();
    }
    if (this.pendingEsigns != null) {
      data['pending_esigns'] =
          this.pendingEsigns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
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
  String? firstName;
  // Null middleName;
  String? username;
  String? lastName;
  String? email;
  String? camsEmailId;
  String? phone;
  String? fullName;
  // Null nUserTags;
  String? nComments;
  String? nAssign;
  String? nLikedBy;
  int? age;
  // Null sparkMobile;
  // Null bankAccount;
  String? gender;
  // Null fatherMiddleName;
  // Null pendingInterest;
  // Null alternateEmail;
  // Null nomineeDetails;
  // Null address;
  // Null pennyDrop;
  String? martialStatus;
  // Null choiceMobile;
  // Null loanAccountNo;
  // Null crnNo;
  // Null fatherFirstName;
  String? ckcy;
  // Null pendingPayment;
  String? choiceKyc;
  // Null registeredDate;
  int? aadhaarNumber;
  // Null agentId;
  // Null emergencyContact;
  // Null panNumber;
  // Null referralCode;
  // Null cbilScore;
  String? kra;
  String? userStatus;
  // Null fatherLastName;
  String? accountType;
  // Null bankAccountNo;
  // Null documents;
  // Null ifscCode;
  // Null panDocument;
  // Null aadhaarDocument;
  // Null bankName;
  int? kycUpdate;
  int? offlineCustomer;
  int? setPin;
  int? isEmailVerified;
  int? pledgeSecurities;
  int? loanOpen;
  int? registeration;
  int? creditCheck;
  String? user;

  Customer(
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
        // this.firstName,
        // this.middleName,
        this.username,
        this.lastName,
        this.email,
        this.camsEmailId,
        this.phone,
        this.fullName,
        // this.nUserTags,
        this.nComments,
        this.nAssign,
        this.nLikedBy,
        this.age,
        // this.sparkMobile,
        // this.bankAccount,
        this.gender,
        // this.fatherMiddleName,
        // this.pendingInterest,
        // this.alternateEmail,
        // this.nomineeDetails,
        // this.address,
        // this.pennyDrop,
        this.martialStatus,
        // this.choiceMobile,
        // this.loanAccountNo,
        // this.crnNo,
        // this.fatherFirstName,
        this.ckcy,
        // this.pendingPayment,
        this.choiceKyc,
        // this.registeredDate,
        this.aadhaarNumber,
        // this.agentId,
        // this.emergencyContact,
        // this.panNumber,
        // this.referralCode,
        // this.cbilScore,
        this.kra,
        this.userStatus,
        // this.fatherLastName,
        this.accountType,
        // this.bankAccountNo,
        // this.documents,
        // this.ifscCode,
        // this.panDocument,
        // this.aadhaarDocument,
        // this.bankName,
        this.kycUpdate,
        this.offlineCustomer,
        this.setPin,
        this.isEmailVerified,
        this.pledgeSecurities,
        this.loanOpen,
        this.registeration,
        this.creditCheck,
        this.user});

  Customer.fromJson(Map<String, dynamic> json) {
    try {
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
      firstName = json['first_name'];
      // middleName = json['middle_name'];
      username = json['username'];
      lastName = json['last_name'];
      email = json['email'];
      camsEmailId = json['mycams_email_id'];
      phone = json['phone'];
      fullName = json['full_name'];
      // nUserTags = json['_user_tags'];
      nComments = json['_comments'];
      nAssign = json['_assign'];
      nLikedBy = json['_liked_by'];
      age = json['age'];
      // sparkMobile = json['spark_mobile'];
      // bankAccount = json['bank_account'];
      gender = json['gender'];
      // fatherMiddleName = json['father_middle_name'];
      // pendingInterest = json['pending_interest'];
      // alternateEmail = json['alternate_email'];
      // nomineeDetails = json['nominee_details'];
      // address = json['address'];
      // pennyDrop = json['penny_drop'];
      martialStatus = json['martial_status'];
      // choiceMobile = json['choice_mobile'];
      // loanAccountNo = json['loan_account_no'];
      // crnNo = json['crn_no'];
      // fatherFirstName = json['father_first_name'];
      ckcy = json['ckcy'];
      // pendingPayment = json['pending_payment'];
      choiceKyc = json['choice_kyc'];
      // registeredDate = json['registered_date'];
      aadhaarNumber = json['aadhaar_number'];
      // agentId = json['agent_id'];
      // emergencyContact = json['emergency_contact'];
      // panNumber = json['pan_number'];
      // referralCode = json['referral_code'];
      // cbilScore = json['cbil_score'];
      kra = json['kra'];
      userStatus = json['user_status'];
      // fatherLastName = json['father_last_name'];
      accountType = json['account_type'];
      // bankAccountNo = json['bank_account_no'];
      // documents = json['documents'];
      // ifscCode = json['ifsc_code'];
      // panDocument = json['pan_document'];
      // aadhaarDocument = json['aadhaar_document'];
      // bankName = json['bank_name'];
      kycUpdate = json['kyc_update'];
      offlineCustomer = json['offline_customer'];
      setPin = json['set_pin'];
      isEmailVerified = json['is_email_verified'];
      pledgeSecurities = json['pledge_securities'];
      loanOpen = json['loan_open'];
      registeration = json['registeration'];
      creditCheck = json['credit_check'];
      user = json['user'];
    } catch (e, s) {
      printLog(s.toString());
      printLog("customerError${e}");
    }
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
    data['first_name'] = this.firstName;
    // data['middle_name'] = this.middleName;
    data['username'] = this.username;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mycams_email_id'] = this.camsEmailId;
    data['phone'] = this.phone;
    data['full_name'] = this.fullName;
    // data['_user_tags'] = this.nUserTags;
    data['_comments'] = this.nComments;
    data['_assign'] = this.nAssign;
    data['_liked_by'] = this.nLikedBy;
    data['age'] = this.age;
    // data['spark_mobile'] = this.sparkMobile;
    // data['bank_account'] = this.bankAccount;
    data['gender'] = this.gender;
    // data['father_middle_name'] = this.fatherMiddleName;
    // data['pending_interest'] = this.pendingInterest;
    // data['alternate_email'] = this.alternateEmail;
    // data['nominee_details'] = this.nomineeDetails;
    // data['address'] = this.address;
    // data['penny_drop'] = this.pennyDrop;
    data['martial_status'] = this.martialStatus;
    // data['choice_mobile'] = this.choiceMobile;
    // data['loan_account_no'] = this.loanAccountNo;
    // data['crn_no'] = this.crnNo;
    // data['father_first_name'] = this.fatherFirstName;
    data['ckcy'] = this.ckcy;
    // data['pending_payment'] = this.pendingPayment;
    data['choice_kyc'] = this.choiceKyc;
    // data['registered_date'] = this.registeredDate;
    data['aadhaar_number'] = this.aadhaarNumber;
    // data['agent_id'] = this.agentId;
    // data['emergency_contact'] = this.emergencyContact;
    // data['pan_number'] = this.panNumber;
    // data['referral_code'] = this.referralCode;
    // data['cbil_score'] = this.cbilScore;
    data['kra'] = this.kra;
    data['user_status'] = this.userStatus;
    // data['father_last_name'] = this.fatherLastName;
    data['account_type'] = this.accountType;
    // data['bank_account_no'] = this.bankAccountNo;
    // data['documents'] = this.documents;
    // data['ifsc_code'] = this.ifscCode;
    // data['pan_document'] = this.panDocument;
    // data['aadhaar_document'] = this.aadhaarDocument;
    // data['bank_name'] = this.bankName;
    data['kyc_update'] = this.kycUpdate;
    data['offline_customer'] = this.offlineCustomer;
    data['set_pin'] = this.setPin;
    data['is_email_verified'] = this.isEmailVerified;
    data['pledge_securities'] = this.pledgeSecurities;
    data['loan_open'] = this.loanOpen;
    data['registeration'] = this.registeration;
    data['credit_check'] = this.creditCheck;
    data['user'] = this.user;
    return data;
  }
}

class UserKyc {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? user;
  String? panNo;
  int? consentGiven;
  String? kycStatus;
  String? kycType;
  String? dateOfBirth;
  String? email;
  String? constiType;
  String? accType;
  String? ckycNo;
  String? prefix;
  String? fname;
  String? mname;
  String? lname;
  String? fullname;
  String? maidenPrefix;
  String? maidenFname;
  String? maidenMname;
  String? maidenLname;
  String? maidenFullname;
  String? fatherspouseFlag;
  String? fatherPrefix;
  String? fatherFname;
  String? fatherMname;
  String? fatherLname;
  String? fatherFullname;
  String? motherPrefix;
  String? motherFname;
  String? motherMname;
  String? motherLname;
  String? motherFullname;
  String? gender;
  String? dob;
  String? pan;
  String? permLine1;
  String? permLine2;
  String? permLine3;
  String? permCity;
  String? permDist;
  String? permState;
  String? permCountry;
  String? permPin;
  String? permPoa;
  String? permCorresSameflag;
  String? corresLine1;
  String? corresLine2;
  String? corresLine3;
  String? corresCity;
  String? corresDist;
  String? corresState;
  String? corresCountry;
  String? corresPin;
  String? corresPoa;
  String? resiStdCode;
  String? resiTelNum;
  String? offStdCode;
  String? offTelNum;
  String? mobCode;
  String? mobNum;
  String? emailId;
  String? remarks;
  String? decDate;
  String? decPlace;
  String? kycDate;
  String? docSub;
  String? kycName;
  String? kycDesignation;
  String? kycBranch;
  String? kycEmpcode;
  String? orgName;
  String? orgCode;
  String? numIdentity;
  String? numRelated;
  String? numImages;
  String? address;
  int? isEdited;
  String? doctype;
  List<IdentityDetails>? identityDetails;
  List<RelatedPersonDetails>? relatedPersonDetails;
  List<ImageDetails>? imageDetails;
  List<BankAccount>? bankAccount;

  UserKyc(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.user,
        this.panNo,
        this.consentGiven,
        this.kycStatus,
        this.kycType,
        this.dateOfBirth,
        this.email,
        this.constiType,
        this.accType,
        this.ckycNo,
        this.prefix,
        this.fname,
        this.mname,
        this.lname,
        this.fullname,
        this.maidenPrefix,
        this.maidenFname,
        this.maidenMname,
        this.maidenLname,
        this.maidenFullname,
        this.fatherspouseFlag,
        this.fatherPrefix,
        this.fatherFname,
        this.fatherMname,
        this.fatherLname,
        this.fatherFullname,
        this.motherPrefix,
        this.motherFname,
        this.motherMname,
        this.motherLname,
        this.motherFullname,
        this.gender,
        this.dob,
        this.pan,
        this.permLine1,
        this.permLine2,
        this.permLine3,
        this.permCity,
        this.permDist,
        this.permState,
        this.permCountry,
        this.permPin,
        this.permPoa,
        this.permCorresSameflag,
        this.corresLine1,
        this.corresLine2,
        this.corresLine3,
        this.corresCity,
        this.corresDist,
        this.corresState,
        this.corresCountry,
        this.corresPin,
        this.corresPoa,
        this.resiStdCode,
        this.resiTelNum,
        this.offStdCode,
        this.offTelNum,
        this.mobCode,
        this.mobNum,
        this.emailId,
        this.remarks,
        this.decDate,
        this.decPlace,
        this.kycDate,
        this.docSub,
        this.kycName,
        this.kycDesignation,
        this.kycBranch,
        this.kycEmpcode,
        this.orgName,
        this.orgCode,
        this.numIdentity,
        this.numRelated,
        this.numImages,
        this.address,
        this.isEdited,
        this.doctype,
        this.identityDetails,
        this.relatedPersonDetails,
        this.imageDetails,
        this.bankAccount});

  UserKyc.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    user = json['user'];
    panNo = json['pan_no'];
    consentGiven = json['consent_given'];
    kycStatus = json['kyc_status'];
    kycType = json['kyc_type'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    constiType = json['consti_type'];
    accType = json['acc_type'];
    ckycNo = json['ckyc_no'];
    prefix = json['prefix'];
    fname = json['fname'];
    mname = json['mname'];
    lname = json['lname'];
    fullname = json['fullname'];
    maidenPrefix = json['maiden_prefix'];
    maidenFname = json['maiden_fname'];
    maidenMname = json['maiden_mname'];
    maidenLname = json['maiden_lname'];
    maidenFullname = json['maiden_fullname'];
    fatherspouseFlag = json['fatherspouse_flag'];
    fatherPrefix = json['father_prefix'];
    fatherFname = json['father_fname'];
    fatherMname = json['father_mname'];
    fatherLname = json['father_lname'];
    fatherFullname = json['father_fullname'];
    motherPrefix = json['mother_prefix'];
    motherFname = json['mother_fname'];
    motherMname = json['mother_mname'];
    motherLname = json['mother_lname'];
    motherFullname = json['mother_fullname'];
    gender = json['gender'];
    dob = json['dob'];
    pan = json['pan'];
    permLine1 = json['perm_line1'];
    permLine2 = json['perm_line2'];
    permLine3 = json['perm_line3'];
    permCity = json['perm_city'];
    permDist = json['perm_dist'];
    permState = json['perm_state'];
    permCountry = json['perm_country'];
    permPin = json['perm_pin'];
    permPoa = json['perm_poa'];
    permCorresSameflag = json['perm_corres_sameflag'];
    corresLine1 = json['corres_line1'];
    corresLine2 = json['corres_line2'];
    corresLine3 = json['corres_line3'];
    corresCity = json['corres_city'];
    corresDist = json['corres_dist'];
    corresState = json['corres_state'];
    corresCountry = json['corres_country'];
    corresPin = json['corres_pin'];
    corresPoa = json['corres_poa'];
    resiStdCode = json['resi_std_code'];
    resiTelNum = json['resi_tel_num'];
    offStdCode = json['off_std_code'];
    offTelNum = json['off_tel_num'];
    mobCode = json['mob_code'];
    mobNum = json['mob_num'];
    emailId = json['email_id'];
    remarks = json['remarks'];
    decDate = json['dec_date'];
    decPlace = json['dec_place'];
    kycDate = json['kyc_date'];
    docSub = json['doc_sub'];
    kycName = json['kyc_name'];
    kycDesignation = json['kyc_designation'];
    kycBranch = json['kyc_branch'];
    kycEmpcode = json['kyc_empcode'];
    orgName = json['org_name'];
    orgCode = json['org_code'];
    numIdentity = json['num_identity'];
    numRelated = json['num_related'];
    numImages = json['num_images'];
    address = json['address'];
    isEdited = json['is_edited'];
    doctype = json['doctype'];
    if (json['identity_details'] != null) {
      identityDetails = <IdentityDetails>[];
      json['identity_details'].forEach((v) {
        identityDetails!.add(new IdentityDetails.fromJson(v));
      });
    }
    if (json['related_person_details'] != null) {
      relatedPersonDetails = <RelatedPersonDetails>[];
      json['related_person_details'].forEach((v) {
        relatedPersonDetails!.add(new RelatedPersonDetails.fromJson(v));
      });
    }
    if (json['image_details'] != null) {
      imageDetails = <ImageDetails>[];
      json['image_details'].forEach((v) {
        imageDetails!.add(new ImageDetails.fromJson(v));
      });
    }
    if (json['bank_account'] != null) {
      bankAccount = <BankAccount>[];
      json['bank_account'].forEach((v) {
        bankAccount!.add(new BankAccount.fromJson(v));
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
    data['user'] = this.user;
    data['pan_no'] = this.panNo;
    data['consent_given'] = this.consentGiven;
    data['kyc_status'] = this.kycStatus;
    data['kyc_type'] = this.kycType;
    data['date_of_birth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['consti_type'] = this.constiType;
    data['acc_type'] = this.accType;
    data['ckyc_no'] = this.ckycNo;
    data['prefix'] = this.prefix;
    data['fname'] = this.fname;
    data['mname'] = this.mname;
    data['lname'] = this.lname;
    data['fullname'] = this.fullname;
    data['maiden_prefix'] = this.maidenPrefix;
    data['maiden_fname'] = this.maidenFname;
    data['maiden_mname'] = this.maidenMname;
    data['maiden_lname'] = this.maidenLname;
    data['maiden_fullname'] = this.maidenFullname;
    data['fatherspouse_flag'] = this.fatherspouseFlag;
    data['father_prefix'] = this.fatherPrefix;
    data['father_fname'] = this.fatherFname;
    data['father_mname'] = this.fatherMname;
    data['father_lname'] = this.fatherLname;
    data['father_fullname'] = this.fatherFullname;
    data['mother_prefix'] = this.motherPrefix;
    data['mother_fname'] = this.motherFname;
    data['mother_mname'] = this.motherMname;
    data['mother_lname'] = this.motherLname;
    data['mother_fullname'] = this.motherFullname;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['pan'] = this.pan;
    data['perm_line1'] = this.permLine1;
    data['perm_line2'] = this.permLine2;
    data['perm_line3'] = this.permLine3;
    data['perm_city'] = this.permCity;
    data['perm_dist'] = this.permDist;
    data['perm_state'] = this.permState;
    data['perm_country'] = this.permCountry;
    data['perm_pin'] = this.permPin;
    data['perm_poa'] = this.permPoa;
    data['perm_corres_sameflag'] = this.permCorresSameflag;
    data['corres_line1'] = this.corresLine1;
    data['corres_line2'] = this.corresLine2;
    data['corres_line3'] = this.corresLine3;
    data['corres_city'] = this.corresCity;
    data['corres_dist'] = this.corresDist;
    data['corres_state'] = this.corresState;
    data['corres_country'] = this.corresCountry;
    data['corres_pin'] = this.corresPin;
    data['corres_poa'] = this.corresPoa;
    data['resi_std_code'] = this.resiStdCode;
    data['resi_tel_num'] = this.resiTelNum;
    data['off_std_code'] = this.offStdCode;
    data['off_tel_num'] = this.offTelNum;
    data['mob_code'] = this.mobCode;
    data['mob_num'] = this.mobNum;
    data['email_id'] = this.emailId;
    data['remarks'] = this.remarks;
    data['dec_date'] = this.decDate;
    data['dec_place'] = this.decPlace;
    data['kyc_date'] = this.kycDate;
    data['doc_sub'] = this.docSub;
    data['kyc_name'] = this.kycName;
    data['kyc_designation'] = this.kycDesignation;
    data['kyc_branch'] = this.kycBranch;
    data['kyc_empcode'] = this.kycEmpcode;
    data['org_name'] = this.orgName;
    data['org_code'] = this.orgCode;
    data['num_identity'] = this.numIdentity;
    data['num_related'] = this.numRelated;
    data['num_images'] = this.numImages;
    data['address'] = this.address;
    data['is_edited'] = this.isEdited;
    data['doctype'] = this.doctype;
    if (this.identityDetails != null) {
      data['identity_details'] =
          this.identityDetails!.map((v) => v.toJson()).toList();
    }
    if (this.relatedPersonDetails != null) {
      data['related_person_details'] =
          this.relatedPersonDetails!.map((v) => v.toJson()).toList();
    }
    if (this.imageDetails != null) {
      data['image_details'] =
          this.imageDetails!.map((v) => v.toJson()).toList();
    }
    if (this.bankAccount != null) {
      data['bank_account'] = this.bankAccount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IdentityDetails {
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
  String? sequenceNo;
  String? identType;
  String? identCategory;
  String? identNum;
  String? idverStatus;
  String? doctype;

  IdentityDetails(
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
        this.sequenceNo,
        this.identType,
        this.identCategory,
        this.identNum,
        this.idverStatus,
        this.doctype});

  IdentityDetails.fromJson(Map<String, dynamic> json) {
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
    sequenceNo = json['sequence_no'];
    identType = json['ident_type'];
    identCategory = json['ident_category'];
    identNum = json['ident_num'];
    idverStatus = json['idver_status'];
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
    data['sequence_no'] = this.sequenceNo;
    data['ident_type'] = this.identType;
    data['ident_category'] = this.identCategory;
    data['ident_num'] = this.identNum;
    data['idver_status'] = this.idverStatus;
    data['doctype'] = this.doctype;
    return data;
  }
}

class RelatedPersonDetails {
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
  String? sequenceNo;
  String? relType;
  String? addDelFlag;
  String? ckycNo;
  String? prefix;
  String? fname;
  String? mname;
  String? lname;
  String? maidenPrefix;
  String? maidenFname;
  String? maidenMname;
  String? maidenLname;
  String? fatherspouseFlag;
  String? fatherPrefix;
  String? fatherFname;
  String? fatherMname;
  String? fatherLname;
  String? motherPrefix;
  String? motherFname;
  String? motherMname;
  String? motherLname;
  String? dob;
  String? gender;
  String? pan;
  String? permPoiType;
  String? sameAsPermFlag;
  String? corresAddLine1;
  String? corresAddLine2;
  String? corresAddLine3;
  String? corresAddCity;
  String? corresAddDist;
  String? corresAddState;
  String? corresAddCountry;
  String? corresAddPin;
  String? corresPoiType;
  String? resiStdCode;
  String? resiTelNum;
  String? offStdCode;
  String? offTelNum;
  String? mobCode;
  String? mobNum;
  String? email;
  String? remarks;
  String? photoType;
  String? photo;
  String? permPoiImageType;
  String? permPoi;
  String? offlineVerificationAadhaar;
  String? decDate;
  String? decPlace;
  String? kycDate;
  String? docSub;
  String? kycName;
  String? kycDesignation;
  String? kycBranch;
  String? kycEmpcode;
  String? orgName;
  String? orgCode;
  String? doctype;
  String? passport;

  RelatedPersonDetails(
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
        this.sequenceNo,
        this.relType,
        this.addDelFlag,
        this.ckycNo,
        this.prefix,
        this.fname,
        this.mname,
        this.lname,
        this.maidenPrefix,
        this.maidenFname,
        this.maidenMname,
        this.maidenLname,
        this.fatherspouseFlag,
        this.fatherPrefix,
        this.fatherFname,
        this.fatherMname,
        this.fatherLname,
        this.motherPrefix,
        this.motherFname,
        this.motherMname,
        this.motherLname,
        this.dob,
        this.gender,
        this.pan,
        this.permPoiType,
        this.sameAsPermFlag,
        this.corresAddLine1,
        this.corresAddLine2,
        this.corresAddLine3,
        this.corresAddCity,
        this.corresAddDist,
        this.corresAddState,
        this.corresAddCountry,
        this.corresAddPin,
        this.corresPoiType,
        this.resiStdCode,
        this.resiTelNum,
        this.offStdCode,
        this.offTelNum,
        this.mobCode,
        this.mobNum,
        this.email,
        this.remarks,
        this.photoType,
        this.photo,
        this.permPoiImageType,
        this.permPoi,
        this.offlineVerificationAadhaar,
        this.decDate,
        this.decPlace,
        this.kycDate,
        this.docSub,
        this.kycName,
        this.kycDesignation,
        this.kycBranch,
        this.kycEmpcode,
        this.orgName,
        this.orgCode,
        this.doctype,
        this.passport});

  RelatedPersonDetails.fromJson(Map<String, dynamic> json) {
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
    sequenceNo = json['sequence_no'];
    relType = json['rel_type'];
    addDelFlag = json['add_del_flag'];
    ckycNo = json['ckyc_no'];
    prefix = json['prefix'];
    fname = json['fname'];
    mname = json['mname'];
    lname = json['lname'];
    maidenPrefix = json['maiden_prefix'];
    maidenFname = json['maiden_fname'];
    maidenMname = json['maiden_mname'];
    maidenLname = json['maiden_lname'];
    fatherspouseFlag = json['fatherspouse_flag'];
    fatherPrefix = json['father_prefix'];
    fatherFname = json['father_fname'];
    fatherMname = json['father_mname'];
    fatherLname = json['father_lname'];
    motherPrefix = json['mother_prefix'];
    motherFname = json['mother_fname'];
    motherMname = json['mother_mname'];
    motherLname = json['mother_lname'];
    dob = json['dob'];
    gender = json['gender'];
    pan = json['pan'];
    permPoiType = json['perm_poi_type'];
    sameAsPermFlag = json['same_as_perm_flag'];
    corresAddLine1 = json['corres_add_line1'];
    corresAddLine2 = json['corres_add_line2'];
    corresAddLine3 = json['corres_add_line3'];
    corresAddCity = json['corres_add_city'];
    corresAddDist = json['corres_add_dist'];
    corresAddState = json['corres_add_state'];
    corresAddCountry = json['corres_add_country'];
    corresAddPin = json['corres_add_pin'];
    corresPoiType = json['corres_poi_type'];
    resiStdCode = json['resi_std_code'];
    resiTelNum = json['resi_tel_num'];
    offStdCode = json['off_std_code'];
    offTelNum = json['off_tel_num'];
    mobCode = json['mob_code'];
    mobNum = json['mob_num'];
    email = json['email'];
    remarks = json['remarks'];
    photoType = json['photo_type'];
    photo = json['photo'];
    permPoiImageType = json['perm_poi_image_type'];
    permPoi = json['perm_poi'];
    offlineVerificationAadhaar = json['offline_verification_aadhaar'];
    decDate = json['dec_date'];
    decPlace = json['dec_place'];
    kycDate = json['kyc_date'];
    docSub = json['doc_sub'];
    kycName = json['kyc_name'];
    kycDesignation = json['kyc_designation'];
    kycBranch = json['kyc_branch'];
    kycEmpcode = json['kyc_empcode'];
    orgName = json['org_name'];
    orgCode = json['org_code'];
    doctype = json['doctype'];
    passport = json['passport'];
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
    data['sequence_no'] = this.sequenceNo;
    data['rel_type'] = this.relType;
    data['add_del_flag'] = this.addDelFlag;
    data['ckyc_no'] = this.ckycNo;
    data['prefix'] = this.prefix;
    data['fname'] = this.fname;
    data['mname'] = this.mname;
    data['lname'] = this.lname;
    data['maiden_prefix'] = this.maidenPrefix;
    data['maiden_fname'] = this.maidenFname;
    data['maiden_mname'] = this.maidenMname;
    data['maiden_lname'] = this.maidenLname;
    data['fatherspouse_flag'] = this.fatherspouseFlag;
    data['father_prefix'] = this.fatherPrefix;
    data['father_fname'] = this.fatherFname;
    data['father_mname'] = this.fatherMname;
    data['father_lname'] = this.fatherLname;
    data['mother_prefix'] = this.motherPrefix;
    data['mother_fname'] = this.motherFname;
    data['mother_mname'] = this.motherMname;
    data['mother_lname'] = this.motherLname;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['pan'] = this.pan;
    data['perm_poi_type'] = this.permPoiType;
    data['same_as_perm_flag'] = this.sameAsPermFlag;
    data['corres_add_line1'] = this.corresAddLine1;
    data['corres_add_line2'] = this.corresAddLine2;
    data['corres_add_line3'] = this.corresAddLine3;
    data['corres_add_city'] = this.corresAddCity;
    data['corres_add_dist'] = this.corresAddDist;
    data['corres_add_state'] = this.corresAddState;
    data['corres_add_country'] = this.corresAddCountry;
    data['corres_add_pin'] = this.corresAddPin;
    data['corres_poi_type'] = this.corresPoiType;
    data['resi_std_code'] = this.resiStdCode;
    data['resi_tel_num'] = this.resiTelNum;
    data['off_std_code'] = this.offStdCode;
    data['off_tel_num'] = this.offTelNum;
    data['mob_code'] = this.mobCode;
    data['mob_num'] = this.mobNum;
    data['email'] = this.email;
    data['remarks'] = this.remarks;
    data['photo_type'] = this.photoType;
    data['photo'] = this.photo;
    data['perm_poi_image_type'] = this.permPoiImageType;
    data['perm_poi'] = this.permPoi;
    data['offline_verification_aadhaar'] = this.offlineVerificationAadhaar;
    data['dec_date'] = this.decDate;
    data['dec_place'] = this.decPlace;
    data['kyc_date'] = this.kycDate;
    data['doc_sub'] = this.docSub;
    data['kyc_name'] = this.kycName;
    data['kyc_designation'] = this.kycDesignation;
    data['kyc_branch'] = this.kycBranch;
    data['kyc_empcode'] = this.kycEmpcode;
    data['org_name'] = this.orgName;
    data['org_code'] = this.orgCode;
    data['doctype'] = this.doctype;
    data['passport'] = this.passport;
    return data;
  }
}

class ImageDetails {
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
  String? sequenceNo;
  String? imageType;
  String? imageCode;
  String? imageName;
  String? globalFlag;
  String? branchCode;
  String? image;
  String? doctype;

  ImageDetails(
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
        this.sequenceNo,
        this.imageType,
        this.imageCode,
        this.imageName,
        this.globalFlag,
        this.branchCode,
        this.image,
        this.doctype});

  ImageDetails.fromJson(Map<String, dynamic> json) {
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
    sequenceNo = json['sequence_no'];
    imageType = json['image_type'];
    imageCode = json['image_code'];
    imageName = json['image_name'];
    globalFlag = json['global_flag'];
    branchCode = json['branch_code'];
    image = json['image'];
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
    data['sequence_no'] = this.sequenceNo;
    data['image_type'] = this.imageType;
    data['image_code'] = this.imageCode;
    data['image_name'] = this.imageName;
    data['global_flag'] = this.globalFlag;
    data['branch_code'] = this.branchCode;
    data['image'] = this.image;
    data['doctype'] = this.doctype;
    return data;
  }
}

class BankAccount {
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
  String? bankStatus;
  String? bank;
  String? branch;
  String? accountNumber;
  String? ifsc;
  String? city;
  int? isDefault;
  String? razorpayFundAccountId;
  String? accountHolderName;
  String? personalizedCheque;
  String? accountType;
  String? razorpayFundAccountValidationId;
  int? notificationSent;
  String? doctype;
  String? bankCode;
  String? state;
  String? bankAddress;
  String? contact;
  String? micr;
  String? bankMode;
  String? bankZipCode;
  String? district;

  BankAccount({this.name, this.owner, this.creation, this.modified, this.modifiedBy, this.parent, this.parentfield, this.parenttype, this.idx, this.docstatus, this.bankStatus, this.bank, this.branch, this.accountNumber, this.ifsc, this.city, this.isDefault, this.razorpayFundAccountId, this.accountHolderName, this.personalizedCheque, this.accountType, this.razorpayFundAccountValidationId, this.notificationSent, this.doctype, this.bankCode, this.state, this.bankAddress, this.contact, this.micr, this.bankMode, this.bankZipCode, this.district});

  BankAccount.fromJson(Map<String, dynamic> json) {
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
    bankStatus = json['bank_status'];
    bank = json['bank'];
    branch = json['branch'];
    accountNumber = json['account_number'];
    ifsc = json['ifsc'];
    city = json['city'];
    isDefault = json['is_default'];
    razorpayFundAccountId = json['razorpay_fund_account_id'];
    accountHolderName = json['account_holder_name'];
    personalizedCheque = json['personalized_cheque'];
    accountType = json['account_type'];
    razorpayFundAccountValidationId = json['razorpay_fund_account_validation_id'];
    notificationSent = json['notification_sent'];
    doctype = json['doctype'];
    bankCode = json['bank_code'];
    state = json['state'];
    bankAddress = json['bank_address'];
    contact = json['contact'];
    micr = json['micr'];
    bankMode = json['bank_mode'];
    bankZipCode = json['bank_zip_code'];
    district = json['district'];
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
    data['bank_status'] = this.bankStatus;
    data['bank'] = this.bank;
    data['branch'] = this.branch;
    data['account_number'] = this.accountNumber;
    data['ifsc'] = this.ifsc;
    data['city'] = this.city;
    data['is_default'] = this.isDefault;
    data['razorpay_fund_account_id'] = this.razorpayFundAccountId;
    data['account_holder_name'] = this.accountHolderName;
    data['personalized_cheque'] = this.personalizedCheque;
    data['account_type'] = this.accountType;
    data['razorpay_fund_account_validation_id'] = this.razorpayFundAccountValidationId;
    data['notification_sent'] = this.notificationSent;
    data['doctype'] = this.doctype;
    data['bank_code'] = this.bankCode;
    data['state'] = this.state;
    data['bank_address'] = this.bankAddress;
    data['contact'] = this.contact;
    data['micr'] = this.micr;
    data['bank_mode'] = this.bankMode;
    data['bank_zip_code'] = this.bankZipCode;
    data['district'] = this.district;
    return data;
  }
}

class Errors {
  String? mobile;
  String? firebaseToken;
  String? otp;
  String? firstName;
  String? pin;
  String? message;

  Errors({this.mobile,this.firebaseToken,this.otp,this.firstName,this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    firebaseToken = json['firebase_token'];
    otp = json['otp'];
    firstName = json['first_name'];
    pin = json['pin'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['firebase_token'] = this.firebaseToken;
    data['otp'] = this.otp;
    data['first_name'] = this.firstName;
    data['pin'] = this.pin;
    data['message'] = this.message;
    return data;
  }
}

class PendingEsigns {
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
  double? total;
  String? pledgorBoid;
  // Null prfNumber;
  String? pledgeeBoid;
  String? expiryDate;
  String? status;
  // Null nUserTags;
  String? nComments;
  // Null nAssign;
  String? nLikedBy;
  String? workflowState;
  double? totalCollateralValue;
  double? overdraftLimit;
  String? customer;
  double? allowableLtv;
  String? loan;
  double? drawingPower;
  String? lender;
  String? customerEsignedDocument;
  String? lenderEsignedDocument;
  double? pledgedTotalCollateralValue;
  String? pledgeStatus;
  List<CommonItems>? items;


  PendingEsigns({this.name,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.owner,
    this.docstatus,
    // this.parent,
    // this.parentfield,
    // this.parenttype,
    this.idx,
    this.total,
    this.pledgorBoid,
    // this.prfNumber,
    this.pledgeeBoid,
    this.expiryDate,
    this.status,
    // this.nUserTags,
    this.nComments,
    // this.nAssign,
    this.nLikedBy,
    this.workflowState,
    this.totalCollateralValue,
    this.overdraftLimit,
    this.customer,
    this.allowableLtv,
    this.loan,
    this.drawingPower,
    this.lender,
    this.customerEsignedDocument,
    this.lenderEsignedDocument,
    this.pledgedTotalCollateralValue,
    this.pledgeStatus,
    this.items});

  PendingEsigns.fromJson(Map<dynamic, dynamic> json) {
    try {
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
      total = json['total'];
      pledgorBoid = json['pledgor_boid'];
      // prfNumber = json['prf_number'];
      pledgeeBoid = json['pledgee_boid'];
      expiryDate = json['expiry_date'];
      status = json['status'];
      // nUserTags = json['_user_tags'];
      nComments = json['_comments'];
      // nAssign = json['_assign'];
      nLikedBy = json['_liked_by'];
      workflowState = json['workflow_state'];
      totalCollateralValue = json['total_collateral_value'];
      overdraftLimit = json['overdraft_limit'];
      customer = json['customer'];
      allowableLtv = json['allowable_ltv'];
      loan = json['loan'];
      drawingPower = json['drawing_power'];
      lender = json['lender'];
      customerEsignedDocument = json['customer_esigned_document'];
      lenderEsignedDocument = json['lender_esigned_document'];
      pledgedTotalCollateralValue = json['pledged_total_collateral_value'];
      pledgeStatus = json['pledge_status'];
      if (json['items'] != null) {
        items = <CommonItems>[];
        json['items'].forEach((v) {
          items!.add(new CommonItems.fromJson(v));
        });
      }
    } catch (e, s) {
      printLog(s.toString());
    }

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
      data['total'] = this.total;
      data['pledgor_boid'] = this.pledgorBoid;
      // data['prf_number'] = this.prfNumber;
      data['pledgee_boid'] = this.pledgeeBoid;
      data['expiry_date'] = this.expiryDate;
      data['status'] = this.status;
      // data['_user_tags'] = this.nUserTags;
      data['_comments'] = this.nComments;
      // data['_assign'] = this.nAssign;
      data['_liked_by'] = this.nLikedBy;
      data['workflow_state'] = this.workflowState;
      data['total_collateral_value'] = this.totalCollateralValue;
      data['overdraft_limit'] = this.overdraftLimit;
      data['customer'] = this.customer;
      data['allowable_ltv'] = this.allowableLtv;
      data['loan'] = this.loan;
      data['drawing_power'] = this.drawingPower;
      data['lender'] = this.lender;
      data['customer_esigned_document'] = this.customerEsignedDocument;
      data['lender_esigned_document'] = this.lenderEsignedDocument;
      data['pledged_total_collateral_value'] = this.pledgedTotalCollateralValue;
      data['pledge_status'] = this.pledgeStatus;
      if (this.items != null) {
        data['items'] = this.items!.map((v) => v.toJson()).toList();
      }
      return data;
    }
  }


