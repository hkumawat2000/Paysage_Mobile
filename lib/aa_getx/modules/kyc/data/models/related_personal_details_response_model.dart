// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/domain/entities/related_personal_details_response_entity.dart';

class RelatedPersonalDetailsResponseModel {
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

  RelatedPersonalDetailsResponseModel(
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

  RelatedPersonalDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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

  RelatedPersonalDetailsResponseEntity toEntity() =>
      RelatedPersonalDetailsResponseEntity(
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

  factory RelatedPersonalDetailsResponseModel.fromEntity(
      RelatedPersonalDetailsResponseEntity
          relatedPersonalDetailsResponseEntity) {
    return RelatedPersonalDetailsResponseModel(
      name: relatedPersonalDetailsResponseEntity.name != null
          ? relatedPersonalDetailsResponseEntity.name as String
          : null,
      owner: relatedPersonalDetailsResponseEntity.owner != null
          ? relatedPersonalDetailsResponseEntity.owner as String
          : null,
      creation: relatedPersonalDetailsResponseEntity.creation != null
          ? relatedPersonalDetailsResponseEntity.creation as String
          : null,
      modified: relatedPersonalDetailsResponseEntity.modified != null
          ? relatedPersonalDetailsResponseEntity.modified as String
          : null,
      modifiedBy: relatedPersonalDetailsResponseEntity.modifiedBy != null
          ? relatedPersonalDetailsResponseEntity.modifiedBy as String
          : null,
      parent: relatedPersonalDetailsResponseEntity.parent != null
          ? relatedPersonalDetailsResponseEntity.parent as String
          : null,
      parentfield: relatedPersonalDetailsResponseEntity.parentfield != null
          ? relatedPersonalDetailsResponseEntity.parentfield as String
          : null,
      parenttype: relatedPersonalDetailsResponseEntity.parenttype != null
          ? relatedPersonalDetailsResponseEntity.parenttype as String
          : null,
      idx: relatedPersonalDetailsResponseEntity.idx != null
          ? relatedPersonalDetailsResponseEntity.idx as int
          : null,
      docstatus: relatedPersonalDetailsResponseEntity.docstatus != null
          ? relatedPersonalDetailsResponseEntity.docstatus as int
          : null,
      sequenceNo: relatedPersonalDetailsResponseEntity.sequenceNo != null
          ? relatedPersonalDetailsResponseEntity.sequenceNo as String
          : null,
      relType: relatedPersonalDetailsResponseEntity.relType != null
          ? relatedPersonalDetailsResponseEntity.relType as String
          : null,
      addDelFlag: relatedPersonalDetailsResponseEntity.addDelFlag != null
          ? relatedPersonalDetailsResponseEntity.addDelFlag as String
          : null,
      ckycNo: relatedPersonalDetailsResponseEntity.ckycNo != null
          ? relatedPersonalDetailsResponseEntity.ckycNo as String
          : null,
      prefix: relatedPersonalDetailsResponseEntity.prefix != null
          ? relatedPersonalDetailsResponseEntity.prefix as String
          : null,
      fname: relatedPersonalDetailsResponseEntity.fname != null
          ? relatedPersonalDetailsResponseEntity.fname as String
          : null,
      mname: relatedPersonalDetailsResponseEntity.mname != null
          ? relatedPersonalDetailsResponseEntity.mname as String
          : null,
      lname: relatedPersonalDetailsResponseEntity.lname != null
          ? relatedPersonalDetailsResponseEntity.lname as String
          : null,
      maidenPrefix: relatedPersonalDetailsResponseEntity.maidenPrefix != null
          ? relatedPersonalDetailsResponseEntity.maidenPrefix as String
          : null,
      maidenFname: relatedPersonalDetailsResponseEntity.maidenFname != null
          ? relatedPersonalDetailsResponseEntity.maidenFname as String
          : null,
      maidenMname: relatedPersonalDetailsResponseEntity.maidenMname != null
          ? relatedPersonalDetailsResponseEntity.maidenMname as String
          : null,
      maidenLname: relatedPersonalDetailsResponseEntity.maidenLname != null
          ? relatedPersonalDetailsResponseEntity.maidenLname as String
          : null,
      fatherspouseFlag:
          relatedPersonalDetailsResponseEntity.fatherspouseFlag != null
              ? relatedPersonalDetailsResponseEntity.fatherspouseFlag as String
              : null,
      fatherPrefix: relatedPersonalDetailsResponseEntity.fatherPrefix != null
          ? relatedPersonalDetailsResponseEntity.fatherPrefix as String
          : null,
      fatherFname: relatedPersonalDetailsResponseEntity.fatherFname != null
          ? relatedPersonalDetailsResponseEntity.fatherFname as String
          : null,
      fatherMname: relatedPersonalDetailsResponseEntity.fatherMname != null
          ? relatedPersonalDetailsResponseEntity.fatherMname as String
          : null,
      fatherLname: relatedPersonalDetailsResponseEntity.fatherLname != null
          ? relatedPersonalDetailsResponseEntity.fatherLname as String
          : null,
      motherPrefix: relatedPersonalDetailsResponseEntity.motherPrefix != null
          ? relatedPersonalDetailsResponseEntity.motherPrefix as String
          : null,
      motherFname: relatedPersonalDetailsResponseEntity.motherFname != null
          ? relatedPersonalDetailsResponseEntity.motherFname as String
          : null,
      motherMname: relatedPersonalDetailsResponseEntity.motherMname != null
          ? relatedPersonalDetailsResponseEntity.motherMname as String
          : null,
      motherLname: relatedPersonalDetailsResponseEntity.motherLname != null
          ? relatedPersonalDetailsResponseEntity.motherLname as String
          : null,
      dob: relatedPersonalDetailsResponseEntity.dob != null
          ? relatedPersonalDetailsResponseEntity.dob as String
          : null,
      gender: relatedPersonalDetailsResponseEntity.gender != null
          ? relatedPersonalDetailsResponseEntity.gender as String
          : null,
      pan: relatedPersonalDetailsResponseEntity.pan != null
          ? relatedPersonalDetailsResponseEntity.pan as String
          : null,
      permPoiType: relatedPersonalDetailsResponseEntity.permPoiType != null
          ? relatedPersonalDetailsResponseEntity.permPoiType as String
          : null,
      sameAsPermFlag:
          relatedPersonalDetailsResponseEntity.sameAsPermFlag != null
              ? relatedPersonalDetailsResponseEntity.sameAsPermFlag as String
              : null,
      corresAddLine1:
          relatedPersonalDetailsResponseEntity.corresAddLine1 != null
              ? relatedPersonalDetailsResponseEntity.corresAddLine1 as String
              : null,
      corresAddLine2:
          relatedPersonalDetailsResponseEntity.corresAddLine2 != null
              ? relatedPersonalDetailsResponseEntity.corresAddLine2 as String
              : null,
      corresAddLine3:
          relatedPersonalDetailsResponseEntity.corresAddLine3 != null
              ? relatedPersonalDetailsResponseEntity.corresAddLine3 as String
              : null,
      corresAddCity: relatedPersonalDetailsResponseEntity.corresAddCity != null
          ? relatedPersonalDetailsResponseEntity.corresAddCity as String
          : null,
      corresAddDist: relatedPersonalDetailsResponseEntity.corresAddDist != null
          ? relatedPersonalDetailsResponseEntity.corresAddDist as String
          : null,
      corresAddState:
          relatedPersonalDetailsResponseEntity.corresAddState != null
              ? relatedPersonalDetailsResponseEntity.corresAddState as String
              : null,
      corresAddCountry:
          relatedPersonalDetailsResponseEntity.corresAddCountry != null
              ? relatedPersonalDetailsResponseEntity.corresAddCountry as String
              : null,
      corresAddPin: relatedPersonalDetailsResponseEntity.corresAddPin != null
          ? relatedPersonalDetailsResponseEntity.corresAddPin as String
          : null,
      corresPoiType: relatedPersonalDetailsResponseEntity.corresPoiType != null
          ? relatedPersonalDetailsResponseEntity.corresPoiType as String
          : null,
      resiStdCode: relatedPersonalDetailsResponseEntity.resiStdCode != null
          ? relatedPersonalDetailsResponseEntity.resiStdCode as String
          : null,
      resiTelNum: relatedPersonalDetailsResponseEntity.resiTelNum != null
          ? relatedPersonalDetailsResponseEntity.resiTelNum as String
          : null,
      offStdCode: relatedPersonalDetailsResponseEntity.offStdCode != null
          ? relatedPersonalDetailsResponseEntity.offStdCode as String
          : null,
      offTelNum: relatedPersonalDetailsResponseEntity.offTelNum != null
          ? relatedPersonalDetailsResponseEntity.offTelNum as String
          : null,
      mobCode: relatedPersonalDetailsResponseEntity.mobCode != null
          ? relatedPersonalDetailsResponseEntity.mobCode as String
          : null,
      mobNum: relatedPersonalDetailsResponseEntity.mobNum != null
          ? relatedPersonalDetailsResponseEntity.mobNum as String
          : null,
      email: relatedPersonalDetailsResponseEntity.email != null
          ? relatedPersonalDetailsResponseEntity.email as String
          : null,
      remarks: relatedPersonalDetailsResponseEntity.remarks != null
          ? relatedPersonalDetailsResponseEntity.remarks as String
          : null,
      photoType: relatedPersonalDetailsResponseEntity.photoType != null
          ? relatedPersonalDetailsResponseEntity.photoType as String
          : null,
      photo: relatedPersonalDetailsResponseEntity.photo != null
          ? relatedPersonalDetailsResponseEntity.photo as String
          : null,
      permPoiImageType:
          relatedPersonalDetailsResponseEntity.permPoiImageType != null
              ? relatedPersonalDetailsResponseEntity.permPoiImageType as String
              : null,
      permPoi: relatedPersonalDetailsResponseEntity.permPoi != null
          ? relatedPersonalDetailsResponseEntity.permPoi as String
          : null,
      offlineVerificationAadhaar:
          relatedPersonalDetailsResponseEntity.offlineVerificationAadhaar !=
                  null
              ? relatedPersonalDetailsResponseEntity.offlineVerificationAadhaar
                  as String
              : null,
      decDate: relatedPersonalDetailsResponseEntity.decDate != null
          ? relatedPersonalDetailsResponseEntity.decDate as String
          : null,
      decPlace: relatedPersonalDetailsResponseEntity.decPlace != null
          ? relatedPersonalDetailsResponseEntity.decPlace as String
          : null,
      kycDate: relatedPersonalDetailsResponseEntity.kycDate != null
          ? relatedPersonalDetailsResponseEntity.kycDate as String
          : null,
      docSub: relatedPersonalDetailsResponseEntity.docSub != null
          ? relatedPersonalDetailsResponseEntity.docSub as String
          : null,
      kycName: relatedPersonalDetailsResponseEntity.kycName != null
          ? relatedPersonalDetailsResponseEntity.kycName as String
          : null,
      kycDesignation:
          relatedPersonalDetailsResponseEntity.kycDesignation != null
              ? relatedPersonalDetailsResponseEntity.kycDesignation as String
              : null,
      kycBranch: relatedPersonalDetailsResponseEntity.kycBranch != null
          ? relatedPersonalDetailsResponseEntity.kycBranch as String
          : null,
      kycEmpcode: relatedPersonalDetailsResponseEntity.kycEmpcode != null
          ? relatedPersonalDetailsResponseEntity.kycEmpcode as String
          : null,
      orgName: relatedPersonalDetailsResponseEntity.orgName != null
          ? relatedPersonalDetailsResponseEntity.orgName as String
          : null,
      orgCode: relatedPersonalDetailsResponseEntity.orgCode != null
          ? relatedPersonalDetailsResponseEntity.orgCode as String
          : null,
      doctype: relatedPersonalDetailsResponseEntity.doctype != null
          ? relatedPersonalDetailsResponseEntity.doctype as String
          : null,
      passport: relatedPersonalDetailsResponseEntity.passport != null
          ? relatedPersonalDetailsResponseEntity.passport as String
          : null,
    );
  }
}
