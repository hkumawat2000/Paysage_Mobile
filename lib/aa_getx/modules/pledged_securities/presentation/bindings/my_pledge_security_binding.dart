
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/more/data/data_sources/more_api.dart';
import 'package:lms/aa_getx/modules/more/data/repositories/more_repository_impl.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/data/data_sources/my_loans_api.dart';
import 'package:lms/aa_getx/modules/my_loan/data/repositories/my_loans_repository_impl.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/get_all_loans_name_usecase.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/data_sources/pledged_securities_api.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/repositories/pledged_securities_repository_impl.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/usecases/get_my_pledged_securities_usecase.dart';
import 'package:lms/aa_getx/modules/pledged_securities/presentation/controllers/my_pledge_security_controller.dart';

class MyPledgeSecurityBinding extends Bindings{
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

    Get.lazyPut<PledgedSecuritiesApiImpl>(()=>PledgedSecuritiesApiImpl());

    Get.lazyPut<PledgedSecuritiesRepositoryImpl>(()=> PledgedSecuritiesRepositoryImpl(Get.find<PledgedSecuritiesApiImpl>()));

    Get.lazyPut<GetMyPledgedSecuritiesUseCase>(()=>GetMyPledgedSecuritiesUseCase(Get.find<PledgedSecuritiesRepositoryImpl>()));

    Get.lazyPut<MyPledgeSecurityController>(
            () => MyPledgeSecurityController(Get.find<ConnectionInfo>(),Get.find<GetAllLoansNamesUseCase>(), Get.find<GetLoanDetailsUseCase>(), Get.find<GetMyPledgedSecuritiesUseCase>()));

  }
}