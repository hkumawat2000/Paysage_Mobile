import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/atrina_bank_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/bank_master_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/fund_acc_validation_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/request/bank_details_request_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/request/validate_bank_request_entity.dart';

abstract class BankRepository {
  ResultFuture<AtrinaBankResponseEntity> getBankDetails();

  ResultFuture<BankMasterResponseEntity> getIfscBankDetails(BankDetailsRequestEntity bankDetailsRequestEntity);

  ResultFuture<FundAccValidationResponseEntity> validateBank(ValidateBankRequestEntity validateBankRequestEntity);
}
