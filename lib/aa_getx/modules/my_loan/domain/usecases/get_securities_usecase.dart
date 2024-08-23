
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/request/securities_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/securities_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/repositories/my_loans_repository.dart';

class GetSecuritiesUseCase extends UsecaseWithParams<SecuritiesResponseEntity, SecuritiesRequestParams>{
  final MyLoansRepository _myLoansRepository;
  
  GetSecuritiesUseCase(this._myLoansRepository);

  @override
  ResultFuture<SecuritiesResponseEntity> call(params) async{
    return await _myLoansRepository.getSecurities(params.securitiesRequestEntity);
  }
}

class SecuritiesRequestParams{
  final SecuritiesRequestEntity securitiesRequestEntity;

  SecuritiesRequestParams({required this.securitiesRequestEntity});
}