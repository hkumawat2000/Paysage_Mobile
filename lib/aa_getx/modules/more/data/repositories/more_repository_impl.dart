
import 'package:flutter/material.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/more/data/data_sources/more_api.dart';
import 'package:lms/aa_getx/modules/more/data/models/request/get_loan_details_request_model.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/my_loans_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/repositories/more_repository.dart';

class MoreRepositoryImpl implements MoreRepository{
  final MoreApi moreApi;
  MoreRepositoryImpl(this.moreApi);
  @override
  ResultFuture<MyLoansResponseEntity> getMyActiveLoans() async{
    try {
      final getMyActiveLoansResponse =
          await moreApi.getMyActiveLoans();
      debugPrint("response : $getMyActiveLoansResponse");
      return DataSuccess(getMyActiveLoansResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<LoanDetailsResponseEntity> getLoanDetails(GetLoanDetailsRequestEntity getLoanDetailsRequestEntity) async{
    try {
      GetLoanDetailsRequestModel getLoanDetailsRequestModel = GetLoanDetailsRequestModel.fromEntity(getLoanDetailsRequestEntity);
      final getLoanDetailsResponse =
          await moreApi.getLoanDetails(getLoanDetailsRequestModel);
      debugPrint("response : $getLoanDetailsResponse");
      return DataSuccess(getLoanDetailsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

}