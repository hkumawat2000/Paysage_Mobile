
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/get_profile_set_alert_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/get_profile_set_alert_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/repositories/more_repository.dart';

class GetProfileSetAlertUseCase extends UsecaseWithParams<GetProfileSetAlertResponseEntity, GetProfileSetAlertParams>{
final MoreRepository moreRepository;

GetProfileSetAlertUseCase(this.moreRepository);

  @override
  ResultFuture<GetProfileSetAlertResponseEntity> call(GetProfileSetAlertParams params) async {
    return await moreRepository.getProfileSetAlert(params.getProfileSetAlertRequestEntity);
  }

}

class GetProfileSetAlertParams{
  final GetProfileSetAlertRequestEntity getProfileSetAlertRequestEntity;
  GetProfileSetAlertParams({
    required this.getProfileSetAlertRequestEntity,
  });
}
