import 'dart:convert';

import 'package:lms/aa_getx/modules/login/domain/entity/customer_details_response_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomerDetailsResponseModel {
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
  
  CustomerDetailsResponseModel({
    this.name,
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
    this.doctype,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'owner': owner,
      'creation': creation,
      'modified': modified,
      'modified_by': modifiedBy,
      'idx': idx,
      'docstatus': docstatus,
      'registeration': registeration,
      'is_email_verified': isEmailVerified,
      'kyc_update': kycUpdate,
      'credit_check': creditCheck,
      'pledge_securities': pledgeSecurities,
      'loan_open': loanOpen,
      'feedback_submitted': feedbackSubmitted,
      'feedback_do_not_show_popup': feedbackDoNotShowPopup,
      'choice_kyc': choiceKyc,
      'ckcy': ckcy,
      'kra': kra,
      'first_name': firstName,
      'phone': phone,
      'mycams_email_id': myCamsEmailId,
      'full_name': fullName,
      'last_name': lastName,
      'user': user,
      'alerts_based_on_percentage': alertsBasedOnPercentage,
      'alerts_based_on_amount': alertsBasedOnAmount,
      'doctype': doctype,
    };
  }

  factory CustomerDetailsResponseModel.fromJson(Map<String, dynamic> map) {
    return CustomerDetailsResponseModel(
      name: map['name'] != null ? map['name'] as String : null,
      owner: map['owner'] != null ? map['owner'] as String : null,
      creation: map['creation'] != null ? map['creation'] as String : null,
      modified: map['modified'] != null ? map['modified'] as String : null,
      modifiedBy: map['modified_by'] != null ? map['modified_by'] as String : null,
      idx: map['idx'] != null ? map['idx'] as int : null,
      docstatus: map['docstatus'] != null ? map['docstatus'] as int : null,
      registeration: map['registeration'] != null ? map['registeration'] as int : null,
      isEmailVerified: map['is_email_verified'] != null ? map['is_email_verified'] as int : null,
      kycUpdate: map['kyc_update'] != null ? map['kyc_update'] as int : null,
      creditCheck: map['credit_check'] != null ? map['credit_check'] as int : null,
      pledgeSecurities: map['pledge_securities'] != null ? map['pledge_securities'] as int : null,
      loanOpen: map['loan_open'] != null ? map['loan_open'] as int : null,
      feedbackSubmitted: map['feedback_submitted'] != null ? map['feedback_submitted'] as int : null,
      feedbackDoNotShowPopup: map['feedback_do_not_show_popup'] != null ? map['feedback_do_not_show_popup'] as int : null,
      choiceKyc: map['choice_kyc'] != null ? map['choice_kyc'] as String : null,
      ckcy: map['ckcy'] != null ? map['ckcy'] as String : null,
      kra: map['kra'] != null ? map['kra'] as String : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      myCamsEmailId: map['mycams_email_id'] != null ? map['mycams_email_id'] as String : null,
      fullName: map['full_name'] != null ? map['full_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      user: map['user'] != null ? map['user'] as String : null,
      alertsBasedOnPercentage: map['alerts_based_on_percentage'] != null ? map['alerts_based_on_percentage'] as double : null,
      alertsBasedOnAmount: map['alerts_based_on_amount'] != null ? map['alerts_based_on_amount'] as double : null,
      doctype: map['doctype'] != null ? map['doctype'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory CustomerDetailsResponseModel.fromJson(String source) => CustomerDetailsResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CustomerDetailsResponseEntity toEntity() =>
  CustomerDetailsResponseEntity(
      name: name,
      owner: owner,
      creation: creation,
      modified: modified,
      modifiedBy: modifiedBy,
      idx: idx,
      docstatus: docstatus,
      registeration: registeration,
      isEmailVerified: isEmailVerified,
      kycUpdate: kycUpdate,
      creditCheck: creditCheck,
      pledgeSecurities: pledgeSecurities,
      loanOpen: loanOpen,
      feedbackSubmitted: feedbackSubmitted,
      feedbackDoNotShowPopup: feedbackDoNotShowPopup,
      choiceKyc: choiceKyc,
      ckcy: ckcy,
      kra: kra,
      firstName: firstName,
      phone: phone,
      myCamsEmailId: myCamsEmailId,
      fullName: fullName,
      lastName: lastName,
      user: user,
      alertsBasedOnPercentage: alertsBasedOnPercentage,
      alertsBasedOnAmount: alertsBasedOnAmount,
      doctype: doctype,
  
  );

  factory CustomerDetailsResponseModel.fromEntity(CustomerDetailsResponseEntity customerDetailsResponseEntity) {
    return CustomerDetailsResponseModel(
      name: customerDetailsResponseEntity.name != null ? customerDetailsResponseEntity.name as String : null,
      owner: customerDetailsResponseEntity.owner != null ? customerDetailsResponseEntity.owner as String : null,
      creation: customerDetailsResponseEntity.creation != null ? customerDetailsResponseEntity.creation as String : null,
      modified: customerDetailsResponseEntity.modified != null ? customerDetailsResponseEntity.modified as String : null,
      modifiedBy: customerDetailsResponseEntity.modifiedBy != null ? customerDetailsResponseEntity.modifiedBy as String : null,
      idx: customerDetailsResponseEntity.idx != null ? customerDetailsResponseEntity.idx as int : null,
      docstatus: customerDetailsResponseEntity.docstatus != null ? customerDetailsResponseEntity.docstatus as int : null,
      registeration: customerDetailsResponseEntity.registeration != null ? customerDetailsResponseEntity.registeration as int : null,
      isEmailVerified: customerDetailsResponseEntity.isEmailVerified != null ? customerDetailsResponseEntity.isEmailVerified as int : null,
      kycUpdate: customerDetailsResponseEntity.kycUpdate != null ? customerDetailsResponseEntity.kycUpdate as int : null,
      creditCheck: customerDetailsResponseEntity.creditCheck != null ? customerDetailsResponseEntity.creditCheck as int : null,
      pledgeSecurities: customerDetailsResponseEntity.pledgeSecurities != null ? customerDetailsResponseEntity.pledgeSecurities as int : null,
      loanOpen: customerDetailsResponseEntity.loanOpen != null ? customerDetailsResponseEntity.loanOpen as int : null,
      feedbackSubmitted: customerDetailsResponseEntity.feedbackSubmitted != null ? customerDetailsResponseEntity.feedbackSubmitted as int : null,
      feedbackDoNotShowPopup: customerDetailsResponseEntity.feedbackDoNotShowPopup != null ? customerDetailsResponseEntity.feedbackDoNotShowPopup as int : null,
      choiceKyc: customerDetailsResponseEntity.choiceKyc != null ? customerDetailsResponseEntity.choiceKyc as String : null,
      ckcy: customerDetailsResponseEntity.ckcy != null ? customerDetailsResponseEntity.ckcy as String : null,
      kra: customerDetailsResponseEntity.kra != null ? customerDetailsResponseEntity.kra as String : null,
      firstName: customerDetailsResponseEntity.firstName != null ? customerDetailsResponseEntity.firstName as String : null,
      phone: customerDetailsResponseEntity.phone != null ? customerDetailsResponseEntity.phone as String : null,
      myCamsEmailId: customerDetailsResponseEntity.myCamsEmailId != null ? customerDetailsResponseEntity.myCamsEmailId as String : null,
      fullName: customerDetailsResponseEntity.fullName != null ? customerDetailsResponseEntity.fullName as String : null,
      lastName: customerDetailsResponseEntity.lastName != null ? customerDetailsResponseEntity.lastName as String : null,
      user: customerDetailsResponseEntity.user != null ? customerDetailsResponseEntity.user as String : null,
      alertsBasedOnPercentage: customerDetailsResponseEntity.alertsBasedOnPercentage != null ? customerDetailsResponseEntity.alertsBasedOnPercentage as double : null,
      alertsBasedOnAmount: customerDetailsResponseEntity.alertsBasedOnAmount != null ? customerDetailsResponseEntity.alertsBasedOnAmount as double : null,
      doctype: customerDetailsResponseEntity.doctype != null ? customerDetailsResponseEntity.doctype as String : null,
    );
  }
}
