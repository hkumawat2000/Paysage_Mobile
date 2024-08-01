
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/more/data/data_sources/more_api.dart';
import 'package:lms/aa_getx/modules/more/data/repositories/more_repository_impl.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_my_active_loans_usecase.dart';
import 'package:lms/aa_getx/modules/more/presentation/controllers/more_controller.dart';

class MoreBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<MoreApiImpl>(()=>MoreApiImpl());

    Get.lazyPut<MoreRepositoryImpl>(()=>MoreRepositoryImpl(Get.find<MoreApiImpl>()));

    Get.lazyPut<GetMyActiveLoansUseCase>(()=>GetMyActiveLoansUseCase(Get.find<MoreRepositoryImpl>()));

    Get.lazyPut<GetLoanDetailsUseCase>(()=> GetLoanDetailsUseCase(Get.find<MoreRepositoryImpl>()));

    Get.lazyPut<MoreController>(() => MoreController(
          Get.find<GetMyActiveLoansUseCase>(),
          Get.find<ConnectionInfo>(),
          Get.find<GetLoanDetailsUseCase>(),
        ));
  }
}