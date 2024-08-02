import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/consent_text_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/kyc_consent_details_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/kyc_download_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/kyc_search_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/pincode_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/request/consent_details_request_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/request/download_kyc_request_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/request/get_consent_details_request_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/request/get_pincode_details_request_model.dart';
import 'package:lms/aa_getx/modules/kyc/data/models/request/search_kyc_request_model.dart';

/// KycDataSource is an abstract class defining the contract for fetching
/// data from various sources.
/// This abstract class outlines the methods that concrete data source
/// implementations should implement, such as fetching data from a remote API, local database, or any other data source.
abstract class KycDataSource {
  Future<KYCSearchResponseModel> kycSearch(
      SearchKycRequestModel searchKycRequestModel);
  Future<KYCDownloadResponseModel> kycDownload(
      DownloadKycRequestModel downloadKycRequestModel);
  Future<ConsentTextResponseModel> getConsentText(
      GetConsentDetailsRequestModel getConsentDetailsRequestModel);
  Future<ConsentDetailResponseModel> getConsentDetails(
      ConsentDetailsRequestModel consentDetailsRequestModel);
  Future<PincodeResponseModel> getPincodeDetails(
      GetPincodeDetailsRequestModel getPincodeDetailsRequestModel);
}

/// KycDataSourceImpl is the concrete implementation of the KycDataSource
/// interface.
/// This class implements the methods defined in KycDataSource to fetch
/// data from a remote API or other data sources.
class KycDataSourceImpl with BaseDio implements KycDataSource {
  Future<KYCSearchResponseModel> kycSearch(
      SearchKycRequestModel searchKycRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(
        Apis.kycSearch,
        data: searchKycRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return KYCSearchResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  Future<KYCDownloadResponseModel> kycDownload(
      DownloadKycRequestModel downloadKycRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(
        Apis.kycDownload,
        data: downloadKycRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return KYCDownloadResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  Future<ConsentTextResponseModel> getConsentText(
      GetConsentDetailsRequestModel getConsentDetailsRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(
        Apis.consentText,
        data: getConsentDetailsRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return ConsentTextResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  Future<ConsentDetailResponseModel> getConsentDetails(
      ConsentDetailsRequestModel consentDetailsRequestEntity) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(
        Apis.consentDetails,
        data: consentDetailsRequestEntity.toJson(),
      );
      if (response.statusCode == 200) {
        return ConsentDetailResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  Future<PincodeResponseModel> getPincodeDetails(
      GetPincodeDetailsRequestModel getPincodeDetailsRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(
        Apis.getPinCode,
        data: getPincodeDetailsRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return PincodeResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}
