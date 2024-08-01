// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:lms/aa_getx/modules/kyc/domain/entities/address_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/consent_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/user_kyc_doc_response_entity.dart';

class ConsentDetailDataEntity {
  UserKycDocResponseEntity? userKycDoc;
  ConsentDetailsResponseEntity? consentDetails;
  List<String>? poaType;
  List<String>? country;
  AddressDetailsResponseEntity? address;

  ConsentDetailDataEntity({
    this.userKycDoc,
    this.consentDetails,
    this.poaType,
    this.country,
    this.address,
  });

}
