import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/request/fetch_mutual_fund_request_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/fetch_mutual_fund_response_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/repositories/mf_central_repository.dart';

class MutualFundFetchUsecase implements UsecaseWithParams<FetchMutualFundResponseEntity, FetchMutualFundParams>{

  final MfCentralRepository mfCentralRepository;
  MutualFundFetchUsecase(this.mfCentralRepository);

  @override
  ResultFuture<FetchMutualFundResponseEntity> call(FetchMutualFundParams params) async {
    return await mfCentralRepository.fetchMutualFund(params.fetchMutualFundRequestEntity);
  }
}

class FetchMutualFundParams {
  final FetchMutualFundRequestEntity fetchMutualFundRequestEntity;
  FetchMutualFundParams({
    required this.fetchMutualFundRequestEntity,
  });
}