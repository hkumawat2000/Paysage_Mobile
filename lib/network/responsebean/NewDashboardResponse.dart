import 'package:lms/network/ModelWrapper.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class NewDashboardResponse extends ModelWrapper<NewDashboardData>{
  String? message;
  NewDashboardData? newDashboardData;

  NewDashboardResponse({this.message, this.newDashboardData});

  NewDashboardResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new NewDashboardData.fromJson(json['data']) : null;
    newDashboardData = data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NewDashboardData {
  Customer? customer;
  UserKyc? userKyc;
  MarginShortfallCard? marginShortfallCard;
  TotalInterestAllLoansCard? totalInterestAllLoansCard;
  // List<UnderProcessLa> underProcessLa;
  // List<ActionableLoans> actionableLoans;
  // List<ActiveLoans> activeLoans;
  PendingEsignsList? pendingEsignsList;
  // List<DashboardTopUp> topUp;
  // List<SellCollateralList> sellCollateralList;
  // List<IncreaseLoanList> increaseLoanList;
  // List<UnpledgeApplicationList> unpledgeApplicationList;
  int? showFeedbackPopup;
  List<String>? youtubeID;
  String? profilePhotoUrl;
  int? fCMUnreadCount;

  NewDashboardData(
      {this.customer,
        this.userKyc,
        this.marginShortfallCard,
        this.totalInterestAllLoansCard,
        // this.underProcessLa,
        // this.actionableLoans,
        // this.activeLoans,
        this.pendingEsignsList,
        // this.topUp,
        this.showFeedbackPopup,
        this.youtubeID,
        this.profilePhotoUrl,
        this.fCMUnreadCount,
        // this.sellCollateralList,
        // this.increaseLoanList,
        // this.unpledgeApplicationList
  });

  NewDashboardData.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    userKyc = json['user_kyc'] != null
        ? new UserKyc.fromJson(json['user_kyc'])
        : null;
    marginShortfallCard = json['margin_shortfall_card'] != null
        ? new MarginShortfallCard.fromJson(json['margin_shortfall_card'])
        : null;
    // if (json['margin_shortfall_card'] != null) {
    //   marginShortfallCard = new List<MarginShortfallCard>();
    //   json['margin_shortfall_card'].forEach((v) {
    //     marginShortfallCard.add(new MarginShortfallCard.fromJson(v));
    //   });
    // }
    totalInterestAllLoansCard = json['total_interest_all_loans_card'] != null
        ? new TotalInterestAllLoansCard.fromJson(json['total_interest_all_loans_card'])
        : null;

    // if (json['total_interest_all_loans_card'] != null) {
    //   totalInterestAllLoansCard = new List<TotalInterestAllLoansCard>();
    //   json['total_interest_all_loans_card'].forEach((v) {
    //     totalInterestAllLoansCard.add(new TotalInterestAllLoansCard.fromJson(v));
    //   });
    // }
    // if (json['under_process_la'] != null) {
    //   underProcessLa = new List<UnderProcessLa>();
    //   json['under_process_la'].forEach((v) {
    //     underProcessLa.add(new UnderProcessLa.fromJson(v));
    //   });
    // }
    // if (json['actionable_loans'] != null) {
    //   actionableLoans = new List<ActionableLoans>();
    //   json['actionable_loans'].forEach((v) {
    //     actionableLoans.add(new ActionableLoans.fromJson(v));
    //   });
    // }
    // if (json['active_loans'] != null) {
    //   activeLoans = new List<ActiveLoans>();
    //   json['active_loans'].forEach((v) {
    //     activeLoans.add(new ActiveLoans.fromJson(v));
    //   });
    // }
    pendingEsignsList = json['pending_esigns_list'] != null
        ? new PendingEsignsList.fromJson(json['pending_esigns_list'])
        : null;
    if (json['youtube_video_ids'] != null) {
      youtubeID = <String>[];
      json['youtube_video_ids'].forEach((v) {
        youtubeID!.add(v);
      });
    }
    // if (json['sell_collateral_list'] != null) {
    //   sellCollateralList = new List<SellCollateralList>();
    //   json['sell_collateral_list'].forEach((v) { sellCollateralList.add(new SellCollateralList.fromJson(v)); });
    // }
    // if (json['increase_loan_list'] != null) {
    //   increaseLoanList = new List<IncreaseLoanList>();
    //   json['increase_loan_list'].forEach((v) { increaseLoanList.add(new IncreaseLoanList.fromJson(v)); });
    // }
    // if (json['unpledge_application_list'] != null) {
    //   unpledgeApplicationList = new List<UnpledgeApplicationList>();
    //   json['unpledge_application_list'].forEach((v) {
    //     unpledgeApplicationList.add(new UnpledgeApplicationList.fromJson(v));
    //   });
    // }
    showFeedbackPopup = json['show_feedback_popup'];
    profilePhotoUrl = json['profile_picture_file_url'];
    fCMUnreadCount = json['fcm_unread_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.userKyc != null) {
      data['user_kyc'] = this.userKyc!.toJson();
    }
    if (this.marginShortfallCard != null) {
      data['margin_shortfall_card'] = this.marginShortfallCard!.toJson();
      // data['margin_shortfall_card'] =
      //     this.marginShortfallCard.map((v) => v.toJson()).toList();
    }
    if (this.totalInterestAllLoansCard != null) {
      data['total_interest_all_loans_card'] = this.totalInterestAllLoansCard!.toJson();
    }
    // if (this.totalInterestAllLoansCard != null) {
    //   data['total_interest_all_loans_card'] =
    //       this.totalInterestAllLoansCard.map((v) => v.toJson()).toList();
    // }
    // if (this.underProcessLa != null) {
    //   data['under_process_la'] =
    //       this.underProcessLa.map((v) => v.toJson()).toList();
    // }
    // if (this.actionableLoans != null) {
    //   data['actionable_loans'] =
    //       this.actionableLoans.map((v) => v.toJson()).toList();
    // }
    // if (this.activeLoans != null) {
    //   data['active_loans'] = this.activeLoans.map((v) => v.toJson()).toList();
    // }
    if (this.pendingEsignsList != null) {
      data['pending_esigns_list'] = this.pendingEsignsList!.toJson();
    }
    if (this.youtubeID != null) {
      data['youtube_video_ids'] = this.youtubeID!.map((v) => v).toList();
    }
    // if (this.sellCollateralList != null) {
    //   data['sell_collateral_list'] = this.sellCollateralList.map((v) => v.toJson()).toList();
    // }
    // if (this.increaseLoanList != null) {
    //   data['increase_loan_list'] = this.increaseLoanList.map((v) => v.toJson()).toList();
    // }
    // if (this.unpledgeApplicationList != null) {
    //   data['unpledge_application_list'] =
    //       this.unpledgeApplicationList.map((v) => v.toJson()).toList();
    // }
    data['show_feedback_popup'] = this.showFeedbackPopup;
    data['profile_picture_file_url'] = this.profilePhotoUrl;
    data['fcm_unread_count'] = this.fCMUnreadCount;
    return data;
  }
}

class Customer {
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

  Customer(
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
        this.doctype});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    registeration = json['registeration'];
    isEmailVerified = json['is_email_verified'];
    kycUpdate = json['kyc_update'];
    bankUpdate = json['bank_update'];
    creditCheck = json['credit_check'];
    pledgeSecurities = json['pledge_securities'];
    loanOpen = json['loan_open'];
    choiceKyc = json['choice_kyc'];
    ckcy = json['ckcy'];
    kra = json['kra'];
    firstName = json['first_name'];
    phone = json['phone'];
    fullName = json['full_name'];
    lastName = json['last_name'];
    user = json['user'];
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
    data['registeration'] = this.registeration;
    data['is_email_verified'] = this.isEmailVerified;
    data['kyc_update'] = this.kycUpdate;
    data['bank_update'] = this.bankUpdate;
    data['credit_check'] = this.creditCheck;
    data['pledge_securities'] = this.pledgeSecurities;
    data['loan_open'] = this.loanOpen;
    data['choice_kyc'] = this.choiceKyc;
    data['ckcy'] = this.ckcy;
    data['kra'] = this.kra;
    data['first_name'] = this.firstName;
    data['phone'] = this.phone;
    data['full_name'] = this.fullName;
    data['last_name'] = this.lastName;
    data['user'] = this.user;
    data['doctype'] = this.doctype;
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

class MarginShortfallCard {
  String? earliestDeadline;
  List<LoanWithMarginShortfallList>? loanWithMarginShortfallList;

  MarginShortfallCard(
      {this.earliestDeadline, this.loanWithMarginShortfallList});

  MarginShortfallCard.fromJson(Map<String, dynamic> json) {
    earliestDeadline = json['earliest_deadline'];
    if (json['loan_with_margin_shortfall_list'] != null) {
      loanWithMarginShortfallList = <LoanWithMarginShortfallList>[];
      json['loan_with_margin_shortfall_list'].forEach((v) {
        loanWithMarginShortfallList!
            .add(new LoanWithMarginShortfallList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['earliest_deadline'] = this.earliestDeadline;
    if (this.loanWithMarginShortfallList != null) {
      data['loan_with_margin_shortfall_list'] =
          this.loanWithMarginShortfallList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoanWithMarginShortfallList {
  String? name;
  String? deadline;
  String? status;
  int? isTodayHoliday;

  LoanWithMarginShortfallList({this.name, this.deadline, this.status, this.isTodayHoliday});

  LoanWithMarginShortfallList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    deadline = json['deadline'];
    status = json['status'];
    isTodayHoliday = json['is_today_holiday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['deadline'] = this.deadline;
    data['status'] = this.status;
    data['is_today_holiday'] = this.isTodayHoliday;
    return data;
  }
}

class TotalInterestAllLoansCard {
  String? totalInterestAmount;
  LoansInterestDueDate? loansInterestDueDate;
  List<InterestLoanList>? interestLoanList;

  TotalInterestAllLoansCard(
      {this.totalInterestAmount,
        this.loansInterestDueDate,
        this.interestLoanList});

  TotalInterestAllLoansCard.fromJson(Map<String, dynamic> json) {
    totalInterestAmount = json['total_interest_amount'];
    loansInterestDueDate = json['loans_interest_due_date'] != null
        ? new LoansInterestDueDate.fromJson(json['loans_interest_due_date'])
        : null;
    if (json['interest_loan_list'] != null) {
      interestLoanList = <InterestLoanList>[];
      json['interest_loan_list'].forEach((v) {
        interestLoanList!.add(new InterestLoanList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_interest_amount'] = this.totalInterestAmount;
    if (this.loansInterestDueDate != null) {
      data['loans_interest_due_date'] = this.loansInterestDueDate!.toJson();
    }
    if (this.interestLoanList != null) {
      data['interest_loan_list'] =
          this.interestLoanList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoansInterestDueDate {
  String? dueDate;
  String? dueDateTxt;
  int? dpdTxt;

  LoansInterestDueDate({this.dueDate, this.dueDateTxt, this.dpdTxt});

  LoansInterestDueDate.fromJson(Map<String, dynamic> json) {
    dueDate = json['due_date'];
    dueDateTxt = json['due_date_txt'];
    dpdTxt = json['dpd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['due_date'] = this.dueDate;
    data['due_date_txt'] = this.dueDateTxt;
    data['dpd'] = this.dpdTxt;
    return data;
  }
}

class InterestLoanList {
  String? loanName;
  double? interestAmount;

  InterestLoanList({this.loanName, this.interestAmount});

  InterestLoanList.fromJson(Map<String, dynamic> json) {
    loanName = json['loan_name'];
    interestAmount = json['interest_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_name'] = this.loanName;
    data['interest_amount'] = this.interestAmount;
    return data;
  }
}

class PendingEsignsList {
  List<LaPendingEsigns>? laPendingEsigns;
  List<TopupPendingEsigns>? topupPendingEsigns;
  List<LoanRenewalEsigns>? loanRenewalEsigns;

  PendingEsignsList({this.laPendingEsigns, this.topupPendingEsigns, this.loanRenewalEsigns});

  PendingEsignsList.fromJson(Map<String, dynamic> json) {
    if (json['la_pending_esigns'] != null) {
      laPendingEsigns = <LaPendingEsigns>[];
      json['la_pending_esigns'].forEach((v) {
        laPendingEsigns!.add(new LaPendingEsigns.fromJson(v));
      });
    }
    if (json['topup_pending_esigns'] != null) {
      topupPendingEsigns = <TopupPendingEsigns>[];
      json['topup_pending_esigns'].forEach((v) {
        topupPendingEsigns!.add(new TopupPendingEsigns.fromJson(v));
      });
    }
    if (json['loan_renewal_esigns'] != null) {
      loanRenewalEsigns = <LoanRenewalEsigns>[];
      json['loan_renewal_esigns'].forEach((v) {
        loanRenewalEsigns!.add(new LoanRenewalEsigns.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.laPendingEsigns != null) {
      data['la_pending_esigns'] =
          this.laPendingEsigns!.map((v) => v.toJson()).toList();
    }
    if (this.topupPendingEsigns != null) {
      data['topup_pending_esigns'] =
          this.topupPendingEsigns!.map((v) => v.toJson()).toList();
    }
    if (this.loanRenewalEsigns != null) {
      data['loan_renewal_esigns'] =
          this.loanRenewalEsigns!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LaPendingEsigns {
  LoanApplication? loanApplication;
  String? message;
  IncreaseLoanMessage? increaseLoanMessage;
  SanctionLetter? sanctionLetter;

  LaPendingEsigns({this.loanApplication, this.message, this.increaseLoanMessage, this.sanctionLetter});

  LaPendingEsigns.fromJson(Map<String, dynamic> json) {
    loanApplication = json['loan_application'] != null
        ? new LoanApplication.fromJson(json['loan_application'])
        : null;
    message = json['message'];
    increaseLoanMessage = json['increase_loan_message'] != null
        ? new IncreaseLoanMessage.fromJson(json['increase_loan_message'])
        : null;
    sanctionLetter = json['sanction_letter'] != null ? new SanctionLetter.fromJson(json['sanction_letter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loanApplication != null) {
      data['loan_application'] = this.loanApplication!.toJson();
    }
    data['message'] = this.message;
    if (this.increaseLoanMessage != null) {
      data['increase_loan_message'] = this.increaseLoanMessage!.toJson();
    }
    data['sanction_letter'] = this.sanctionLetter!.toJson();
    return data;
  }
}

class SanctionLetter {
  String? sanctionLetter;

  SanctionLetter({this.sanctionLetter});

  SanctionLetter.fromJson(Map<String, dynamic> json) {
    sanctionLetter = json['sanction_letter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sanction_letter'] = this.sanctionLetter;
    return data;
  }
}

class IncreaseLoanMessage {
  double? existingLimit;
  double? existingCollateralValue;
  double? newLimit;
  double? newCollateralValue;

  IncreaseLoanMessage(
      {this.existingLimit,
        this.existingCollateralValue,
        this.newLimit,
        this.newCollateralValue});

  IncreaseLoanMessage.fromJson(Map<String, dynamic> json) {
    existingLimit = json['existing_limit'];
    existingCollateralValue = json['existing_collateral_value'];
    newLimit = json['new_limit'];
    newCollateralValue = json['new_collateral_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['existing_limit'] = this.existingLimit;
    data['existing_collateral_value'] = this.existingCollateralValue;
    data['new_limit'] = this.newLimit;
    data['new_collateral_value'] = this.newCollateralValue;
    return data;
  }
}

class LoanApplication {
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
  List<CommonItems>? items;

  LoanApplication(
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

  LoanApplication.fromJson(Map<String, dynamic> json) {
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
      totalCollateralValue = json['total_collateral_value'];
      totalCollateralValueStr = json['total_collateral_value_str'];
      drawingPower = json['drawing_power'];
      drawingPowerStr = json['drawing_power_str'];
      lender = json['lender'];
      status = json['status'];
      pledgedTotalCollateralValue = json['pledged_total_collateral_value'];
      pledgedTotalCollateralValueStr =
      json['pledged_total_collateral_value_str'];
      loanMarginShortfall = json['loan_margin_shortfall'];
      customer = json['customer'];
      customerName = json['customer_name'];
      allowableLtv = json['allowable_ltv'];
      expiryDate = json['expiry_date'];
      loan = json['loan'];
      pledgeStatus = json['pledge_status'];
      // nUserTags = json['_user_tags'];
      // nComments = json['_comments'];
      // nAssign = json['_assign'];
      // nLikedBy = json['_liked_by'];
      workflowState = json['workflow_state'];
      pledgorBoid = json['pledgor_boid'];
      pledgeeBoid = json['pledgee_boid'];
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
    data['total_collateral_value'] = this.totalCollateralValue;
    data['total_collateral_value_str'] = this.totalCollateralValueStr;
    data['drawing_power'] = this.drawingPower;
    data['drawing_power_str'] = this.drawingPowerStr;
    data['lender'] = this.lender;
    data['status'] = this.status;
    data['pledged_total_collateral_value'] = this.pledgedTotalCollateralValue;
    data['pledged_total_collateral_value_str'] =
        this.pledgedTotalCollateralValueStr;
    data['loan_margin_shortfall'] = this.loanMarginShortfall;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['allowable_ltv'] = this.allowableLtv;
    data['expiry_date'] = this.expiryDate;
    data['loan'] = this.loan;
    data['pledge_status'] = this.pledgeStatus;
    // data['_user_tags'] = this.nUserTags;
    // data['_comments'] = this.nComments;
    // data['_assign'] = this.nAssign;
    // data['_liked_by'] = this.nLikedBy;
    data['workflow_state'] = this.workflowState;
    data['pledgor_boid'] = this.pledgorBoid;
    data['pledgee_boid'] = this.pledgeeBoid;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonItems {
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

  CommonItems(
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

  CommonItems.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    creation = json['creation'];
    docstatus = json['docstatus'];
    doctype = json['doctype'];
    errorCode = json['error_code'];
    idx = json['idx'];
    isin = json['isin'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    name = json['name'];
    owner = json['owner'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    pledgedQuantity = json['pledged_quantity'];
    price = json['price'];
    psn = json['psn'];
    securityCategory = json['security_category'];
    securityName = json['security_name'];
    lenderApprovalStatus = json['lender_approval_status'];
    folio = json['folio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['creation'] = this.creation;
    data['docstatus'] = this.docstatus;
    data['doctype'] = this.doctype;
    data['error_code'] = this.errorCode;
    data['idx'] = this.idx;
    data['isin'] = this.isin;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['pledged_quantity'] = this.pledgedQuantity;
    data['price'] = this.price;
    data['psn'] = this.psn;
    data['security_category'] = this.securityCategory;
    data['security_name'] = this.securityName;
    data['lender_approval_status'] = this.lenderApprovalStatus;
    data['folio'] = this.folio;
    return data;
  }
}

class TopupPendingEsigns {
  TopupApplicationDoc? topupApplicationDoc;
  String? mess;
  SanctionLetter? sanctionLetter;

  TopupPendingEsigns({this.topupApplicationDoc, this.mess, this.sanctionLetter});

  TopupPendingEsigns.fromJson(Map<String, dynamic> json) {
    topupApplicationDoc = json['topup_application_doc'] != null
        ? new TopupApplicationDoc.fromJson(json['topup_application_doc'])
        : null;
    mess = json['mess'];
    sanctionLetter = json['sanction_letter'] != null ? new SanctionLetter.fromJson(json['sanction_letter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topupApplicationDoc != null) {
      data['topup_application_doc'] = this.topupApplicationDoc!.toJson();
    }
    data['mess'] = this.mess;
    data['sanction_letter'] = this.sanctionLetter!.toJson();

    return data;
  }
}

class LoanRenewalEsigns {
  LoanRenewalApplicationDoc? loanRenewalApplicationDoc;
  String? mess;
  List<CommonItems>? loanItems;
  SanctionLetter? sanctionLetter;

  LoanRenewalEsigns({this.loanRenewalApplicationDoc, this.mess, this.loanItems, this.sanctionLetter});

  LoanRenewalEsigns.fromJson(Map<String, dynamic> json) {
    loanRenewalApplicationDoc = json['loan_renewal_application_doc'] != null
        ? new LoanRenewalApplicationDoc.fromJson(
        json['loan_renewal_application_doc'])
        : null;
    mess = json['mess'];
    if (json['loan_items'] != null) {
      loanItems = <CommonItems>[];
      json['loan_items'].forEach((v) { loanItems!.add(new CommonItems.fromJson(v)); });
    }
    sanctionLetter = json['sanction_letter'] != null ? new SanctionLetter.fromJson(json['sanction_letter']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.loanRenewalApplicationDoc != null) {
      data['loan_renewal_application_doc'] =
          this.loanRenewalApplicationDoc!.toJson();
    }
    data['mess'] = this.mess;
    if (this.loanItems != null) {
      data['loan_items'] = this.loanItems!.map((v) => v.toJson()).toList();
    }
    data['sanction_letter'] = this.sanctionLetter!.toJson();
    return data;
  }
}

class LoanRenewalApplicationDoc {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  Null? parent;
  Null? parentfield;
  Null? parenttype;
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

  LoanRenewalApplicationDoc(
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

  LoanRenewalApplicationDoc.fromJson(Map<String, dynamic> json) {
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
    workflowState = json['workflow_state'];
    loan = json['loan'];
    lender = json['lender'];
    oldKycName = json['old_kyc_name'];
    newKycName = json['new_kyc_name'];
    updatedKycStatus = json['updated_kyc_status'];
    totalCollateralValue = json['total_collateral_value'];
    sanctionedLimit = json['sanctioned_limit'];
    expiryDate = json['expiry_date'];
    tncComplete = json['tnc_complete'];
    reminders = json['reminders'];
    status = json['status'];
    customer = json['customer'];
    customerName = json['customer_name'];
    drawingPower = json['drawing_power'];
    isExpired = json['is_expired'];
    customerEsignedDocument = json['customer_esigned_document'];
    lenderEsignedDocument = json['lender_esigned_document'];
    remarks = json['remarks'];
    doctype = json['doctype'];
    topUpAmount = json['top_up_amount'];
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
    data['workflow_state'] = this.workflowState;
    data['loan'] = this.loan;
    data['lender'] = this.lender;
    data['old_kyc_name'] = this.oldKycName;
    data['new_kyc_name'] = this.newKycName;
    data['updated_kyc_status'] = this.updatedKycStatus;
    data['total_collateral_value'] = this.totalCollateralValue;
    data['sanctioned_limit'] = this.sanctionedLimit;
    data['expiry_date'] = this.expiryDate;
    data['tnc_complete'] = this.tncComplete;
    data['reminders'] = this.reminders;
    data['status'] = this.status;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['drawing_power'] = this.drawingPower;
    data['is_expired'] = this.isExpired;
    data['customer_esigned_document'] = this.customerEsignedDocument;
    data['lender_esigned_document'] = this.lenderEsignedDocument;
    data['remarks'] = this.remarks;
    data['doctype'] = this.doctype;
    data['top_up_amount'] = this.topUpAmount;
    return data;
  }
}

class TopupApplicationDoc  {
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

  TopupApplicationDoc (
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

  TopupApplicationDoc.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    workflowState = json['workflow_state'];
    loan = json['loan'];
    topUpAmount = json['top_up_amount'];
    sanctionedLimit = json['sanctioned_limit'];
    time = json['time'];
    status = json['status'];
    customer = json['customer'];
    customerName = json['customer_name'];
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
    data['workflow_state'] = this.workflowState;
    data['loan'] = this.loan;
    data['top_up_amount'] = this.topUpAmount;
    data['sanctioned_limit'] = this.sanctionedLimit;
    data['time'] = this.time;
    data['status'] = this.status;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['doctype'] = this.doctype;
    return data;
  }
}




// class UnderProcessLa {
//   String name;
//   String status;
//
//   UnderProcessLa({this.name, this.status});
//
//   UnderProcessLa.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     status = json['status'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['status'] = this.status;
//     return data;
//   }
// }
//
// class ActionableLoans {
//   String loanName;
//   double drawingPower;
//   double balance;
//   String drawingPowerstr;
//   String balancestr;
//
//   ActionableLoans({this.loanName, this.drawingPower, this.balance,this.drawingPowerstr, this.balancestr});
//
//   ActionableLoans.fromJson(Map<String, dynamic> json) {
//     loanName = json['loan_name'];
//     drawingPower = json['drawing_power'];
//     drawingPowerstr = json['drawing_power_str'];
//     balance = json['balance'];
//     balancestr = json['balance_str'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['loan_name'] = this.loanName;
//     data['drawing_power_str'] = this.drawingPowerstr;
//     data['balance'] = this.balance;
//     data['balance_str'] = this.balancestr;
//     return data;
//   }
// }
//
// class ActiveLoans {
//   String name;
//   double drawingPower;
//   double balance;
//   String drawingPowerstr;
//   String balancestr;
//
//   ActiveLoans({this.name, this.drawingPower, this.balance,this.drawingPowerstr, this.balancestr});
//
//   ActiveLoans.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     drawingPower = json['drawing_power'];
//     drawingPowerstr = json['drawing_power_str'];
//     balance = json['balance'];
//     balancestr = json['balance_str'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['drawing_power_str'] = this.drawingPowerstr;
//     data['balance'] = this.balance;
//     data['balance_str'] = this.balancestr;
//     return data;
//   }
// }
//
// class DashboardTopUp {
//   String loan;
//   double minimumTopUpAmount;
//   double topUpAmount;
//
//   DashboardTopUp({this.loan, this.minimumTopUpAmount, this.topUpAmount});
//
//   DashboardTopUp.fromJson(Map<String, dynamic> json) {
//     loan = json['loan'];
//     minimumTopUpAmount = json['minimum_top_up_amount'];
//     topUpAmount = json['top_up_amount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['loan'] = this.loan;
//     data['minimum_top_up_amount'] = this.minimumTopUpAmount;
//     data['top_up_amount'] = this.topUpAmount;
//     return data;
//   }
// }
//
// class SellCollateralList {
//   String loanName;
//   SellCollateralAvailable sellCollateralAvailable;
//
//   SellCollateralList({this.loanName, this.sellCollateralAvailable});
//
//   SellCollateralList.fromJson(Map<String, dynamic> json) {
//     loanName = json['loan_name'];
//     sellCollateralAvailable = json['sell_collateral_available'] != null
//         ? new SellCollateralAvailable.fromJson(
//         json['sell_collateral_available'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['loan_name'] = this.loanName;
//     if (this.sellCollateralAvailable != null) {
//       data['sell_collateral_available'] = this.sellCollateralAvailable.toJson();
//     }
//     return data;
//   }
// }
//
// class SellCollateralAvailable {
//   String name;
//   String creation;
//   String modified;
//   String modifiedBy;
//   String owner;
//   int docstatus;
//   Null parent;
//   Null parentfield;
//   Null parenttype;
//   int idx;
//   String loan;
//   double totalCollateralValue;
//   String lender;
//   String customer;
//   double sellingCollateralValue;
//   Null amendedFrom;
//   String status;
//   Null nUserTags;
//   Null nComments;
//   Null nAssign;
//   Null nLikedBy;
//   String workflowState;
//   String loanMarginShortfall;
//   List<SellItems> sellItems;
//
//   SellCollateralAvailable(
//       {this.name,
//         this.creation,
//         this.modified,
//         this.modifiedBy,
//         this.owner,
//         this.docstatus,
//         this.parent,
//         this.parentfield,
//         this.parenttype,
//         this.idx,
//         this.loan,
//         this.totalCollateralValue,
//         this.lender,
//         this.customer,
//         this.sellingCollateralValue,
//         this.amendedFrom,
//         this.status,
//         this.nUserTags,
//         this.nComments,
//         this.nAssign,
//         this.nLikedBy,
//         this.workflowState,
//         this.loanMarginShortfall,
//         this.sellItems});
//
//   SellCollateralAvailable.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     creation = json['creation'];
//     modified = json['modified'];
//     modifiedBy = json['modified_by'];
//     owner = json['owner'];
//     docstatus = json['docstatus'];
//     parent = json['parent'];
//     parentfield = json['parentfield'];
//     parenttype = json['parenttype'];
//     idx = json['idx'];
//     loan = json['loan'];
//     totalCollateralValue = json['total_collateral_value'];
//     lender = json['lender'];
//     customer = json['customer'];
//     sellingCollateralValue = json['selling_collateral_value'];
//     amendedFrom = json['amended_from'];
//     status = json['status'];
//     nUserTags = json['_user_tags'];
//     nComments = json['_comments'];
//     nAssign = json['_assign'];
//     nLikedBy = json['_liked_by'];
//     workflowState = json['workflow_state'];
//     loanMarginShortfall = json['loan_margin_shortfall'];
//     if (json['items'] != null) {
//       sellItems = new List<SellItems>();
//       json['items'].forEach((v) {
//         sellItems.add(new SellItems.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['creation'] = this.creation;
//     data['modified'] = this.modified;
//     data['modified_by'] = this.modifiedBy;
//     data['owner'] = this.owner;
//     data['docstatus'] = this.docstatus;
//     data['parent'] = this.parent;
//     data['parentfield'] = this.parentfield;
//     data['parenttype'] = this.parenttype;
//     data['idx'] = this.idx;
//     data['loan'] = this.loan;
//     data['total_collateral_value'] = this.totalCollateralValue;
//     data['lender'] = this.lender;
//     data['customer'] = this.customer;
//     data['selling_collateral_value'] = this.sellingCollateralValue;
//     data['amended_from'] = this.amendedFrom;
//     data['status'] = this.status;
//     data['_user_tags'] = this.nUserTags;
//     data['_comments'] = this.nComments;
//     data['_assign'] = this.nAssign;
//     data['_liked_by'] = this.nLikedBy;
//     data['workflow_state'] = this.workflowState;
//     data['loan_margin_shortfall'] = this.loanMarginShortfall;
//     if (this.sellItems != null) {
//       data['items'] = this.sellItems.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class SellItems {
//   String name;
//   String creation;
//   String modified;
//   String modifiedBy;
//   String owner;
//   int docstatus;
//   String parent;
//   String parentfield;
//   String parenttype;
//   int idx;
//   String isin;
//   String securityName;
//   int quantity;
//   double price;
//   double amount;
//
//   SellItems(
//       {this.name,
//         this.creation,
//         this.modified,
//         this.modifiedBy,
//         this.owner,
//         this.docstatus,
//         this.parent,
//         this.parentfield,
//         this.parenttype,
//         this.idx,
//         this.isin,
//         this.securityName,
//         this.quantity,
//         this.price,
//         this.amount});
//
//   SellItems.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     creation = json['creation'];
//     modified = json['modified'];
//     modifiedBy = json['modified_by'];
//     owner = json['owner'];
//     docstatus = json['docstatus'];
//     parent = json['parent'];
//     parentfield = json['parentfield'];
//     parenttype = json['parenttype'];
//     idx = json['idx'];
//     isin = json['isin'];
//     securityName = json['security_name'];
//     quantity = json['quantity'];
//     price = json['price'];
//     amount = json['amount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['creation'] = this.creation;
//     data['modified'] = this.modified;
//     data['modified_by'] = this.modifiedBy;
//     data['owner'] = this.owner;
//     data['docstatus'] = this.docstatus;
//     data['parent'] = this.parent;
//     data['parentfield'] = this.parentfield;
//     data['parenttype'] = this.parenttype;
//     data['idx'] = this.idx;
//     data['isin'] = this.isin;
//     data['security_name'] = this.securityName;
//     data['quantity'] = this.quantity;
//     data['price'] = this.price;
//     data['amount'] = this.amount;
//     return data;
//   }
// }
//
// class IncreaseLoanList {
//   String loanName;
//   int increaseLoanAvailable;
//
//   IncreaseLoanList({this.loanName, this.increaseLoanAvailable});
//
//   IncreaseLoanList.fromJson(Map<String, dynamic> json) {
//     loanName = json['loan_name'];
//     increaseLoanAvailable = json['increase_loan_available'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['loan_name'] = this.loanName;
//     data['increase_loan_available'] = this.increaseLoanAvailable;
//     return data;
//   }
// }
//
// class UnpledgeApplicationList {
//   String loanName;
//   UnpledgeApplicationAvailable unpledgeApplicationAvailable;
//   String unpledgeMsgWhileMarginShortfall;
//   Unpledge unpledge;
//
//   UnpledgeApplicationList(
//       {this.loanName,
//         this.unpledgeApplicationAvailable,
//         this.unpledgeMsgWhileMarginShortfall,
//         this.unpledge});
//
//   UnpledgeApplicationList.fromJson(Map<String, dynamic> json) {
//     loanName = json['loan_name'];
//     unpledgeApplicationAvailable =
//     json['unpledge_application_available'] != null
//         ? new UnpledgeApplicationAvailable.fromJson(
//         json['unpledge_application_available'])
//         : null;
//     unpledgeMsgWhileMarginShortfall =
//     json['unpledge_msg_while_margin_shortfall'];
//     unpledge = json['unpledge'] != null
//         ? new Unpledge.fromJson(json['unpledge'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['loan_name'] = this.loanName;
//     if (this.unpledgeApplicationAvailable != null) {
//       data['unpledge_application_available'] =
//           this.unpledgeApplicationAvailable.toJson();
//     }
//     data['unpledge_msg_while_margin_shortfall'] =
//         this.unpledgeMsgWhileMarginShortfall;
//     if (this.unpledge != null) {
//       data['unpledge'] = this.unpledge.toJson();
//     }
//     return data;
//   }
// }
//
// class UnpledgeApplicationAvailable {
//   String name;
//   String creation;
//   String modified;
//   String modifiedBy;
//   String owner;
//   int docstatus;
//   Null parent;
//   Null parentfield;
//   Null parenttype;
//   int idx;
//   String loan;
//   Null nUserTags;
//   Null nComments;
//   Null nAssign;
//   Null nLikedBy;
//   String workflowState;
//   double totalCollateralValue;
//   String lender;
//   String customer;
//   double unpledgeCollateralValue;
//   String status;
//   Null amendedFrom;
//   List<UnpledgedItems> unpledgedItems;
//
//   UnpledgeApplicationAvailable(
//       {this.name,
//         this.creation,
//         this.modified,
//         this.modifiedBy,
//         this.owner,
//         this.docstatus,
//         this.parent,
//         this.parentfield,
//         this.parenttype,
//         this.idx,
//         this.loan,
//         this.nUserTags,
//         this.nComments,
//         this.nAssign,
//         this.nLikedBy,
//         this.workflowState,
//         this.totalCollateralValue,
//         this.lender,
//         this.customer,
//         this.unpledgeCollateralValue,
//         this.status,
//         this.amendedFrom,
//         this.unpledgedItems});
//
//   UnpledgeApplicationAvailable.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     creation = json['creation'];
//     modified = json['modified'];
//     modifiedBy = json['modified_by'];
//     owner = json['owner'];
//     docstatus = json['docstatus'];
//     parent = json['parent'];
//     parentfield = json['parentfield'];
//     parenttype = json['parenttype'];
//     idx = json['idx'];
//     loan = json['loan'];
//     nUserTags = json['_user_tags'];
//     nComments = json['_comments'];
//     nAssign = json['_assign'];
//     nLikedBy = json['_liked_by'];
//     workflowState = json['workflow_state'];
//     totalCollateralValue = json['total_collateral_value'];
//     lender = json['lender'];
//     customer = json['customer'];
//     unpledgeCollateralValue = json['unpledge_collateral_value'];
//     status = json['status'];
//     amendedFrom = json['amended_from'];
//     if (json['items'] != null) {
//       unpledgedItems = new List<UnpledgedItems>();
//       json['items'].forEach((v) {
//         unpledgedItems.add(new UnpledgedItems.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['creation'] = this.creation;
//     data['modified'] = this.modified;
//     data['modified_by'] = this.modifiedBy;
//     data['owner'] = this.owner;
//     data['docstatus'] = this.docstatus;
//     data['parent'] = this.parent;
//     data['parentfield'] = this.parentfield;
//     data['parenttype'] = this.parenttype;
//     data['idx'] = this.idx;
//     data['loan'] = this.loan;
//     data['_user_tags'] = this.nUserTags;
//     data['_comments'] = this.nComments;
//     data['_assign'] = this.nAssign;
//     data['_liked_by'] = this.nLikedBy;
//     data['workflow_state'] = this.workflowState;
//     data['total_collateral_value'] = this.totalCollateralValue;
//     data['lender'] = this.lender;
//     data['customer'] = this.customer;
//     data['unpledge_collateral_value'] = this.unpledgeCollateralValue;
//     data['status'] = this.status;
//     data['amended_from'] = this.amendedFrom;
//     if (this.unpledgedItems != null) {
//       data['items'] =
//           this.unpledgedItems.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class UnpledgedItems {
//   String name;
//   String creation;
//   String modified;
//   String modifiedBy;
//   String owner;
//   int docstatus;
//   String parent;
//   String parentfield;
//   String parenttype;
//   int idx;
//   String isin;
//   int unpledgedQuantity;
//   String securityName;
//   int quantity;
//   double price;
//   double amount;
//
//   UnpledgedItems(
//       {this.name,
//         this.creation,
//         this.modified,
//         this.modifiedBy,
//         this.owner,
//         this.docstatus,
//         this.parent,
//         this.parentfield,
//         this.parenttype,
//         this.idx,
//         this.isin,
//         this.unpledgedQuantity,
//         this.securityName,
//         this.quantity,
//         this.price,
//         this.amount});
//
//   UnpledgedItems.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     creation = json['creation'];
//     modified = json['modified'];
//     modifiedBy = json['modified_by'];
//     owner = json['owner'];
//     docstatus = json['docstatus'];
//     parent = json['parent'];
//     parentfield = json['parentfield'];
//     parenttype = json['parenttype'];
//     idx = json['idx'];
//     isin = json['isin'];
//     unpledgedQuantity = json['unpledged_quantity'];
//     securityName = json['security_name'];
//     quantity = json['quantity'];
//     price = json['price'];
//     amount = json['amount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['creation'] = this.creation;
//     data['modified'] = this.modified;
//     data['modified_by'] = this.modifiedBy;
//     data['owner'] = this.owner;
//     data['docstatus'] = this.docstatus;
//     data['parent'] = this.parent;
//     data['parentfield'] = this.parentfield;
//     data['parenttype'] = this.parenttype;
//     data['idx'] = this.idx;
//     data['isin'] = this.isin;
//     data['unpledged_quantity'] = this.unpledgedQuantity;
//     data['security_name'] = this.securityName;
//     data['quantity'] = this.quantity;
//     data['price'] = this.price;
//     data['amount'] = this.amount;
//     return data;
//   }
// }
//
// class Unpledge {
//   double minimumCollateralValue;
//   double maximumUnpledgeAmount;
//
//   Unpledge({this.minimumCollateralValue, this.maximumUnpledgeAmount});
//
//   Unpledge.fromJson(Map<String, dynamic> json) {
//     minimumCollateralValue = json['minimum_collateral_value'];
//     maximumUnpledgeAmount = json['maximum_unpledge_amount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['minimum_collateral_value'] = this.minimumCollateralValue;
//     data['maximum_unpledge_amount'] = this.maximumUnpledgeAmount;
//     return data;
//   }
// }