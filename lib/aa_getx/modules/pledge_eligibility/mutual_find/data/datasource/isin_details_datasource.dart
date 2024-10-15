import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/models/request/isin_details_request_model.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/models/response/isin_details_response_model.dart';

abstract class IsinDetailsDatasource {
  Future<IsinDetailResponseModel> getIsinDetails(
      IsinDetailsRequestModel isinDetailsRequestModel);
}

class IsinDetailsDatasourceImpl with BaseDio implements IsinDetailsDatasource {
  Future<IsinDetailResponseModel> getIsinDetails(
      IsinDetailsRequestModel isinDetailsRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(
        Apis.isinDetails,
        data: isinDetailsRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return IsinDetailResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}
