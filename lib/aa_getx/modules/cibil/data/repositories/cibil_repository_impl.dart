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

class CibilRepositoryImpl implements CibilRepository {

  final CibilDataSource cibilDataSource;
  CibilRepositoryImpl(this.cibilDataSource);

  @override
  ResultFuture<CibilSendOtpResponseEntity> cibilOtpSend() async {
    try {
      final cibilOTPSendResponse = await cibilDataSource.cibilOtpSend();
      return DataSuccess(cibilOTPSendResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg , e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<CibilOtpVerificationResponseEntity> cibilOtpVerification(CibilOtpVerificationRequestEntity cibilOtpVerificationRequestEntity) async {
    try {
      CibilOtpVerificationRequestModel cibilOtpVerificationRequestModel =
      CibilOtpVerificationRequestModel.fromEntity(cibilOtpVerificationRequestEntity);
      final cibilOtpVerificationResponseModel =
      await cibilDataSource.cibilOtpVerification(cibilOtpVerificationRequestModel);
      return DataSuccess(cibilOtpVerificationResponseModel.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  @override
  ResultFuture<CibilOnDemandResponseEntity> cibilOnDemand(CibilOnDemandRequestEntity cibilOnDemandRequestEntity) async {
    try {
      CibilOnDemandRequestModel cibilOnDemandRequestModel =
      CibilOnDemandRequestModel.fromEntity(cibilOnDemandRequestEntity);
      final cibilOnDemandResponseModel =
      await cibilDataSource.cibilOnDemand(cibilOnDemandRequestModel);
      return DataSuccess(cibilOnDemandResponseModel.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

}