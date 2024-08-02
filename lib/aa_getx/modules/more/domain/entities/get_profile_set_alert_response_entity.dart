
class GetProfileSetAlertResponseEntity {
  String? message;
  AlertDataEntity? alertData;

  GetProfileSetAlertResponseEntity({this.message, this.alertData});
}

class AlertDataEntity {
  CustomerDetailsEntity? customerDetails;
  String? loanApplicationStatus;
  String? loanName;
  String? instrumentType;
  String? pledgorBoid;
  UserKycEntity? userKyc;
  String? lastLogin;
  String? profilePhotoUrl;

  AlertDataEntity(
      {this.customerDetails, this.loanApplicationStatus, this.loanName, this.instrumentType, this.pledgorBoid, this.userKyc, this.lastLogin, this.profilePhotoUrl});
}

class CustomerDetailsEntity {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  int? registeration;
  int? isEmailVerified;
  int? kycUpdate;
  int? creditCheck;
  int? pledgeSecurities;
  int? loanOpen;
  int? feedbackSubmitted;
  int? feedbackDoNotShowPopup;
  String? choiceKyc;
  String? ckcy;
  String? kra;
  String? firstName;
  String? phone;
  String? myCamsEmailId;
  String? fullName;
  String? lastName;
  String? user;
  double? alertsBasedOnPercentage;
  double? alertsBasedOnAmount;
  String? doctype;

  CustomerDetailsEntity({this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.idx,
    this.docstatus,
    this.registeration,
    this.isEmailVerified,
    this.kycUpdate,
    this.creditCheck,
    this.pledgeSecurities,
    this.loanOpen,
    this.feedbackSubmitted,
    this.feedbackDoNotShowPopup,
    this.choiceKyc,
    this.ckcy,
    this.kra,
    this.firstName,
    this.phone,
    this.myCamsEmailId,
    this.fullName,
    this.lastName,
    this.user,
    this.alertsBasedOnPercentage,
    this.alertsBasedOnAmount,
    this.doctype});
}

class UserKycEntity {
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
  List<IdentityDetailsEntity>? identityDetails;
  List<RelatedPersonDetailsEntity>? relatedPersonDetails;
  List<ImageDetailsEntity>? imageDetails;
  List<BankAccountEntity>? bankAccount;

  UserKycEntity({this.name,
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
}

class IdentityDetailsEntity {
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

  IdentityDetailsEntity({this.name,
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
}

class RelatedPersonDetailsEntity {
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

  RelatedPersonDetailsEntity({this.name,
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
}

class ImageDetailsEntity {
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

  ImageDetailsEntity({this.name,
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
}

class BankAccountEntity {
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
  String? bank;
  String? branch;
  String? accountNumber;
  String? ifsc;
  String? bankCode;
  String? city;
  String? state;
  // int isDefault;
  String? bankAddress;
  String? contact;
  String? accountType;
  String? micr;
  String? bankMode;
  String? bankZipCode;
  String? district;
  String? doctype;
  String? bankStatus;

  BankAccountEntity({this.name,
    this.owner,
    this.creation,
    this.modified,
    this.modifiedBy,
    this.parent,
    this.parentfield,
    this.parenttype,
    this.idx,
    this.docstatus,
    this.bank,
    this.branch,
    this.accountNumber,
    this.ifsc,
    this.bankCode,
    this.city,
    this.state,
    // this.isDefault,
    this.bankAddress,
    this.contact,
    this.accountType,
    this.micr,
    this.bankMode,
    this.bankZipCode,
    this.district,
    this.doctype,
    this.bankStatus});
}