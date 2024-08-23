import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/new_dashboard_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/repositories/dashboard_repository.dart';

class GetDashboardDataUseCase
    extends UsecaseWithoutParams<NewDashboardResponseEntity> {
  final DasboardRepository dashboardRepository;

  GetDashboardDataUseCase(this.dashboardRepository);

  @override
  ResultFuture<NewDashboardResponseEntity> call() async {
    return await dashboardRepository.getDashboardData();
  }
}