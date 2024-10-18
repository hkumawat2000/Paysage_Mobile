import 'package:lms/aa_getx/core/utils/base_usecase.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/entities/request/additional_account_details_request_entity.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/entities/response/additional_account_details_response_entity.dart';
import 'package:lms/aa_getx/modules/additional_account_details/domain/repositories/additional_acc_details_repository.dart';

class AdditionalAccountDetailsUsecase extends UsecaseWithParams<
    AdditionalAccountResponseEntity, AdditionalAccountDetailsParams> {
  AdditionalAccDetailsRepository additionalAccDetailsRepository;
  AdditionalAccountDetailsUsecase(this.additionalAccDetailsRepository);

  @override
  ResultFuture<AdditionalAccountResponseEntity> call(params) async {
    return await additionalAccDetailsRepository
        .mycamsAccount(params.accountdetailsRequestEntity);
  }
}

class AdditionalAccountDetailsParams {
  final AdditionalAccountdetailsRequestEntity accountdetailsRequestEntity;
  AdditionalAccountDetailsParams({required this.accountdetailsRequestEntity});
}
