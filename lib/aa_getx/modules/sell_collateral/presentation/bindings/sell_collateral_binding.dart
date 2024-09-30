
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/more/data/data_sources/more_api.dart';
import 'package:lms/aa_getx/modules/more/data/repositories/more_repository_impl.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/sell_collateral/data/data_sources/sell_collateral_data_source.dart';
import 'package:lms/aa_getx/modules/sell_collateral/data/repositories/sell_collateral_repository_impl.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/usecases/request_sell_collateral_otp_usecase.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/controllers/sell_collateral_controller.dart';

class SellCollateralBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MoreApiImpl>(()=>MoreApiImpl());

    Get.lazyPut<MoreRepositoryImpl>(()=>MoreRepositoryImpl(Get.find<MoreApiImpl>()));

    Get.lazyPut<GetLoanDetailsUseCase>(()=> GetLoanDetailsUseCase(Get.find<MoreRepositoryImpl>()));

    Get.lazyPut<SellCollateralDatasourceImpl>(()=>SellCollateralDatasourceImpl());

    Get.lazyPut<SellCollateralRepositoryImpl>(()=>SellCollateralRepositoryImpl(Get.find<SellCollateralDatasourceImpl>()));

    Get.lazyPut<RequestSellCollateralOtpUseCase>(()=>RequestSellCollateralOtpUseCase(Get.find<SellCollateralRepositoryImpl>()));

    Get.lazyPut<SellCollateralController>(
          () => SellCollateralController(
        Get.find<ConnectionInfo>(),
        Get.find<GetLoanDetailsUseCase>(),
        Get.find<RequestSellCollateralOtpUseCase>(),
      ),
    );
  }
}