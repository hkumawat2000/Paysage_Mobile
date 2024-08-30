import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/account_statement/data/data_sources/account_statement_data_source.dart';
import 'package:lms/aa_getx/modules/account_statement/data/repositories/account_statement_repository_impl.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/usecases/submit_loan_statement_usecase.dart';
import 'package:lms/aa_getx/modules/account_statement/presentation/controllers/download_statement_controller.dart';

class DownloadStatementBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AccountStatementDataSourceImpl>(
          () => AccountStatementDataSourceImpl(),
    );

    Get.lazyPut<AccountStatementRepositoryImpl>(
          () => AccountStatementRepositoryImpl(
        Get.find<AccountStatementDataSourceImpl>(),
      ),
    );

    Get.lazyPut<SubmitLoanStatementUseCase>(
            () => SubmitLoanStatementUseCase(Get.find<AccountStatementRepositoryImpl>()));

    Get.lazyPut<DownloadStatementController>(()=>DownloadStatementController(Get.find<ConnectionInfo>(), Get.find<SubmitLoanStatementUseCase>()));
  }

}