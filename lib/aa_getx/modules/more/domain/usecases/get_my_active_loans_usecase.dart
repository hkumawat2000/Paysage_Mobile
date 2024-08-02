import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/my_loans_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/repositories/more_repository.dart';

class GetMyActiveLoansUseCase
    extends UsecaseWithoutParams<MyLoansResponseEntity> {
  final MoreRepository moreRepository;

  GetMyActiveLoansUseCase(this.moreRepository);

  @override
  ResultFuture<MyLoansResponseEntity> call() async {
    return await moreRepository.getMyActiveLoans();
  }
}
