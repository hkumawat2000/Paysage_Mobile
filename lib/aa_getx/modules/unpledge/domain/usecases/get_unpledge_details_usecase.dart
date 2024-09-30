
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/payment/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/unpledge_details_response_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/repositories/unpledge_repository.dart';

class GetUnpledgeDetailsUseCase extends UsecaseWithParams<UnpledgeDetailsResponseEntity, GetLoanDetailsParams>{
  final UnpledgeRepository unpledgeRepository;

  GetUnpledgeDetailsUseCase(this.unpledgeRepository);

  @override
  ResultFuture<UnpledgeDetailsResponseEntity> call(GetLoanDetailsParams params) async {
    return await unpledgeRepository.getUnpledgeDetails(params.loanDetailsRequestEntity);
  }

}

