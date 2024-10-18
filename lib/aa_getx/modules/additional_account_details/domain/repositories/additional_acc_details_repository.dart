import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/entities/request/additional_account_details_request_entity.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/entities/response/additional_account_details_response_entity.dart';

abstract class AdditionalAccDetailsRepository{
  ResultFuture<AdditionalAccountResponseEntity> mycamsAccount(AdditionalAccountdetailsRequestEntity additionAccDetailsRequestEntity);
}