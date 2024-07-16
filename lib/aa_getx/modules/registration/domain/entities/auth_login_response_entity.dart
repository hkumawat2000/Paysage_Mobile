
import 'package:lms/network/ModelWrapper.dart';

class AuthLoginResponseEntity extends ModelWrapper{
  String? message;
  RegisterDataEntity? registerData;
  ErrorsEntity? errors;

  AuthLoginResponseEntity({this.message, this.registerData,this.errors});

}

class RegisterDataEntity {
  String? token;
  CustomerEntity? customer;
  UserKycEntity? userKyc;
  List<PendingEsignsEntity>? pendingEsigns;

  RegisterDataEntity({this.token, this.customer, this.userKyc,this.pendingEsigns});
}

class PendingEsignsEntity {
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
  List<CommonItemsEntity>? items;


  PendingEsignsEntity({this.name,
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
}

class CommonItemsEntity {
  double? amount;
  String? creation;
  int? docstatus;
  String? doctype;
  String? errorCode;
  int? idx;
  String? isin;
  String? modified;
  String? modifiedBy;
  String? name;
  String? owner;
  String? parent;
  String? parentfield;
  String? parenttype;
  double? pledgedQuantity;
  double? price;
  String? psn;
  String? securityCategory;
  String? securityName;
  String? lenderApprovalStatus;
  String? folio;

  CommonItemsEntity(
      {this.amount,
        this.creation,
        this.docstatus,
        this.doctype,
        this.errorCode,
        this.idx,
        this.isin,
        this.modified,
        this.modifiedBy,
        this.name,
        this.owner,
        this.parent,
        this.parentfield,
        this.parenttype,
        this.pledgedQuantity,
        this.price,
        this.psn,
        this.securityCategory,
        this.securityName,
        this.lenderApprovalStatus,
        this.folio});
}

class CustomerEntity {
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
  // Null lmsMobile;
  // Null bankAccount;
  String? gender;
  // Null fatherMiddleName;
  // Null pendingInterest;
  // Null alternateEmail;
  // Null nomineeDetails;
  // Null address;
  // Null pennyDrop;
  String? martialStatus;
  // Null atrinaMobile;
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

  CustomerEntity(
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

  UserKycEntity(
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

  IdentityDetailsEntity(
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

  ImageDetailsEntity(
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

  RelatedPersonDetailsEntity(
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

  BankAccountEntity ({this.name, this.owner, this.creation, this.modified, this.modifiedBy, this.parent, this.parentfield, this.parenttype, this.idx, this.docstatus, this.bankStatus, this.bank, this.branch, this.accountNumber, this.ifsc, this.city, this.isDefault, this.razorpayFundAccountId, this.accountHolderName, this.personalizedCheque, this.accountType, this.razorpayFundAccountValidationId, this.notificationSent, this.doctype, this.bankCode, this.state, this.bankAddress, this.contact, this.micr, this.bankMode, this.bankZipCode, this.district});
}

class ErrorsEntity {
  String? mobile;
  String? firebaseToken;
  String? otp;
  String? firstName;
  String? pin;
  String? message;

  ErrorsEntity({this.mobile,this.firebaseToken,this.otp,this.pin,this.firstName,this.message});
}