// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/data/models/bank_account_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/identity_details_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/image_details_response_details.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/related_personal_details_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/bank_account_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/identity_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/image_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/related_personal_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/user_kyc_doc_response_entity.dart';

class UserKycDocResponseModel {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? user;
  String? panNo;
  String? razorpayContactId;
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
  String? genderFull;
  String? dob;
  String? pan;
  String? permLine1;
  String? permLine2;
  String? permLine3;
  String? permCity;
  String? permDist;
  String? permState;
  String? permStateName;
  String? permCountry;
  String? permCountryName;
  String? permPin;
  String? permPoa;
  String? permCorresSameflag;
  String? corresLine1;
  String? corresLine2;
  String? corresLine3;
  String? corresCity;
  String? corresDist;
  String? corresState;
  String? corresStateName;
  String? corresCountry;
  String? corresCountryName;
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
  List<IdentityDetailsResponseModel>? identityDetails;
  List<RelatedPersonalDetailsResponseModel>? relatedPersonDetails;
  List<ImageDetailsResponseModel>? imageDetails;
  List<BankAccountDetailsResponseModel>? bankAccount;
  
  UserKycDocResponseModel({
    this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.user,
    this.panNo,
    this.razorpayContactId,
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
    this.genderFull,
    this.dob,
    this.pan,
    this.permLine1,
    this.permLine2,
    this.permLine3,
    this.permCity,
    this.permDist,
    this.permState,
    this.permStateName,
    this.permCountry,
    this.permCountryName,
    this.permPin,
    this.permPoa,
    this.permCorresSameflag,
    this.corresLine1,
    this.corresLine2,
    this.corresLine3,
    this.corresCity,
    this.corresDist,
    this.corresState,
    this.corresStateName,
    this.corresCountry,
    this.corresCountryName,
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
    this.bankAccount,
  });

 
  UserKycDocResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    user = json['user'];
    panNo = json['pan_no'];
    razorpayContactId = json['razorpay_contact_id'];
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
    genderFull = json['gender_full'];
    dob = json['dob'];
    pan = json['pan'];
    permLine1 = json['perm_line1'];
    permLine2 = json['perm_line2'];
    permLine3 = json['perm_line3'];
    permCity = json['perm_city'];
    permDist = json['perm_dist'];
    permState = json['perm_state'];
    permStateName = json['perm_state_name'];
    permCountry = json['perm_country'];
    permCountryName = json['perm_country_name'];
    permPin = json['perm_pin'];
    permPoa = json['perm_poa'];
    permCorresSameflag = json['perm_corres_sameflag'];
    corresLine1 = json['corres_line1'];
    corresLine2 = json['corres_line2'];
    corresLine3 = json['corres_line3'];
    corresCity = json['corres_city'];
    corresDist = json['corres_dist'];
    corresState = json['corres_state'];
    corresStateName = json['corres_state_name'];
    corresCountry = json['corres_country'];
    corresCountryName = json['corres_country_name'];
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
      identityDetails = <IdentityDetailsResponseModel>[];
      json['identity_details'].forEach((v) {
        identityDetails!.add(new IdentityDetailsResponseModel.fromJson(v));
      });
    }
    if (json['related_person_details'] != null) {
      relatedPersonDetails = <RelatedPersonalDetailsResponseModel>[];
      json['related_person_details'].forEach((v) {
        relatedPersonDetails!.add(new RelatedPersonalDetailsResponseModel.fromJson(v));
      });
    }
    if (json['image_details'] != null) {
      imageDetails = <ImageDetailsResponseModel>[];
      json['image_details'].forEach((v) {
        imageDetails!.add(new ImageDetailsResponseModel.fromJson(v));
      });
    }
    if (json['bank_account'] != null) {
      bankAccount = <BankAccountDetailsResponseModel>[];
      json['bank_account'].forEach((v) {
        bankAccount!.add(new BankAccountDetailsResponseModel.fromJson(v));
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
    data['razorpay_contact_id'] = this.razorpayContactId;
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
    data['gender_full'] = this.genderFull;
    data['dob'] = this.dob;
    data['pan'] = this.pan;
    data['perm_line1'] = this.permLine1;
    data['perm_line2'] = this.permLine2;
    data['perm_line3'] = this.permLine3;
    data['perm_city'] = this.permCity;
    data['perm_dist'] = this.permDist;
    data['perm_state'] = this.permState;
    data['perm_state_name'] = this.permStateName;
    data['perm_country'] = this.permCountry;
    data['perm_country_name'] = this.permCountryName;
    data['perm_pin'] = this.permPin;
    data['perm_poa'] = this.permPoa;
    data['perm_corres_sameflag'] = this.permCorresSameflag;
    data['corres_line1'] = this.corresLine1;
    data['corres_line2'] = this.corresLine2;
    data['corres_line3'] = this.corresLine3;
    data['corres_city'] = this.corresCity;
    data['corres_dist'] = this.corresDist;
    data['corres_state'] = this.corresState;
    data['corres_state'] = this.corresStateName;
    data['corres_country_name'] = this.corresCountry;
    data['corres_country_name'] = this.corresCountryName;
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

  UserKycDocResponseEntity toEntity() =>
  UserKycDocResponseEntity(
      name: name,
      owner: owner,
      creation: creation,
      modified: modified,
      modifiedBy: modifiedBy,
      idx: idx,
      docstatus: docstatus,
      user: user,
      panNo: panNo,
      razorpayContactId: razorpayContactId,
      consentGiven: consentGiven,
      kycStatus: kycStatus,
      kycType: kycType,
      dateOfBirth: dateOfBirth,
      email: email,
      constiType: constiType,
      accType: accType,
      ckycNo: ckycNo,
      prefix: prefix,
      fname: fname,
      mname: mname,
      lname: lname,
      fullname: fullname,
      maidenPrefix: maidenPrefix,
      maidenFname: maidenFname,
      maidenMname: maidenMname,
      maidenLname: maidenLname,
      maidenFullname: maidenFullname,
      fatherspouseFlag: fatherspouseFlag,
      fatherPrefix: fatherPrefix,
      fatherFname: fatherFname,
      fatherMname: fatherMname,
      fatherLname: fatherLname,
      fatherFullname: fatherFullname,
      motherPrefix: motherPrefix,
      motherFname: motherFname,
      motherMname: motherMname,
      motherLname: motherLname,
      motherFullname: motherFullname,
      gender: gender,
      genderFull: genderFull,
      dob: dob,
      pan: pan,
      permLine1: permLine1,
      permLine2: permLine2,
      permLine3: permLine3,
      permCity: permCity,
      permDist: permDist,
      permState: permState,
      permStateName: permStateName,
      permCountry: permCountry,
      permCountryName: permCountryName,
      permPin: permPin,
      permPoa: permPoa,
      permCorresSameflag: permCorresSameflag,
      corresLine1: corresLine1,
      corresLine2: corresLine2,
      corresLine3: corresLine3,
      corresCity: corresCity,
      corresDist: corresDist,
      corresState: corresState,
      corresStateName: corresStateName,
      corresCountry: corresCountry,
      corresCountryName: corresCountryName,
      corresPin: corresPin,
      corresPoa: corresPoa,
      resiStdCode: resiStdCode,
      resiTelNum: resiTelNum,
      offStdCode: offStdCode,
      offTelNum: offTelNum,
      mobCode: mobCode,
      mobNum: mobNum,
      emailId: emailId,
      remarks: remarks,
      decDate: decDate,
      decPlace: decPlace,
      kycDate: kycDate,
      docSub: docSub,
      kycName: kycName,
      kycDesignation: kycDesignation,
      kycBranch: kycBranch,
      kycEmpcode: kycEmpcode,
      orgName: orgName,
      orgCode: orgCode,
      numIdentity: numIdentity,
      numRelated: numRelated,
      numImages: numImages,
      address: address,
      isEdited: isEdited,
      doctype: doctype,
      identityDetails: identityDetails?.map((x) => x.toEntity()).toList(),
      relatedPersonDetails: relatedPersonDetails?.map((x) => x.toEntity()).toList(),
      imageDetails: imageDetails?.map((x) => x.toEntity()).toList(),
      bankAccount: bankAccount?.map((x) => x.toEntity()).toList(),
  
  );

  factory UserKycDocResponseModel.fromEntity(UserKycDocResponseEntity userKycDocResponseEntity) {
    return UserKycDocResponseModel(
      name: userKycDocResponseEntity.name != null ? userKycDocResponseEntity.name as String : null,
      owner: userKycDocResponseEntity.owner != null ? userKycDocResponseEntity.owner as String : null,
      creation: userKycDocResponseEntity.creation != null ? userKycDocResponseEntity.creation as String : null,
      modified: userKycDocResponseEntity.modified != null ? userKycDocResponseEntity.modified as String : null,
      modifiedBy: userKycDocResponseEntity.modifiedBy != null ? userKycDocResponseEntity.modifiedBy as String : null,
      idx: userKycDocResponseEntity.idx != null ? userKycDocResponseEntity.idx as int : null,
      docstatus: userKycDocResponseEntity.docstatus != null ? userKycDocResponseEntity.docstatus as int : null,
      user: userKycDocResponseEntity.user != null ? userKycDocResponseEntity.user as String : null,
      panNo: userKycDocResponseEntity.panNo != null ? userKycDocResponseEntity.panNo as String : null,
      razorpayContactId: userKycDocResponseEntity.razorpayContactId != null ? userKycDocResponseEntity.razorpayContactId as String : null,
      consentGiven: userKycDocResponseEntity.consentGiven != null ? userKycDocResponseEntity.consentGiven as int : null,
      kycStatus: userKycDocResponseEntity.kycStatus != null ? userKycDocResponseEntity.kycStatus as String : null,
      kycType: userKycDocResponseEntity.kycType != null ? userKycDocResponseEntity.kycType as String : null,
      dateOfBirth: userKycDocResponseEntity.dateOfBirth != null ? userKycDocResponseEntity.dateOfBirth as String : null,
      email: userKycDocResponseEntity.email != null ? userKycDocResponseEntity.email as String : null,
      constiType: userKycDocResponseEntity.constiType != null ? userKycDocResponseEntity.constiType as String : null,
      accType: userKycDocResponseEntity.accType != null ? userKycDocResponseEntity.accType as String : null,
      ckycNo: userKycDocResponseEntity.ckycNo != null ? userKycDocResponseEntity.ckycNo as String : null,
      prefix: userKycDocResponseEntity.prefix != null ? userKycDocResponseEntity.prefix as String : null,
      fname: userKycDocResponseEntity.fname != null ? userKycDocResponseEntity.fname as String : null,
      mname: userKycDocResponseEntity.mname != null ? userKycDocResponseEntity.mname as String : null,
      lname: userKycDocResponseEntity.lname != null ? userKycDocResponseEntity.lname as String : null,
      fullname: userKycDocResponseEntity.fullname != null ? userKycDocResponseEntity.fullname as String : null,
      maidenPrefix: userKycDocResponseEntity.maidenPrefix != null ? userKycDocResponseEntity.maidenPrefix as String : null,
      maidenFname: userKycDocResponseEntity.maidenFname != null ? userKycDocResponseEntity.maidenFname as String : null,
      maidenMname: userKycDocResponseEntity.maidenMname != null ? userKycDocResponseEntity.maidenMname as String : null,
      maidenLname: userKycDocResponseEntity.maidenLname != null ? userKycDocResponseEntity.maidenLname as String : null,
      maidenFullname: userKycDocResponseEntity.maidenFullname != null ? userKycDocResponseEntity.maidenFullname as String : null,
      fatherspouseFlag: userKycDocResponseEntity.fatherspouseFlag != null ? userKycDocResponseEntity.fatherspouseFlag as String : null,
      fatherPrefix: userKycDocResponseEntity.fatherPrefix != null ? userKycDocResponseEntity.fatherPrefix as String : null,
      fatherFname: userKycDocResponseEntity.fatherFname != null ? userKycDocResponseEntity.fatherFname as String : null,
      fatherMname: userKycDocResponseEntity.fatherMname != null ? userKycDocResponseEntity.fatherMname as String : null,
      fatherLname: userKycDocResponseEntity.fatherLname != null ? userKycDocResponseEntity.fatherLname as String : null,
      fatherFullname: userKycDocResponseEntity.fatherFullname != null ? userKycDocResponseEntity.fatherFullname as String : null,
      motherPrefix: userKycDocResponseEntity.motherPrefix != null ? userKycDocResponseEntity.motherPrefix as String : null,
      motherFname: userKycDocResponseEntity.motherFname != null ? userKycDocResponseEntity.motherFname as String : null,
      motherMname: userKycDocResponseEntity.motherMname != null ? userKycDocResponseEntity.motherMname as String : null,
      motherLname: userKycDocResponseEntity.motherLname != null ? userKycDocResponseEntity.motherLname as String : null,
      motherFullname: userKycDocResponseEntity.motherFullname != null ? userKycDocResponseEntity.motherFullname as String : null,
      gender: userKycDocResponseEntity.gender != null ? userKycDocResponseEntity.gender as String : null,
      genderFull: userKycDocResponseEntity.genderFull != null ? userKycDocResponseEntity.genderFull as String : null,
      dob: userKycDocResponseEntity.dob != null ? userKycDocResponseEntity.dob as String : null,
      pan: userKycDocResponseEntity.pan != null ? userKycDocResponseEntity.pan as String : null,
      permLine1: userKycDocResponseEntity.permLine1 != null ? userKycDocResponseEntity.permLine1 as String : null,
      permLine2: userKycDocResponseEntity.permLine2 != null ? userKycDocResponseEntity.permLine2 as String : null,
      permLine3: userKycDocResponseEntity.permLine3 != null ? userKycDocResponseEntity.permLine3 as String : null,
      permCity: userKycDocResponseEntity.permCity != null ? userKycDocResponseEntity.permCity as String : null,
      permDist: userKycDocResponseEntity.permDist != null ? userKycDocResponseEntity.permDist as String : null,
      permState: userKycDocResponseEntity.permState != null ? userKycDocResponseEntity.permState as String : null,
      permStateName: userKycDocResponseEntity.permStateName != null ? userKycDocResponseEntity.permStateName as String : null,
      permCountry: userKycDocResponseEntity.permCountry != null ? userKycDocResponseEntity.permCountry as String : null,
      permCountryName: userKycDocResponseEntity.permCountryName != null ? userKycDocResponseEntity.permCountryName as String : null,
      permPin: userKycDocResponseEntity.permPin != null ? userKycDocResponseEntity.permPin as String : null,
      permPoa: userKycDocResponseEntity.permPoa != null ? userKycDocResponseEntity.permPoa as String : null,
      permCorresSameflag: userKycDocResponseEntity.permCorresSameflag != null ? userKycDocResponseEntity.permCorresSameflag as String : null,
      corresLine1: userKycDocResponseEntity.corresLine1 != null ? userKycDocResponseEntity.corresLine1 as String : null,
      corresLine2: userKycDocResponseEntity.corresLine2 != null ? userKycDocResponseEntity.corresLine2 as String : null,
      corresLine3: userKycDocResponseEntity.corresLine3 != null ? userKycDocResponseEntity.corresLine3 as String : null,
      corresCity: userKycDocResponseEntity.corresCity != null ? userKycDocResponseEntity.corresCity as String : null,
      corresDist: userKycDocResponseEntity.corresDist != null ? userKycDocResponseEntity.corresDist as String : null,
      corresState: userKycDocResponseEntity.corresState != null ? userKycDocResponseEntity.corresState as String : null,
      corresStateName: userKycDocResponseEntity.corresStateName != null ? userKycDocResponseEntity.corresStateName as String : null,
      corresCountry: userKycDocResponseEntity.corresCountry != null ? userKycDocResponseEntity.corresCountry as String : null,
      corresCountryName: userKycDocResponseEntity.corresCountryName != null ? userKycDocResponseEntity.corresCountryName as String : null,
      corresPin: userKycDocResponseEntity.corresPin != null ? userKycDocResponseEntity.corresPin as String : null,
      corresPoa: userKycDocResponseEntity.corresPoa != null ? userKycDocResponseEntity.corresPoa as String : null,
      resiStdCode: userKycDocResponseEntity.resiStdCode != null ? userKycDocResponseEntity.resiStdCode as String : null,
      resiTelNum: userKycDocResponseEntity.resiTelNum != null ? userKycDocResponseEntity.resiTelNum as String : null,
      offStdCode: userKycDocResponseEntity.offStdCode != null ? userKycDocResponseEntity.offStdCode as String : null,
      offTelNum: userKycDocResponseEntity.offTelNum != null ? userKycDocResponseEntity.offTelNum as String : null,
      mobCode: userKycDocResponseEntity.mobCode != null ? userKycDocResponseEntity.mobCode as String : null,
      mobNum: userKycDocResponseEntity.mobNum != null ? userKycDocResponseEntity.mobNum as String : null,
      emailId: userKycDocResponseEntity.emailId != null ? userKycDocResponseEntity.emailId as String : null,
      remarks: userKycDocResponseEntity.remarks != null ? userKycDocResponseEntity.remarks as String : null,
      decDate: userKycDocResponseEntity.decDate != null ? userKycDocResponseEntity.decDate as String : null,
      decPlace: userKycDocResponseEntity.decPlace != null ? userKycDocResponseEntity.decPlace as String : null,
      kycDate: userKycDocResponseEntity.kycDate != null ? userKycDocResponseEntity.kycDate as String : null,
      docSub: userKycDocResponseEntity.docSub != null ? userKycDocResponseEntity.docSub as String : null,
      kycName: userKycDocResponseEntity.kycName != null ? userKycDocResponseEntity.kycName as String : null,
      kycDesignation: userKycDocResponseEntity.kycDesignation != null ? userKycDocResponseEntity.kycDesignation as String : null,
      kycBranch: userKycDocResponseEntity.kycBranch != null ? userKycDocResponseEntity.kycBranch as String : null,
      kycEmpcode: userKycDocResponseEntity.kycEmpcode != null ? userKycDocResponseEntity.kycEmpcode as String : null,
      orgName: userKycDocResponseEntity.orgName != null ? userKycDocResponseEntity.orgName as String : null,
      orgCode: userKycDocResponseEntity.orgCode != null ? userKycDocResponseEntity.orgCode as String : null,
      numIdentity: userKycDocResponseEntity.numIdentity != null ? userKycDocResponseEntity.numIdentity as String : null,
      numRelated: userKycDocResponseEntity.numRelated != null ? userKycDocResponseEntity.numRelated as String : null,
      numImages: userKycDocResponseEntity.numImages != null ? userKycDocResponseEntity.numImages as String : null,
      address: userKycDocResponseEntity.address != null ? userKycDocResponseEntity.address as String : null,
      isEdited: userKycDocResponseEntity.isEdited != null ? userKycDocResponseEntity.isEdited as int : null,
      doctype: userKycDocResponseEntity.doctype != null ? userKycDocResponseEntity.doctype as String : null,
      identityDetails: userKycDocResponseEntity.identityDetails != null ? List<IdentityDetailsResponseModel>.from((userKycDocResponseEntity.identityDetails as List<dynamic>).map<IdentityDetailsResponseModel?>((x) => IdentityDetailsResponseModel.fromEntity(x as IdentityDetailsResponseEntity),),) : null,
      relatedPersonDetails: userKycDocResponseEntity.relatedPersonDetails != null ? List<RelatedPersonalDetailsResponseModel>.from((userKycDocResponseEntity.relatedPersonDetails as List<dynamic>).map<RelatedPersonalDetailsResponseModel?>((x) => RelatedPersonalDetailsResponseModel.fromEntity(x as RelatedPersonalDetailsResponseEntity),),) : null,
      imageDetails: userKycDocResponseEntity.imageDetails != null ? List<ImageDetailsResponseModel>.from((userKycDocResponseEntity.imageDetails as List<dynamic>).map<ImageDetailsResponseModel?>((x) => ImageDetailsResponseModel.fromEntity(x as ImageDetailsResponseEntity),),) : null,
      bankAccount: userKycDocResponseEntity.bankAccount != null ? List<BankAccountDetailsResponseModel>.from((userKycDocResponseEntity.bankAccount as List<dynamic>).map<BankAccountDetailsResponseModel?>((x) => BankAccountDetailsResponseModel.fromEntity(x as BankAccountDetailsResponseEntity),),) : null,
    );
  }
}
