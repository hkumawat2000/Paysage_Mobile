// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/login/domain/entity/related_person_details_entity.dart';

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
  RelatedPersonDetails({
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
    this.passport,
  });

  // RelatedPersonDetails(
  //     {this.name,
  //     this.owner,
  //     this.creation,
  //     this.modified,
  //     this.modifiedBy,
  //     this.parent,
  //     this.parentfield,
  //     this.parenttype,
  //     this.idx,
  //     this.docstatus,
  //     this.sequenceNo,
  //     this.relType,
  //     this.addDelFlag,
  //     this.ckycNo,
  //     this.prefix,
  //     this.fname,
  //     this.mname,
  //     this.lname,
  //     this.maidenPrefix,
  //     this.maidenFname,
  //     this.maidenMname,
  //     this.maidenLname,
  //     this.fatherspouseFlag,
  //     this.fatherPrefix,
  //     this.fatherFname,
  //     this.fatherMname,
  //     this.fatherLname,
  //     this.motherPrefix,
  //     this.motherFname,
  //     this.motherMname,
  //     this.motherLname,
  //     this.dob,
  //     this.gender,
  //     this.pan,
  //     this.permPoiType,
  //     this.sameAsPermFlag,
  //     this.corresAddLine1,
  //     this.corresAddLine2,
  //     this.corresAddLine3,
  //     this.corresAddCity,
  //     this.corresAddDist,
  //     this.corresAddState,
  //     this.corresAddCountry,
  //     this.corresAddPin,
  //     this.corresPoiType,
  //     this.resiStdCode,
  //     this.resiTelNum,
  //     this.offStdCode,
  //     this.offTelNum,
  //     this.mobCode,
  //     this.mobNum,
  //     this.email,
  //     this.remarks,
  //     this.photoType,
  //     this.photo,
  //     this.permPoiImageType,
  //     this.permPoi,
  //     this.offlineVerificationAadhaar,
  //     this.decDate,
  //     this.decPlace,
  //     this.kycDate,
  //     this.docSub,
  //     this.kycName,
  //     this.kycDesignation,
  //     this.kycBranch,
  //     this.kycEmpcode,
  //     this.orgName,
  //     this.orgCode,
  //     this.doctype,
  //     this.passport});

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

  RelatedPersonDetailsEntity toEntity() => RelatedPersonDetailsEntity(
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
        sequenceNo: sequenceNo,
        relType: relType,
        addDelFlag: addDelFlag,
        ckycNo: ckycNo,
        prefix: prefix,
        fname: fname,
        mname: mname,
        lname: lname,
        maidenPrefix: maidenPrefix,
        maidenFname: maidenFname,
        maidenMname: maidenMname,
        maidenLname: maidenLname,
        fatherspouseFlag: fatherspouseFlag,
        fatherPrefix: fatherPrefix,
        fatherFname: fatherFname,
        fatherMname: fatherMname,
        fatherLname: fatherLname,
        motherPrefix: motherPrefix,
        motherFname: motherFname,
        motherMname: motherMname,
        motherLname: motherLname,
        dob: dob,
        gender: gender,
        pan: pan,
        permPoiType: permPoiType,
        sameAsPermFlag: sameAsPermFlag,
        corresAddLine1: corresAddLine1,
        corresAddLine2: corresAddLine2,
        corresAddLine3: corresAddLine3,
        corresAddCity: corresAddCity,
        corresAddDist: corresAddDist,
        corresAddState: corresAddState,
        corresAddCountry: corresAddCountry,
        corresAddPin: corresAddPin,
        corresPoiType: corresPoiType,
        resiStdCode: resiStdCode,
        resiTelNum: resiTelNum,
        offStdCode: offStdCode,
        offTelNum: offTelNum,
        mobCode: mobCode,
        mobNum: mobNum,
        email: email,
        remarks: remarks,
        photoType: photoType,
        photo: photo,
        permPoiImageType: permPoiImageType,
        permPoi: permPoi,
        offlineVerificationAadhaar: offlineVerificationAadhaar,
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
        doctype: doctype,
        passport: passport,
      );

  

  factory RelatedPersonDetails.fromEntity(RelatedPersonDetails relatedPersonDetails) {
    return RelatedPersonDetails(
      name: relatedPersonDetails.name != null ? relatedPersonDetails.name as String : null,
      owner: relatedPersonDetails.owner != null ? relatedPersonDetails.owner as String : null,
      creation: relatedPersonDetails.creation != null ? relatedPersonDetails.creation as String : null,
      modified: relatedPersonDetails.modified != null ? relatedPersonDetails.modified as String : null,
      modifiedBy: relatedPersonDetails.modifiedBy != null ? relatedPersonDetails.modifiedBy as String : null,
      parent: relatedPersonDetails.parent != null ? relatedPersonDetails.parent as String : null,
      parentfield: relatedPersonDetails.parentfield != null ? relatedPersonDetails.parentfield as String : null,
      parenttype: relatedPersonDetails.parenttype != null ? relatedPersonDetails.parenttype as String : null,
      idx: relatedPersonDetails.idx != null ? relatedPersonDetails.idx as int : null,
      docstatus: relatedPersonDetails.docstatus != null ? relatedPersonDetails.docstatus as int : null,
      sequenceNo: relatedPersonDetails.sequenceNo != null ? relatedPersonDetails.sequenceNo as String : null,
      relType: relatedPersonDetails.relType != null ? relatedPersonDetails.relType as String : null,
      addDelFlag: relatedPersonDetails.addDelFlag != null ? relatedPersonDetails.addDelFlag as String : null,
      ckycNo: relatedPersonDetails.ckycNo != null ? relatedPersonDetails.ckycNo as String : null,
      prefix: relatedPersonDetails.prefix != null ? relatedPersonDetails.prefix as String : null,
      fname: relatedPersonDetails.fname != null ? relatedPersonDetails.fname as String : null,
      mname: relatedPersonDetails.mname != null ? relatedPersonDetails.mname as String : null,
      lname: relatedPersonDetails.lname != null ? relatedPersonDetails.lname as String : null,
      maidenPrefix: relatedPersonDetails.maidenPrefix != null ? relatedPersonDetails.maidenPrefix as String : null,
      maidenFname: relatedPersonDetails.maidenFname != null ? relatedPersonDetails.maidenFname as String : null,
      maidenMname: relatedPersonDetails.maidenMname != null ? relatedPersonDetails.maidenMname as String : null,
      maidenLname: relatedPersonDetails.maidenLname != null ? relatedPersonDetails.maidenLname as String : null,
      fatherspouseFlag: relatedPersonDetails.fatherspouseFlag != null ? relatedPersonDetails.fatherspouseFlag as String : null,
      fatherPrefix: relatedPersonDetails.fatherPrefix != null ? relatedPersonDetails.fatherPrefix as String : null,
      fatherFname: relatedPersonDetails.fatherFname != null ? relatedPersonDetails.fatherFname as String : null,
      fatherMname: relatedPersonDetails.fatherMname != null ? relatedPersonDetails.fatherMname as String : null,
      fatherLname: relatedPersonDetails.fatherLname != null ? relatedPersonDetails.fatherLname as String : null,
      motherPrefix: relatedPersonDetails.motherPrefix != null ? relatedPersonDetails.motherPrefix as String : null,
      motherFname: relatedPersonDetails.motherFname != null ? relatedPersonDetails.motherFname as String : null,
      motherMname: relatedPersonDetails.motherMname != null ? relatedPersonDetails.motherMname as String : null,
      motherLname: relatedPersonDetails.motherLname != null ? relatedPersonDetails.motherLname as String : null,
      dob: relatedPersonDetails.dob != null ? relatedPersonDetails.dob as String : null,
      gender: relatedPersonDetails.gender != null ? relatedPersonDetails.gender as String : null,
      pan: relatedPersonDetails.pan != null ? relatedPersonDetails.pan as String : null,
      permPoiType: relatedPersonDetails.permPoiType != null ? relatedPersonDetails.permPoiType as String : null,
      sameAsPermFlag: relatedPersonDetails.sameAsPermFlag != null ? relatedPersonDetails.sameAsPermFlag as String : null,
      corresAddLine1: relatedPersonDetails.corresAddLine1 != null ? relatedPersonDetails.corresAddLine1 as String : null,
      corresAddLine2: relatedPersonDetails.corresAddLine2 != null ? relatedPersonDetails.corresAddLine2 as String : null,
      corresAddLine3: relatedPersonDetails.corresAddLine3 != null ? relatedPersonDetails.corresAddLine3 as String : null,
      corresAddCity: relatedPersonDetails.corresAddCity != null ? relatedPersonDetails.corresAddCity as String : null,
      corresAddDist: relatedPersonDetails.corresAddDist != null ? relatedPersonDetails.corresAddDist as String : null,
      corresAddState: relatedPersonDetails.corresAddState != null ? relatedPersonDetails.corresAddState as String : null,
      corresAddCountry: relatedPersonDetails.corresAddCountry != null ? relatedPersonDetails.corresAddCountry as String : null,
      corresAddPin: relatedPersonDetails.corresAddPin != null ? relatedPersonDetails.corresAddPin as String : null,
      corresPoiType: relatedPersonDetails.corresPoiType != null ? relatedPersonDetails.corresPoiType as String : null,
      resiStdCode: relatedPersonDetails.resiStdCode != null ? relatedPersonDetails.resiStdCode as String : null,
      resiTelNum: relatedPersonDetails.resiTelNum != null ? relatedPersonDetails.resiTelNum as String : null,
      offStdCode: relatedPersonDetails.offStdCode != null ? relatedPersonDetails.offStdCode as String : null,
      offTelNum: relatedPersonDetails.offTelNum != null ? relatedPersonDetails.offTelNum as String : null,
      mobCode: relatedPersonDetails.mobCode != null ? relatedPersonDetails.mobCode as String : null,
      mobNum: relatedPersonDetails.mobNum != null ? relatedPersonDetails.mobNum as String : null,
      email: relatedPersonDetails.email != null ? relatedPersonDetails.email as String : null,
      remarks: relatedPersonDetails.remarks != null ? relatedPersonDetails.remarks as String : null,
      photoType: relatedPersonDetails.photoType != null ? relatedPersonDetails.photoType as String : null,
      photo: relatedPersonDetails.photo != null ? relatedPersonDetails.photo as String : null,
      permPoiImageType: relatedPersonDetails.permPoiImageType != null ? relatedPersonDetails.permPoiImageType as String : null,
      permPoi: relatedPersonDetails.permPoi != null ? relatedPersonDetails.permPoi as String : null,
      offlineVerificationAadhaar: relatedPersonDetails.offlineVerificationAadhaar != null ? relatedPersonDetails.offlineVerificationAadhaar as String : null,
      decDate: relatedPersonDetails.decDate != null ? relatedPersonDetails.decDate as String : null,
      decPlace: relatedPersonDetails.decPlace != null ? relatedPersonDetails.decPlace as String : null,
      kycDate: relatedPersonDetails.kycDate != null ? relatedPersonDetails.kycDate as String : null,
      docSub: relatedPersonDetails.docSub != null ? relatedPersonDetails.docSub as String : null,
      kycName: relatedPersonDetails.kycName != null ? relatedPersonDetails.kycName as String : null,
      kycDesignation: relatedPersonDetails.kycDesignation != null ? relatedPersonDetails.kycDesignation as String : null,
      kycBranch: relatedPersonDetails.kycBranch != null ? relatedPersonDetails.kycBranch as String : null,
      kycEmpcode: relatedPersonDetails.kycEmpcode != null ? relatedPersonDetails.kycEmpcode as String : null,
      orgName: relatedPersonDetails.orgName != null ? relatedPersonDetails.orgName as String : null,
      orgCode: relatedPersonDetails.orgCode != null ? relatedPersonDetails.orgCode as String : null,
      doctype: relatedPersonDetails.doctype != null ? relatedPersonDetails.doctype as String : null,
      passport: relatedPersonDetails.passport != null ? relatedPersonDetails.passport as String : null,
    );
  }
}
