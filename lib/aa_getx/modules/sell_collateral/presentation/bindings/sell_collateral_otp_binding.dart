
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/usecases/request_sell_collateral_securities_usecase.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/controllers/sell_collateral_otp_controller.dart';
import 'package:lms/aa_getx/modules/sell_collateral/data/data_sources/sell_collateral_data_source.dart';
import 'package:lms/aa_getx/modules/sell_collateral/data/repositories/sell_collateral_repository_impl.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/usecases/request_sell_collateral_otp_usecase.dart';

class SellCollateralOtpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SellCollateralDatasourceImpl>(()=>SellCollateralDatasourceImpl());

    Get.lazyPut<SellCollateralRepositoryImpl>(()=>SellCollateralRepositoryImpl(Get.find<SellCollateralDatasourceImpl>()));

    Get.lazyPut<RequestSellCollateralOtpUseCase>(()=>RequestSellCollateralOtpUseCase(Get.find<SellCollateralRepositoryImpl>()));

    Get.lazyPut<RequestSellCollateralSecuritiesUseCase>(()=>RequestSellCollateralSecuritiesUseCase(Get.find<SellCollateralRepositoryImpl>()));

    Get.lazyPut<SellCollateralOtpController>(()=>SellCollateralOtpController(
      Get.find<ConnectionInfo>(),
      Get.find<RequestSellCollateralOtpUseCase>(),
      Get.find<RequestSellCollateralSecuritiesUseCase>()
    ));
  }
}