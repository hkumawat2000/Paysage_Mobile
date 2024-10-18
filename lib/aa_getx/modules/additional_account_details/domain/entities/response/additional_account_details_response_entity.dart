class AdditionalAccountResponseEntity {
  String? message;
  AccountDataResponseEntity? accountData;

  AdditionalAccountResponseEntity({this.message, this.accountData});
}

class AccountDataResponseEntity {
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

  AccountDataResponseEntity(
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
}