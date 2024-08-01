// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/consent_text_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_download_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/download_kyc_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/get_consent_details_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/repositories/kyc_repository.dart';

/// use case is a class responsible for encapsulating a specific piece of business logic or
/// a particular operation that your application needs to perform.
/// It acts as a bridge between the presentation
/// layer and the data layer.
class ConsentTextKycUsecase
    implements
        UsecaseWithParams<ConsentTextResponseEntity, ConsentTextKycParams> {
  final KycRepository kycRepository;
  ConsentTextKycUsecase(this.kycRepository);

  @override
  ResultFuture<ConsentTextResponseEntity> call(params) async {
    return await kycRepository
        .getConsentText(params.getConsentDetailsRequestEntity);
  }
}

class ConsentTextKycParams {
  final GetConsentDetailsRequestEntity getConsentDetailsRequestEntity;
  ConsentTextKycParams({
    required this.getConsentDetailsRequestEntity,
  });
}
