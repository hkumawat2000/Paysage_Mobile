import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/withdraw/data/data_source/loan_withdraw_datasource.dart';
import 'package:lms/aa_getx/modules/withdraw/data/models/request/withdraw_loan_details_request_model.dart';
import 'package:lms/aa_getx/modules/withdraw/data/models/request/withdraw_otp_request_model.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/loan_withdraw_response_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/request/withdraw_loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/entities/request/withdraw_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/withdraw/domain/repositories/loan_withdraw_repository.dart';

class LoanWithdrawRepositoryImpl implements LoanWithdrawRepository {
  final LoanWithdrawDatasource loanWithdrawDatasource;
  LoanWithdrawRepositoryImpl(this.loanWithdrawDatasource);

  ResultFuture<LoanWithdrawResponseEntity> getWithdrawDetails(
      WithdrawLoanDetailsRequestEntity
          withdrawLoanDetailsRequestDataEntity) async {
    try {
      WithdrawLoanDetailsRequestModel withdrawLoanDetailsRequestModel =
          WithdrawLoanDetailsRequestModel.fromEntity(
              withdrawLoanDetailsRequestDataEntity);
      final loanWithdrawDetailsResponse = await loanWithdrawDatasource
          .getWithdrawDetails(withdrawLoanDetailsRequestModel);
      return DataSuccess(loanWithdrawDetailsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  ResultFuture<CommonResponseEntity> requestLoanWithDrawOTP() async {
    try {
      final loanWithdrawDetailsResponse =
          await loanWithdrawDatasource.requestLoanWithDrawOTP();
      return DataSuccess(loanWithdrawDetailsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  ResultFuture<CommonResponseEntity> createWithDrawRequest(
      WithdrawOtpRequestEntity withdrawOtpRequestDataEntity) async {
    try {
      WithdrawOtpRequestModel withdrawOtpRequestModel =
          WithdrawOtpRequestModel.fromEntity(withdrawOtpRequestDataEntity);
      final createWithDrawResponse =
          await loanWithdrawDatasource.createWithDrawRequest(withdrawOtpRequestModel);
      return DataSuccess(createWithDrawResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

}
