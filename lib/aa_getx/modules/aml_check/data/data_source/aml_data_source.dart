import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/aml_check/data/models/aml_check_response_model.dart';


abstract class AmlCheckDataSourceApi {
  Future<AmlCheckResponseModel> amlCheck();
}


class AmlDataSourceApiImp with BaseDio implements AmlCheckDataSourceApi{

  @override
  Future<AmlCheckResponseModel> amlCheck() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.amlCheck);
      if (response.statusCode == 200) {
        return AmlCheckResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

}