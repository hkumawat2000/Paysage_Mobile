import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/data_sources/pledged_securities_api.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/models/request/my_pledged_securities_request_model.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/my_pledged_securities_details_response_entity.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/repositories/pledged_securities_repository.dart';

class PledgedSecuritiesRepositoryImpl extends PledgedSecuritiesRepository{
  final PledgedSecuritiesApi pledgedSecuritiesApi;

  PledgedSecuritiesRepositoryImpl(this.pledgedSecuritiesApi);
  @override
  ResultFuture<MyPledgedSecuritiesDetailsResponseEntity> getMyPledgedSecurities(MyPledgedSecuritiesRequestEntity myPledgedSecuritiesRequestEntity) async {
    try {
      MyPledgedSecuritiesRequestModel myPledgedSecuritiesRequestModel = MyPledgedSecuritiesRequestModel.fromEntity(myPledgedSecuritiesRequestEntity);
      final response = await pledgedSecuritiesApi.getMyPledgedSecurities(myPledgedSecuritiesRequestModel);
      return DataSuccess(response.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e){
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }
}
