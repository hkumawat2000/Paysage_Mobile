// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/approved_securities_response_entity.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/request/approved_securities_request_entity.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/repositories/approved_shares_and_mf_repository.dart';

/// use case is a class responsible for encapsulating a specific piece of business logic or
/// a particular operation that your application needs to perform.
/// It acts as a bridge between the presentation
/// layer and the data layer.
class GetApprovedSecuritiesListUsecase
    implements
        UsecaseWithParams<ApprovedSecuritiesResponseEntity, GetApprovedSecuritiesListParams> {
  final ApprovedSharesAndMfRepository approvedSharesAndMfRepository;
  GetApprovedSecuritiesListUsecase(this.approvedSharesAndMfRepository);

  @override
  ResultFuture<ApprovedSecuritiesResponseEntity> call(params) async {
    return await approvedSharesAndMfRepository
        .getApprovedSecurities(params.approvedSecuritiesRequestEntity);
  }
}

class GetApprovedSecuritiesListParams {
  final ApprovedSecuritiesRequestEntity approvedSecuritiesRequestEntity;
  GetApprovedSecuritiesListParams({
    required this.approvedSecuritiesRequestEntity,
  });
}
