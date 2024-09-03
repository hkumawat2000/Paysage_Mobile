import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/demat_account_response_entity.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/repositories/approved_shares_and_mf_repository.dart';

class GetDematAccountDetailsUsecase
    extends UsecaseWithoutParams<DematAccountResponseEntity> {
  final ApprovedSharesAndMfRepository approvedSharesAndMfRepository;

  GetDematAccountDetailsUsecase(this.approvedSharesAndMfRepository);

  @override
  ResultFuture<DematAccountResponseEntity> call() async {
    return await approvedSharesAndMfRepository.getDematAccountDetails();
  }
}