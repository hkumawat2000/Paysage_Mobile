import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/models/request/my_pledged_securities_request_model.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/my_pledged_securities_details_response_entity.dart';

abstract class PledgedSecuritiesRepository {
  ResultFuture<MyPledgedSecuritiesDetailsResponseEntity> getMyPledgedSecurities(
      MyPledgedSecuritiesRequestEntity myPledgedSecuritiesRequestEntity);
}
