
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/request/unpledge_request_req_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/unpledge_details_response_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/unpledge_request_response_entity.dart';

abstract class UnpledgeRepository {
  ResultFuture<UnpledgeDetailsResponseEntity> getUnpledgeDetails(LoanDetailsRequestEntity loanDetailsRequestEntity);

  ResultFuture<CommonResponseEntity> requestUnpledgeOtp();

  ResultFuture<UnpledgeRequestResponseEntity>  unpledgeRequest(UnpledgeRequestReqEntity unpledgeRequestReqEntity);
}