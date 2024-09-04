
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';

abstract class SellCollateralRepository {
  ResultFuture<CommonResponseEntity> requestSellCollateralOTP();
}