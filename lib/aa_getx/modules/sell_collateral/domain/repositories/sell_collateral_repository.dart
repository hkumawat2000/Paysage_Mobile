
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/entities/request/sell_collateral_request_entity.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/entities/sell_collateral_response_entity.dart';

abstract class SellCollateralRepository {
  ResultFuture<CommonResponseEntity> requestSellCollateralOTP();

  ResultFuture<SellCollateralResponseEntity> requestSellCollateralSecurities(SellCollateralRequestEntity sellCollateralRequestEntity);
}