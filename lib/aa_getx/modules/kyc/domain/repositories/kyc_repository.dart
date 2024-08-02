import 'package:lms/aa_getx/core/utils/type_def.dart';
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

/// KycRepository is an abstract class defining the contract for operations
/// related to data within the domain layer.
/// Concrete implementations of this repository interface will be provided
/// in the data layer to interact with specific data sources (e.g., API, database).
abstract class KycRepository {
  ResultFuture<KYCSearchResponseEntity> kycSearch(
      SearchKycRequestEntity searchKycRequestEntity);
  ResultFuture<KycDownloadResponseEntity> kycDownload(
      DownloadKycRequestEntity downloadKycRequestEntity);
  ResultFuture<ConsentTextResponseEntity> getConsentText(
      GetConsentDetailsRequestEntity getConsentDetailsRequestEntity);
  ResultFuture<ConsentDetailResponseEntity> getConsentDetails(
      ConsentDetailsRequestEntity consentDetailsRequestEntity);
  ResultFuture<PincodeResponseEntity> getPincodeDetails(
      GetPincodeDetailsRequestEntity getPincodeDetailsRequestEntity);
  
}
