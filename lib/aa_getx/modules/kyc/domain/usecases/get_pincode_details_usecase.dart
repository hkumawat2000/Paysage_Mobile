// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_consent_details_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/pincode_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/consent_details_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/request/get_pincode_details_request_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/repositories/kyc_repository.dart';

/// use case is a class responsible for encapsulating a specific piece of business logic or
/// a particular operation that your application needs to perform.
/// It acts as a bridge between the presentation
/// layer and the data layer.
class GetPincodeDetailsUsecase
    implements
        UsecaseWithParams<PincodeResponseEntity, PincodeDetailsParams> {
  final KycRepository kycRepository;
  GetPincodeDetailsUsecase(this.kycRepository);

  @override
  ResultFuture<PincodeResponseEntity> call(params) async {
    return await kycRepository
        .getPincodeDetails(params.getPincodeDetailsRequestEntity);
  }
}

class PincodeDetailsParams {
  final GetPincodeDetailsRequestEntity getPincodeDetailsRequestEntity;
  PincodeDetailsParams({
    required this.getPincodeDetailsRequestEntity,
  });
}
