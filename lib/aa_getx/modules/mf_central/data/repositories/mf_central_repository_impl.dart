import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/cibil/data/data_source/cibil_data_source.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/request/cibil_on_demand_request_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/request/cibil_otp_verification_request_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/response/cibil_on_demand_response_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/response/cibil_otp_verification_response_model.dart';
import 'package:lms/aa_getx/modules/cibil/data/models/response/cibil_send_otp_response_model.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_on_demand_request_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_otp_verification_request_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_on_demand_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_otp_verification_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/response/cibil_send_otp_response_entity.dart';
import 'package:lms/aa_getx/modules/cibil/domain/repositories/cibil_repository.dart';
import 'package:lms/aa_getx/modules/mf_central/data/data_source/mf_central_data_source.dart';
import 'package:lms/aa_getx/modules/mf_central/data/models/request/fetch_mutual_fund_request_model.dart';
import 'package:lms/aa_getx/modules/mf_central/data/models/response/mf_send_otp_response_model.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/request/fetch_mutual_fund_request_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/fetch_mutual_fund_response_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/entities/response/mf_send_otp_response_entity.dart';
import 'package:lms/aa_getx/modules/mf_central/domain/repositories/mf_central_repository.dart';

class MfCentralRepositoryImpl implements MfCentralRepository {

  final MfCentralDataSource mfCentralDataSource;
  MfCentralRepositoryImpl(this.mfCentralDataSource);

  @override
  ResultFuture<MutualFundSendOtpResponseEntity> mutualFundOtpSend() async {
    try {
      final mutualFundSendOtpResponseModel = await mfCentralDataSource.mutualFundOtpSend();
      return DataSuccess(mutualFundSendOtpResponseModel.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<FetchMutualFundResponseEntity> fetchMutualFund(FetchMutualFundRequestEntity fetchMutualFundRequestEntity) async {
    try {
      FetchMutualFundRequestModel fetchMutualFundRequestModel =
      FetchMutualFundRequestModel.fromEntity(fetchMutualFundRequestEntity);
      final cibilOtpVerificationResponseModel =
      await mfCentralDataSource.fetchMutualFund(fetchMutualFundRequestModel);
      return DataSuccess(cibilOtpVerificationResponseModel.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }
}