import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/request/loan_closer_request_entity.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/response/loan_closer_response_entity.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/repositories/pledged_securities_repository.dart';

class LoanCloserUsecase extends UsecaseWithParams<LoanCloserResponseEntity, LoanCloserRequestParams>{

  final PledgedSecuritiesRepository pledgedSecuritiesRepository;

  LoanCloserUsecase(this.pledgedSecuritiesRepository);

  @override
  ResultFuture<LoanCloserResponseEntity> call(LoanCloserRequestParams params) async {
    return await pledgedSecuritiesRepository.loanCloser(params.loanCloserRequestEntity);
  }


}

class LoanCloserRequestParams {
  final LoanCloserRequestEntity loanCloserRequestEntity;

  LoanCloserRequestParams({required this.loanCloserRequestEntity});
}