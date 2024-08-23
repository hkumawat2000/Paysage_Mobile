
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/loan_summary_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/repositories/dashboard_repository.dart';

class GetLoanSummaryDataUseCase extends UsecaseWithoutParams<LoanSummaryResponseEntity>{
  final DasboardRepository dashboardRepository;

  GetLoanSummaryDataUseCase(this.dashboardRepository);

  @override
  ResultFuture<LoanSummaryResponseEntity> call() async {
    return await dashboardRepository.getLoanSummaryData();
  }

}