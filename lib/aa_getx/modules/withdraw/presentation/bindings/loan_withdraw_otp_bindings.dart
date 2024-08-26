import 'package:flutter/foundation.dart';
import 'package:get/instance_manager.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/login/data/data_sources/login_data_source.dart';
import 'package:lms/aa_getx/modules/login/data/repositories/login_repository_impl.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/get_terms_of_use_usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/login_usecases.dart';
import 'package:lms/aa_getx/modules/login/domain/usecases/verify_otp_usecase.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/login_controller.dart';
import 'package:lms/aa_getx/modules/login/presentation/controllers/otp_verification_controller.dart';
import 'package:lms/aa_getx/modules/withdraw/data/data_source/loan_withdraw_datasource.dart';
import 'package:lms/aa_getx/modules/withdraw/data/repositories/loan_withdraw_repository_impl.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/usecases/create_withdraw_request_usecase.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/usecases/get_withdraw_details_usecase.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/usecases/request_loan_withdraw_otp_usecase.dart';
import 'package:lms/aa_getx/modules/withdraw/presentation/controllers/loan_withdraw_otp_controller.dart';

class LoanWithdrawOtpBindings implements Bindings {
@override
  void dependencies() {
    Get.lazyPut<LoanWithdrawDatasourcecDataSourceImpl>(
      () => LoanWithdrawDatasourcecDataSourceImpl(),
    );

    Get.lazyPut<LoanWithdrawRepositoryImpl>(
      () => LoanWithdrawRepositoryImpl(
        Get.find<LoanWithdrawDatasourcecDataSourceImpl>(),
      ),
    );

    Get.lazyPut<GetLoanWithdrawOTPUsecase>(() =>
        GetLoanWithdrawOTPUsecase(Get.find<LoanWithdrawRepositoryImpl>()));

    Get.lazyPut<CreateWithdrawRequestUsecase>(() =>
        CreateWithdrawRequestUsecase(Get.find<LoanWithdrawRepositoryImpl>()));

    Get.lazyPut<LoanWithdrawOtpController>(
      () => LoanWithdrawOtpController(
        Get.find<ConnectionInfo>(),
        Get.find<CreateWithdrawRequestUsecase>(),
        Get.find<GetLoanWithdrawOTPUsecase>(),
      ),
    );
  }

}
