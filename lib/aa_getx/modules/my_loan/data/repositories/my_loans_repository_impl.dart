import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/my_loan/data/data_sources/my_loans_api.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/request/create_loan_application_request_model.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/request/pledge_otp_request_model.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/request/securities_request_model.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/all_loan_names_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/create_loan_application_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/lender_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/process_cart_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/request/pledge_otp_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/request/securities_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/securities_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/repositories/my_loans_repository.dart';

class MyLoansRepositoryImpl extends MyLoansRepository{
  final MyLoansApi myLoansApi;

  MyLoansRepositoryImpl(this.myLoansApi);
  @override
  ResultFuture<AllLoanNamesResponseEntity> getAllLoansNames() async {
    try{
      final allLoanNamesResponse = await myLoansApi.getAllLoansNames();
      return DataSuccess(allLoanNamesResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e){
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e){
      return DataFailed(ServerFailure(e.toString(),0));
    }
  }

  @override
  ResultFuture<LenderResponseEntity> getLenders() async {
    try{
      final getLendersResponse = await myLoansApi.getLenders();
      return DataSuccess(getLendersResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e){
      return DataFailed(ServerFailure(e.toString(),0));
    }
  }

  @override
  ResultFuture<SecuritiesResponseEntity> getSecurities(SecuritiesRequestEntity securitiesRequestEntity) async {
    try {
      SecuritiesRequestModel securitiesRequestModel = SecuritiesRequestModel.fromEntity(securitiesRequestEntity);
      final response = await myLoansApi.getSecurities(securitiesRequestModel);
      return DataSuccess(response.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e){
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<CommonResponseEntity> requestPledgeOTP(PledgeOTPRequestEntity pledgeOTPRequestEntity) async {
    try {
      PledgeOTPRequestModel pledgeOTPRequestModel = PledgeOTPRequestModel.fromEntity(pledgeOTPRequestEntity);
      final response = await myLoansApi.requestPledgeOTP(pledgeOTPRequestModel);
      return DataSuccess(response.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e){
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<ProcessCartResponseEntity> createLoanApplication(CreateLoanApplicationRequestEntity createLoanApplicationRequestEntity) async {
    try{
      CreateLoanApplicationRequestModel createLoanApplicationRequestModel = CreateLoanApplicationRequestModel.fromEntity(createLoanApplicationRequestEntity);
      final response = await myLoansApi.createLoanApplication(createLoanApplicationRequestModel);
      return DataSuccess(response.toEntity());
    } on ServerException catch (e){
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e){
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }
}