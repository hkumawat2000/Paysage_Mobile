import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/repositories/sell_collateral_repository.dart';

class RequestSellCollateralOtpUseCase
    implements UsecaseWithoutParams<CommonResponseEntity> {

  final SellCollateralRepository sellCollateralRepository;

  RequestSellCollateralOtpUseCase(this.sellCollateralRepository);
  @override
  ResultFuture<CommonResponseEntity> call() async {
    return await sellCollateralRepository.requestSellCollateralOTP();
  }
}

