import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/models/request/my_cart_request_model.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/models/response/my_cart_response_model.dart';

abstract class MyCartDatasource{
  Future<MyCartResponseModel> myCart(MyCartRequestModel myCartRequestModel);
}

class MyCartDatasourceImpl with BaseDio implements MyCartDatasource{

Future<MyCartResponseModel> myCart(MyCartRequestModel mfSchemeRequestmodel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.cartUpsert);
      if (response.statusCode == 200) {
        return MyCartResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}