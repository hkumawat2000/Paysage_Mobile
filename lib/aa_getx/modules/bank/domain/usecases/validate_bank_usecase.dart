
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/fund_acc_validation_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/request/validate_bank_request_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/repository/bank_repository.dart';

class ValidateBankUseCase extends UsecaseWithParams<FundAccValidationResponseEntity, ValidateBankRequestParams>{
  final BankRepository _bankRepository;
  ValidateBankUseCase(this._bankRepository);

  @override
  ResultFuture<FundAccValidationResponseEntity> call(ValidateBankRequestParams params) async{
    return await _bankRepository.validateBank(params.validateBankRequestEntity);
  }

}

class ValidateBankRequestParams {
  final ValidateBankRequestEntity validateBankRequestEntity;

  ValidateBankRequestParams({required this.validateBankRequestEntity});
}