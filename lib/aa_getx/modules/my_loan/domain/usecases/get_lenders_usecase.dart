import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/lender_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/repositories/my_loans_repository.dart';

class GetLendersUseCase extends UsecaseWithoutParams<LenderResponseEntity> {
  final MyLoansRepository myLoansRepository;

  GetLendersUseCase(this.myLoansRepository);

  @override
  ResultFuture<LenderResponseEntity> call() async {
    return await myLoansRepository.getLenders();
  }
}
