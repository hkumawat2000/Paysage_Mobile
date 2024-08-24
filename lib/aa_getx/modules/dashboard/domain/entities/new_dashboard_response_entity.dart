




class NewDashboardResponseEntity{
  String? message;
  NewDashboardDataEntity? newDashboardData;

  NewDashboardResponseEntity({this.message, this.newDashboardData});
}


class NewDashboardDataEntity {
  CustomerEntity? customer;
  UserKycEntity? userKyc;
  MarginShortfallCardEntity? marginShortfallCard;
  TotalInterestAllLoansCardEntity? totalInterestAllLoansCard;
  PendingEsignsListEntity? pendingEsignsList;
  int? showFeedbackPopup;
  List<String>? youtubeID;
  String? profilePhotoUrl;
  int? fCMUnreadCount;

  NewDashboardDataEntity(
      {this.customer,
        this.userKyc,
        this.marginShortfallCard,
        this.totalInterestAllLoansCard,
        this.pendingEsignsList,
        this.showFeedbackPopup,
        this.youtubeID,
        this.profilePhotoUrl,
        this.fCMUnreadCount,
      });
}

class CustomerEntity {
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
  int? bankUpdate;
  int? creditCheck;
  int? pledgeSecurities;
  int? loanOpen;
  String? choiceKyc;
  String? ckcy;
  String? kra;
  String? firstName;
  String? phone;
  String? fullName;
  String? lastName;
  String? user;
  String? doctype;
  String? hitId;
  String? cibilScore;

  CustomerEntity(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.registeration,
        this.isEmailVerified,
        this.kycUpdate,
        this.bankUpdate,
        this.creditCheck,
        this.pledgeSecurities,
        this.loanOpen,
        this.choiceKyc,
        this.ckcy,
        this.kra,
        this.firstName,
        this.phone,
        this.fullName,
        this.lastName,
        this.user,
        this.hitId,
        this.cibilScore,
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

  BankAccountEntity({this.name, this.owner, this.creation, this.modified, this.modifiedBy, this.parent, this.parentfield, this.parenttype, this.idx, this.docstatus, this.bankStatus, this.bank, this.branch, this.accountNumber, this.ifsc, this.city, this.isDefault, this.razorpayFundAccountId, this.accountHolderName, this.personalizedCheque, this.accountType, this.razorpayFundAccountValidationId, this.notificationSent, this.doctype, this.bankCode, this.state, this.bankAddress, this.contact, this.micr, this.bankMode, this.bankZipCode, this.district});
}


class MarginShortfallCardEntity {
  String? earliestDeadline;
  List<LoanWithMarginShortfallListEntity>? loanWithMarginShortfallList;

  MarginShortfallCardEntity(
      {this.earliestDeadline, this.loanWithMarginShortfallList});
}


class LoanWithMarginShortfallListEntity {
  String? name;
  String? deadline;
  String? status;
  int? isTodayHoliday;

  LoanWithMarginShortfallListEntity({this.name, this.deadline, this.status, this.isTodayHoliday});
}

class TotalInterestAllLoansCardEntity {
  String? totalInterestAmount;
  LoansInterestDueDateEntity? loansInterestDueDate;
  List<InterestLoanListEntity>? interestLoanList;

  TotalInterestAllLoansCardEntity(
      {this.totalInterestAmount,
        this.loansInterestDueDate,
        this.interestLoanList});
}

class LoansInterestDueDateEntity {
  String? dueDate;
  String? dueDateTxt;
  int? dpdTxt;

  LoansInterestDueDateEntity({this.dueDate, this.dueDateTxt, this.dpdTxt});
}

class InterestLoanListEntity {
  String? loanName;
  double? interestAmount;

  InterestLoanListEntity({this.loanName, this.interestAmount});
}


class PendingEsignsListEntity {
  List<LaPendingEsignsEntity>? laPendingEsigns;
  List<TopupPendingEsignsEntity>? topupPendingEsigns;
  List<LoanRenewalEsignsEntity>? loanRenewalEsigns;

  PendingEsignsListEntity({this.laPendingEsigns, this.topupPendingEsigns, this.loanRenewalEsigns});
}

class LaPendingEsignsEntity {
  LoanApplicationEntity? loanApplication;
  String? message;
  IncreaseLoanMessageEntity? increaseLoanMessage;
  SanctionLetterEntity? sanctionLetter;

  LaPendingEsignsEntity({this.loanApplication, this.message, this.increaseLoanMessage, this.sanctionLetter});
}

class SanctionLetterEntity {
  String? sanctionLetter;

  SanctionLetterEntity({this.sanctionLetter});
}

class IncreaseLoanMessageEntity {
  double? existingLimit;
  double? existingCollateralValue;
  double? newLimit;
  double? newCollateralValue;

  IncreaseLoanMessageEntity(
      {this.existingLimit,
        this.existingCollateralValue,
        this.newLimit,
        this.newCollateralValue});
}

class LoanApplicationEntity {
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
  double? totalCollateralValue;
  String? totalCollateralValueStr;
  double? drawingPower;
  String? drawingPowerStr;
  String? lender;
  String? status;
  double? pledgedTotalCollateralValue;
  String? pledgedTotalCollateralValueStr;
  String? loanMarginShortfall;
  String? customer;
  String? customerName;
  double? allowableLtv;
  String? expiryDate;
  String? loan;
  String? pledgeStatus;
  // Null nUserTags;
  // Null nComments;
  // Null nAssign;
  // Null nLikedBy;
  String? workflowState;
  String? pledgorBoid;
  String? pledgeeBoid;
  List<CommonItemsEntity>? items;

  LoanApplicationEntity(
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
        this.totalCollateralValue,
        this.totalCollateralValueStr,
        this.drawingPower,
        this.drawingPowerStr,
        this.lender,
        this.status,
        this.pledgedTotalCollateralValue,
        this.pledgedTotalCollateralValueStr,
        this.loanMarginShortfall,
        this.customer,
        this.customerName,
        this.allowableLtv,
        this.expiryDate,
        this.loan,
        this.pledgeStatus,
        // this.nUserTags,
        // this.nComments,
        // this.nAssign,
        // this.nLikedBy,
        this.workflowState,
        this.pledgorBoid,
        this.pledgeeBoid,
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

class TopupPendingEsignsEntity {
  TopupApplicationDocEntity? topupApplicationDoc;
  String? mess;
  SanctionLetterEntity? sanctionLetter;

  TopupPendingEsignsEntity({this.topupApplicationDoc, this.mess, this.sanctionLetter});
}

class LoanRenewalEsignsEntity {
  LoanRenewalApplicationDocEntity? loanRenewalApplicationDoc;
  String? mess;
  List<CommonItemsEntity>? loanItems;
  SanctionLetterEntity? sanctionLetter;

  LoanRenewalEsignsEntity({this.loanRenewalApplicationDoc, this.mess, this.loanItems, this.sanctionLetter});
}

class LoanRenewalApplicationDocEntity {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? workflowState;
  String? loan;
  String? lender;
  String? oldKycName;
  String? newKycName;
  String? updatedKycStatus;
  double? totalCollateralValue;
  double? sanctionedLimit;
  String? expiryDate;
  int? tncComplete;
  int? reminders;
  String? status;
  String? customer;
  String? customerName;
  double? drawingPower;
  int? isExpired;
  String? customerEsignedDocument;
  String? lenderEsignedDocument;
  String? remarks;
  String? doctype;
  String? topUpAmount;

  LoanRenewalApplicationDocEntity(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.workflowState,
        this.loan,
        this.lender,
        this.oldKycName,
        this.newKycName,
        this.updatedKycStatus,
        this.totalCollateralValue,
        this.sanctionedLimit,
        this.expiryDate,
        this.tncComplete,
        this.reminders,
        this.status,
        this.customer,
        this.customerName,
        this.drawingPower,
        this.isExpired,
        this.customerEsignedDocument,
        this.lenderEsignedDocument,
        this.remarks,
        this.doctype,
        this.topUpAmount});
}

class TopupApplicationDocEntity  {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? workflowState;
  String? loan;
  String? topUpAmount;
  double? sanctionedLimit;
  String? time;
  String? status;
  String? customer;
  String? customerName;
  String? doctype;

  TopupApplicationDocEntity (
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.workflowState,
        this.loan,
        this.topUpAmount,
        this.sanctionedLimit,
        this.time,
        this.status,
        this.customer,
        this.customerName,
        this.doctype});
}