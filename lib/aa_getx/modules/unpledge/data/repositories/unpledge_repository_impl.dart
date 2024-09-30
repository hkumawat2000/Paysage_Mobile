import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/unpledge/data/data_source/unpledge_data_source.dart';
import 'package:lms/aa_getx/modules/unpledge/data/models/request/unpledge_request_req_model.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/request/unpledge_request_req_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/unpledge_request_response_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/repositories/unpledge_repository.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/payment/data/models/request/loan_details_request_model.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/unpledge_details_response_entity.dart';

class UnpledgeRepositoryImpl extends UnpledgeRepository{
  final UnpledgeDataSource unpledgeDataSource;
  UnpledgeRepositoryImpl(this.unpledgeDataSource);
  @override
  ResultFuture<UnpledgeDetailsResponseEntity> getUnpledgeDetails(LoanDetailsRequestEntity loanDetailsRequestEntity) async{
    try {
      LoanDetailsRequestModel loanDetailsRequestModel = LoanDetailsRequestModel.fromEntity(loanDetailsRequestEntity);
      final response =
      await unpledgeDataSource.getUnpledgeDetails(loanDetailsRequestModel);
      return DataSuccess(response.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<CommonResponseEntity> requestUnpledgeOtp() async {
    try {
      final response =
          await unpledgeDataSource.requestUnpledgeOtp();
      return DataSuccess(response.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<UnpledgeRequestResponseEntity> unpledgeRequest(UnpledgeRequestReqEntity unpledgeRequestReqEntity) async{
    try {
      UnpledgeRequestReqModel unpledgeRequestReqModel = UnpledgeRequestReqModel.fromEntity(unpledgeRequestReqEntity);
      final response =
      await unpledgeDataSource.unpledgeRequest(unpledgeRequestReqModel);
      return DataSuccess(response.toEntity());
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