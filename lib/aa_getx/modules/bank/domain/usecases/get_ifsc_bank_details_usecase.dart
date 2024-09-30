
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/bank_master_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/request/bank_details_request_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/repository/bank_repository.dart';

class GetIfscBankDetailsUseCase extends UsecaseWithParams<BankMasterResponseEntity, BankDetailsRequestParams>{
  final BankRepository _bankRepository;
  GetIfscBankDetailsUseCase(this._bankRepository);

  @override
  ResultFuture<BankMasterResponseEntity> call(BankDetailsRequestParams params) async{
    return await _bankRepository.getIfscBankDetails(params.bankDetailsRequestEntity);
  }

}

class BankDetailsRequestParams {
  final BankDetailsRequestEntity bankDetailsRequestEntity;

  BankDetailsRequestParams({required this.bankDetailsRequestEntity});
}