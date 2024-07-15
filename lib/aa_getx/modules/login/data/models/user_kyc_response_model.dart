import 'package:lms/aa_getx/modules/login/data/models/bank_account_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/identity_details_response_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/image_details_response_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/related_person_details_response_model.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/user_kyc_entity.dart';

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

  UserKycEntity toEntity() => UserKycEntity(
        name: name,
        owner: owner,
        creation: creation,
        modified: modified,
        modifiedBy: modifiedBy,
        idx: idx,
        docstatus: docstatus,
        user: user,
        panNo: panNo,
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
        dob: dob,
        pan: pan,
        permLine1: permLine1,
        permLine2: permLine2,
        permLine3: permLine3,
        permCity: permCity,
        permDist: permDist,
        permState: permState,
        permCountry: permCountry,
        permPin: permPin,
        permPoa: permPoa,
        permCorresSameflag: permCorresSameflag,
        corresLine1: corresLine1,
        corresLine2: corresLine2,
        corresLine3: corresLine3,
        corresCity: corresCity,
        corresDist: corresDist,
        corresState: corresState,
        corresCountry: corresCountry,
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
        relatedPersonDetails:
            relatedPersonDetails?.map((x) => x.toEntity()).toList(),
        imageDetails: imageDetails?.map((x) => x.toEntity()).toList(),
        bankAccount: bankAccount?.map((x) => x.toEntity()).toList(),
      );
}
