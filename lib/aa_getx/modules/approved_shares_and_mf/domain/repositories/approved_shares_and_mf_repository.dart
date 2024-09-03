import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/demat_account_response_entity.dart';

abstract class ApprovedSharesAndMfRepository {
  ResultFuture<DematAccountResponseEntity> getDematAccountDetails();
}
