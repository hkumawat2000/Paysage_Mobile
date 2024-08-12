import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/dashboard/data/data_source/dashboard_datasource.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/force_update_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DasboardRepository {
  final DashboardDataSource dashboardDataSource;

  DashboardRepositoryImpl(this.dashboardDataSource);

  ResultFuture<ForceUpdateResponseEntity> forceUpdate() async {
    try {
      final forceUpdateResponse =
          await dashboardDataSource.forceUpdate();
      return DataSuccess(forceUpdateResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }
}
