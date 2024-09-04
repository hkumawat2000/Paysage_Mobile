import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/sell_collateral/data/data_sources/sell_collateral_data_source.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/repositories/sell_collateral_repository.dart';

abstract class SellCollateralRepositoryImpl extends SellCollateralRepository{
  final SellCollateralDatasource sellCollateralDatasource;
  SellCollateralRepositoryImpl(this.sellCollateralDatasource);

  ResultFuture<CommonResponseEntity> requestSellCollateralOTP() async {
    try {
      final loanWithdrawDetailsResponse =
      await sellCollateralDatasource.requestLoanWithDrawOTP();
      return DataSuccess(loanWithdrawDetailsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

}

