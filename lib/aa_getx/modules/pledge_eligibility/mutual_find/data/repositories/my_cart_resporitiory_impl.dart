import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/datasource/my_cart_datasource.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/models/request/my_cart_request_model.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/my_cart_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/my_cart_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/repositories/my_cart_repository.dart';

class MyCartResporitioryImpl implements MyCartRepository {
  final MyCartDatasource myCartDatasource;

  MyCartResporitioryImpl(this.myCartDatasource);

  ResultFuture<MyCartResponseEntity> myCart(
      MyCartRequestEntity myCartRequestEntity) async {
    try {
      MyCartRequestModel myCartRequestModel =
          MyCartRequestModel.fromEntity(myCartRequestEntity);
      final myCartResponse =
          await myCartDatasource.myCart(myCartRequestModel);
      return DataSuccess(myCartResponse.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(
          ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }
}
