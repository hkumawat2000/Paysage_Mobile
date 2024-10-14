import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/bank/data/data_source/bank_data_source.dart';
import 'package:lms/aa_getx/modules/bank/data/models/request/bank_details_request_model.dart';
import 'package:lms/aa_getx/modules/bank/data/models/request/validate_bank_request_model.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/atrina_bank_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/bank_master_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/fund_acc_validation_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/request/bank_details_request_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/request/validate_bank_request_entity.dart';
import 'package:lms/aa_getx/modules/bank/domain/repository/bank_repository.dart';

class BankRepositoryImpl extends BankRepository{
  final BankDataSource _bankDataSource;

  BankRepositoryImpl(this._bankDataSource);
  @override
  ResultFuture<AtrinaBankResponseEntity> getBankDetails() async {
    try{
      final getBankDetailsResponse = await _bankDataSource.getBankDetails();
      return DataSuccess(getBankDetailsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e){
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e){
      return DataFailed(ServerFailure(e.toString(),0));
    }
  }

  @override
  ResultFuture<BankMasterResponseEntity> getIfscBankDetails(BankDetailsRequestEntity bankDetailsRequestEntity) async {
    try{
      BankDetailsRequestModel bankDetailsRequestModel = BankDetailsRequestModel.fromEntity(bankDetailsRequestEntity);
      final getBankDetailsResponse = await _bankDataSource.getIfscBankDetails(bankDetailsRequestModel);
      return DataSuccess(getBankDetailsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e){
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e){
      return DataFailed(ServerFailure(e.toString(),0));
    }
  }

  @override
  ResultFuture<FundAccValidationResponseEntity> validateBank(ValidateBankRequestEntity validateBankRequestEntity) async {
    try{
      ValidateBankRequestModel validateBankRequestModel = ValidateBankRequestModel.fromEntity(validateBankRequestEntity);
      final validateBankResponse = await _bankDataSource.validateBank(validateBankRequestModel);
      return DataSuccess(validateBankResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e){
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e){
      return DataFailed(ServerFailure(e.toString(),0));
    }
  }

}