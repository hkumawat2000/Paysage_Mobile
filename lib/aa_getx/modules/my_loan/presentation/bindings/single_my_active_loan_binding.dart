import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/more/data/data_sources/more_api.dart';
import 'package:lms/aa_getx/modules/more/data/repositories/more_repository_impl.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/data/data_sources/my_loans_api.dart';
import 'package:lms/aa_getx/modules/my_loan/data/repositories/my_loans_repository_impl.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/get_all_loans_name_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/controllers/single_my_active_loan_controller.dart';

class SingleMyActiveLoanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MoreApiImpl>(()=>MoreApiImpl());

    Get.lazyPut<MoreRepositoryImpl>(()=>MoreRepositoryImpl(Get.find<MoreApiImpl>()));

    Get.lazyPut<GetLoanDetailsUseCase>(()=> GetLoanDetailsUseCase(Get.find<MoreRepositoryImpl>()));


    Get.lazyPut<MyLoansApiImpl>(() => MyLoansApiImpl());

    Get.lazyPut<MyLoansRepositoryImpl>(
        () => MyLoansRepositoryImpl(Get.find<MyLoansApiImpl>()));

    Get.lazyPut<GetAllLoansNamesUseCase>(
        () => GetAllLoansNamesUseCase(Get.find<MyLoansRepositoryImpl>()));

    Get.lazyPut<SingleMyActiveLoanController>(
        () => SingleMyActiveLoanController(Get.find<ConnectionInfo>(),Get.find<GetAllLoansNamesUseCase>(), Get.find<GetLoanDetailsUseCase>()));
  }
}
