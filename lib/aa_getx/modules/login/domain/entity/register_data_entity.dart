import 'package:lms/aa_getx/modules/login/domain/entity/customer_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/pending_esign_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/user_kyc_entity.dart';

class RegisterDataEntity {
  String? token;
  CustomerEntity? customer;
  UserKycEntity? userKyc;
  List<PendingEsignsEntity>? pendingEsigns;

  RegisterDataEntity(
      {this.token, this.customer, this.userKyc, this.pendingEsigns});

  
}