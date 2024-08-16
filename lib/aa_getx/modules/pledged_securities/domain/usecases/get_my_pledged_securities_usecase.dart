import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/models/request/my_pledged_securities_request_model.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/my_pledged_securities_details_response_entity.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/repositories/pledged_securities_repository.dart';

class GetMyPledgedSecuritiesUseCase extends UsecaseWithParams<MyPledgedSecuritiesDetailsResponseEntity, MyPledgedSecuritiesRequestParams>{
  final PledgedSecuritiesRepository pledgedSecuritiesRepository;

  GetMyPledgedSecuritiesUseCase(this.pledgedSecuritiesRepository);

  @override
  ResultFuture<MyPledgedSecuritiesDetailsResponseEntity> call(MyPledgedSecuritiesRequestParams params) async{
    return await pledgedSecuritiesRepository.getMyPledgedSecurities(params.myPledgedSecuritiesRequestEntity);
  }


}

class MyPledgedSecuritiesRequestParams {
  final MyPledgedSecuritiesRequestEntity myPledgedSecuritiesRequestEntity;

  MyPledgedSecuritiesRequestParams({required this.myPledgedSecuritiesRequestEntity});
}