
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/lender/domain/entities/lender_response_entity.dart';
import 'package:lms/aa_getx/modules/lender/domain/repositories/lender_repository.dart';

class LenderUsecase
    extends UsecaseWithoutParams<LenderResponseEntity> {
  final LenderRepository lenderRepository;

  LenderUsecase(this.lenderRepository);

  @override
  ResultFuture<LenderResponseEntity> call() async {
    return await lenderRepository.getLendersList();
  }
}

