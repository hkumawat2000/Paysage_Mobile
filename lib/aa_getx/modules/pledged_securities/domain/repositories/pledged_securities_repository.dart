import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/models/request/my_pledged_securities_request_model.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/request/loan_closer_request_entity.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/response/loan_closer_response_entity.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/response/my_pledged_securities_details_response_entity.dart';

abstract class PledgedSecuritiesRepository {
  ResultFuture<MyPledgedSecuritiesDetailsResponseEntity> getMyPledgedSecurities(
      MyPledgedSecuritiesRequestEntity myPledgedSecuritiesRequestEntity);

  ResultFuture<LoanCloserResponseEntity> loanCloser(
      LoanCloserRequestEntity loanCloserRequestEntity);
}
