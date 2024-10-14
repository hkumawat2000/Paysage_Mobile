
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/request/unpledge_request_req_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/unpledge_request_response_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/repositories/unpledge_repository.dart';

class UnpledgeRequestUsecase extends UsecaseWithParams<UnpledgeRequestResponseEntity, UnpledgeRequestParams>{
  final UnpledgeRepository unpledgeRepository;

  UnpledgeRequestUsecase(this.unpledgeRepository);

  @override
  ResultFuture<UnpledgeRequestResponseEntity> call(UnpledgeRequestParams params) async {
    return await unpledgeRepository.unpledgeRequest(params.unpledgeRequestReqEntity);
  }

}

class UnpledgeRequestParams{
  final UnpledgeRequestReqEntity unpledgeRequestReqEntity;
  UnpledgeRequestParams({
    required this.unpledgeRequestReqEntity,
  });
}