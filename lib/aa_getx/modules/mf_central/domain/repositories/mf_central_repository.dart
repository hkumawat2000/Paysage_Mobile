import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/request/cibil_on_demand_request_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/request/cibil_otp_verification_request_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/response/cibil_on_demand_response_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/response/cibil_otp_verification_response_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/response/cibil_send_otp_response_model.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_on_demand_request_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_otp_verification_request_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_on_demand_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_otp_verification_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_send_otp_response_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/request/fetch_mutual_fund_request_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/fetch_mutual_fund_response_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/mf_send_otp_response_entity.dart';

abstract class MfCentralRepository {

  ResultFuture<MutualFundSendOtpResponseEntity> mutualFundOtpSend();

  ResultFuture<FetchMutualFundResponseEntity> fetchMutualFund(FetchMutualFundRequestEntity fetchMutualFundRequestEntity);

}