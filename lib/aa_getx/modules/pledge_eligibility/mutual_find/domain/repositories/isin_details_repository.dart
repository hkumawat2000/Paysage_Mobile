import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/isin_details_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/isin_details_response_entity.dart';

abstract class IsinDetailsRepository {
  ResultFuture<IsinDetailResponseEntity> getIsinDetails(IsinDetailsRequestEntity isinDetailsRequestEntity);
}