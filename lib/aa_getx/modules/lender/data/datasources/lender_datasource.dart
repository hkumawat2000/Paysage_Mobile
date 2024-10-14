import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/lender/data/models/lender_response_model.dart';

abstract class LenderDatasource {
  Future<LenderResponseModel> getLendersList();
}

class LenderDatasourceImpl with BaseDio implements LenderDatasource {

  Future<LenderResponseModel> getLendersList() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.lenders);
      if (response.statusCode == 200) {
        return LenderResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}
