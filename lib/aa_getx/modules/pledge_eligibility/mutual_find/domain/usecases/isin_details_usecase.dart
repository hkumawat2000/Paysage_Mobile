import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/isin_details_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/isin_details_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/repositories/isin_details_repository.dart';

class IsinDetailsUsecase
    implements
        UsecaseWithParams<IsinDetailResponseEntity, IsinDetailsRequestParams> {
  IsinDetailsRepository isinDetailsRepository;
  IsinDetailsUsecase(this.isinDetailsRepository);

  @override
  ResultFuture<IsinDetailResponseEntity> call(params) async {
    return await isinDetailsRepository
        .getIsinDetails(params.isinDetailsRequestEntity);
  }
}

class IsinDetailsRequestParams {
  final IsinDetailsRequestEntity isinDetailsRequestEntity;
  IsinDetailsRequestParams({required this.isinDetailsRequestEntity});
}
