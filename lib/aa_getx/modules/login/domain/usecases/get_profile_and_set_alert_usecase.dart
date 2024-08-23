// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/get_profile_and_set_alert_details_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/get_profile_and_set_alert_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/verify_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/repositories/login_repository.dart';

class GetProfileAndSetAlertUsecase implements UsecaseWithParams<GetProfileAndSetAlertDetailsResponseEntity,GetProfileAndSetAlertParams>{
  final LoginRepository loginRepository;
  GetProfileAndSetAlertUsecase(this.loginRepository);

  @override
  ResultFuture<GetProfileAndSetAlertDetailsResponseEntity> call(params) async{
    return await loginRepository.getProfileandSetAlert(params.getProfileAndSetAlertRequestEntity);
  }
  }

class GetProfileAndSetAlertParams {
  final GetProfileAndSetAlertRequestEntity getProfileAndSetAlertRequestEntity;
  GetProfileAndSetAlertParams({
    required this.getProfileAndSetAlertRequestEntity,
  });
}
