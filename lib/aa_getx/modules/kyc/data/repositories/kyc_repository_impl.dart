import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/kyc/data/data_sources/kyc_data_source.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/request/consent_details_request_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/request/download_kyc_request_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/request/get_consent_details_request_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/request/get_pincode_details_request_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/request/search_kyc_request_model.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/consent_text_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_consent_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_download_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_search_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/pincode_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/consent_details_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/download_kyc_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/get_consent_details_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/get_pincode_details_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/search_kyc_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/repositories/kyc_repository.dart';

/// KycRepositoryImpl is the concrete implementation of the KycRepository
/// interface.
/// This class implements the methods defined in KycRepository to interact
/// with data. It acts as a bridge between the domain layer
/// (use cases) and the data layer (data sources).
class KycRepositoryImpl implements KycRepository {
  final KycDataSource kycDataSource;
  KycRepositoryImpl(this.kycDataSource);

  ResultFuture<KYCSearchResponseEntity> kycSearch(
      SearchKycRequestEntity searchKycRequestEntity) async {
    try {
      SearchKycRequestModel searchKycRequestModel =
          SearchKycRequestModel.fromEntity(searchKycRequestEntity);
      final kycSearchResponse =
          await kycDataSource.kycSearch(searchKycRequestModel);
      return DataSuccess(kycSearchResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  ResultFuture<KycDownloadResponseEntity> kycDownload(
      DownloadKycRequestEntity downloadKycRequestEntity) async {
    try {
      DownloadKycRequestModel downloadKycRequestModel =
          DownloadKycRequestModel.fromEntity(downloadKycRequestEntity);
      final kycDownloadResponse =
          await kycDataSource.kycDownload(downloadKycRequestModel);
      return DataSuccess(kycDownloadResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  ResultFuture<ConsentTextResponseEntity> getConsentText(
      GetConsentDetailsRequestEntity getConsentDetailsRequestEntity) async {
    try {
      GetConsentDetailsRequestModel getConsentDetailsRequestModel =
          GetConsentDetailsRequestModel.fromEntity(getConsentDetailsRequestEntity);
      final getConsentTextResponse =
          await kycDataSource.getConsentText(getConsentDetailsRequestModel);
      return DataSuccess(getConsentTextResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

   ResultFuture<ConsentDetailResponseEntity> getConsentDetails(
      ConsentDetailsRequestEntity consentDetailsRequestEntity) async {
    try {
      ConsentDetailsRequestModel consentDetailsRequestModel =
          ConsentDetailsRequestModel.fromEntity(consentDetailsRequestEntity);
      final ConsentDetailsResponse =
          await kycDataSource.getConsentDetails(consentDetailsRequestModel);
      return DataSuccess(ConsentDetailsResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

  ResultFuture<PincodeResponseEntity> getPincodeDetails(
      GetPincodeDetailsRequestEntity getPincodeDetailsRequestEntity) async {
    try {
      GetPincodeDetailsRequestModel getPincodeDetailsRequestModel =
          GetPincodeDetailsRequestModel.fromEntity(getPincodeDetailsRequestEntity);
      final PincodeDetailsResponse =
          await kycDataSource.getPincodeDetails(getPincodeDetailsRequestModel);
      return DataSuccess(PincodeDetailsResponse.toEntity());
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
