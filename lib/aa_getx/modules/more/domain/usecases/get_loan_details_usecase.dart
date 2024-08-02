
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/repositories/more_repository.dart';

class GetLoanDetailsUseCase extends UsecaseWithParams<LoanDetailsResponseEntity, GetLoanDetailsParams>{
  final MoreRepository moreRepository;

  GetLoanDetailsUseCase(this.moreRepository);

  @override
  ResultFuture<LoanDetailsResponseEntity> call(GetLoanDetailsParams params) async{
   return await moreRepository.getLoanDetails(params.loanDetailsRequestEntity);
  }

}

class GetLoanDetailsParams{
  final GetLoanDetailsRequestEntity loanDetailsRequestEntity;
  GetLoanDetailsParams({
    required this.loanDetailsRequestEntity,
  });
}
