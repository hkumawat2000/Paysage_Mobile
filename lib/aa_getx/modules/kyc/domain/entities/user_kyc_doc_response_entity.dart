import 'package:lms/aa_getx/modules/kyc/domain/entities/bank_account_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/identity_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/image_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/related_personal_details_response_entity.dart';

class UserKycDocResponseEntity {
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
  List<IdentityDetailsResponseEntity>? identityDetails;
  List<RelatedPersonalDetailsResponseEntity>? relatedPersonDetails;
  List<ImageDetailsResponseEntity>? imageDetails;
  List<BankAccountDetailsResponseEntity>? bankAccount;

  UserKycDocResponseEntity(
      {this.name,
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
        this.bankAccount});
}