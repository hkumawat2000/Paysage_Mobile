import 'package:lms/network/ModelWrapper.dart';

class AdditionalAccountResponse extends ModelWrapper{
  String? message;
  AccountData? accountData;

  AdditionalAccountResponse({this.message, this.accountData});

  AdditionalAccountResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accountData = json['data'] != null ? new AccountData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.accountData != null) {
      data['data'] = this.accountData!.toJson();
    }
    return data;
  }
}

class AccountData {
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
  String? ckcy;
  String? kra;
  String? firstName;
  String? phone;
  String? mycamsEmailId;
  String? fullName;
  String? lastName;
  String? user;
  int? alertsBasedOnPercentage;
  int? alertsBasedOnAmount;
  String? doctype;

  AccountData(
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
        this.creditCheck,
        this.pledgeSecurities,
        this.loanOpen,
        this.feedbackSubmitted,
        this.feedbackDoNotShowPopup,
        this.ckcy,
        this.kra,
        this.firstName,
        this.phone,
        this.mycamsEmailId,
        this.fullName,
        this.lastName,
        this.user,
        this.alertsBasedOnPercentage,
        this.alertsBasedOnAmount,
        this.doctype});

  AccountData.fromJson(Map<String, dynamic> json) {
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
    creditCheck = json['credit_check'];
    pledgeSecurities = json['pledge_securities'];
    loanOpen = json['loan_open'];
    feedbackSubmitted = json['feedback_submitted'];
    feedbackDoNotShowPopup = json['feedback_do_not_show_popup'];
    ckcy = json['ckcy'];
    kra = json['kra'];
    firstName = json['first_name'];
    phone = json['phone'];
    mycamsEmailId = json['mycams_email_id'];
    fullName = json['full_name'];
    lastName = json['last_name'];
    user = json['user'];
    alertsBasedOnPercentage = json['alerts_based_on_percentage'];
    alertsBasedOnAmount = json['alerts_based_on_amount'];
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
    data['credit_check'] = this.creditCheck;
    data['pledge_securities'] = this.pledgeSecurities;
    data['loan_open'] = this.loanOpen;
    data['feedback_submitted'] = this.feedbackSubmitted;
    data['feedback_do_not_show_popup'] = this.feedbackDoNotShowPopup;
    data['ckcy'] = this.ckcy;
    data['kra'] = this.kra;
    data['first_name'] = this.firstName;
    data['phone'] = this.phone;
    data['mycams_email_id'] = this.mycamsEmailId;
    data['full_name'] = this.fullName;
    data['last_name'] = this.lastName;
    data['user'] = this.user;
    data['alerts_based_on_percentage'] = this.alertsBasedOnPercentage;
    data['alerts_based_on_amount'] = this.alertsBasedOnAmount;
    data['doctype'] = this.doctype;
    return data;
  }
}
