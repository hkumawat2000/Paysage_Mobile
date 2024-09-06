
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/entities/request/sell_collateral_request_entity.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/entities/sell_collateral_response_entity.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/repositories/sell_collateral_repository.dart';

class RequestSellCollateralSecuritiesUseCase
    implements UsecaseWithParams<SellCollateralResponseEntity, RequestSellCollateralSecuritiesParams> {

  final SellCollateralRepository sellCollateralRepository;

  RequestSellCollateralSecuritiesUseCase(this.sellCollateralRepository);
  @override
  ResultFuture<SellCollateralResponseEntity> call(RequestSellCollateralSecuritiesParams params) async {
    return await sellCollateralRepository.requestSellCollateralSecurities(params.sellCollateralRequestEntity);
  }
}

class RequestSellCollateralSecuritiesParams {
  final SellCollateralRequestEntity sellCollateralRequestEntity;

  RequestSellCollateralSecuritiesParams({required this.sellCollateralRequestEntity});
}