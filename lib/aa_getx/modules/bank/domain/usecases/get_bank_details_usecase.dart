import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/atrina_bank_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/repository/bank_repository.dart';

class GetBankDetailsUseCase extends UsecaseWithoutParams<AtrinaBankResponseEntity>{
  final BankRepository _bankRepository;
  GetBankDetailsUseCase(this._bankRepository);

  @override
  ResultFuture<AtrinaBankResponseEntity> call() async{
    return await _bankRepository.getBankDetails();
  }

}