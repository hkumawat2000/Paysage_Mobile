import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/force_update_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/repositories/dashboard_repository.dart';

class ForceUpdateUsecase
    extends UsecaseWithoutParams<ForceUpdateResponseEntity> {
  final DasboardRepository dashboardRepository;

  ForceUpdateUsecase(this.dashboardRepository);

  @override
  ResultFuture<ForceUpdateResponseEntity> call() async {
    return await dashboardRepository.forceUpdate();
  }
}