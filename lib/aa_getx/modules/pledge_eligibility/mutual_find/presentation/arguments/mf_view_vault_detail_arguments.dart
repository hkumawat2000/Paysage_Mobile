import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/my_cart_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/mf_scheme_response_entity.dart';

class MfViewVaultDetailArguments {
  MyCartRequestEntity mfCartRequestEntity;
  List<SchemesListEntity> mfSchemesListEntity;
  MfViewVaultDetailArguments({
    required this.mfCartRequestEntity,
    required this.mfSchemesListEntity,
  });
}
