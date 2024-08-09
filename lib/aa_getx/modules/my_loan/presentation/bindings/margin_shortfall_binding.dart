
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/my_loan/data/data_sources/my_loans_api.dart';
import 'package:lms/aa_getx/modules/my_loan/data/repositories/my_loans_repository_impl.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/get_lenders_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/get_securities_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/controllers/margin_shortfall_controller.dart';

class MarginShortfallBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<MyLoansApiImpl>(() => MyLoansApiImpl());

    Get.lazyPut<MyLoansRepositoryImpl>(
            () => MyLoansRepositoryImpl(Get.find<MyLoansApiImpl>()));

    Get.lazyPut<GetLendersUseCase>(
            () => GetLendersUseCase(Get.find<MyLoansRepositoryImpl>()));

    Get.lazyPut<GetSecuritiesUseCase>(
            () => GetSecuritiesUseCase(Get.find<MyLoansRepositoryImpl>()));

    Get.lazyPut<MarginShortfallController>(
            () => MarginShortfallController(Get.find<GetLendersUseCase>(),Get.find<ConnectionInfo>(),Get.find<GetSecuritiesUseCase>(),));
  }
}