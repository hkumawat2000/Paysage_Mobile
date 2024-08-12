import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_on_demand_request_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_on_demand_request_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_otp_verification_request_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_on_demand_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_otp_verification_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/repositories/cibil_repository.dart';

class CibilOnDemandUsecase implements UsecaseWithParams<CibilOnDemandResponseEntity, CibilOnDemandParams>{

  final CibilRepository cibilRepository;
  CibilOnDemandUsecase(this.cibilRepository);

  @override
  ResultFuture<CibilOnDemandResponseEntity> call(params)async {
    return await cibilRepository.cibilOnDemand(params.cibilOnDemandRequestEntity);
  }
}

class CibilOnDemandParams {
  final CibilOnDemandRequestEntity cibilOnDemandRequestEntity;
  CibilOnDemandParams({
    required this.cibilOnDemandRequestEntity,
  });
}
