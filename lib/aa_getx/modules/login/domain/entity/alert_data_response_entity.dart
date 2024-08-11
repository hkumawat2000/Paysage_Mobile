// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/login/domain/entity/customer_details_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/user_kyc_entity.dart';

class AlertDataResponseEntity {
  CustomerDetailsResponseEntity? customerDetails;
  String? loanApplicationStatus;
  String? loanName;
  String? instrumentType;
  String? pledgorBoid;
  UserKycEntity? userKyc;
  String? lastLogin;
  String? profilePhotoUrl;
  AlertDataResponseEntity({
    this.customerDetails,
    this.loanApplicationStatus,
    this.loanName,
    this.instrumentType,
    this.pledgorBoid,
    this.userKyc,
    this.lastLogin,
    this.profilePhotoUrl,
  });
}
