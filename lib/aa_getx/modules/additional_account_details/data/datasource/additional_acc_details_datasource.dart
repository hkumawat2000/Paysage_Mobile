import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/modules/additional_account_details/data/models/request/additional_account_details_request_model.dart';
import 'package:lms/aa_getx/modules/additional_account_details/data/models/response/additional_account_details_response_model.dart';
import 'package:lms/util/base_dio.dart';

abstract class AdditionalAccDetailsDatasource {
  Future<AdditionalAccountResponseModel> mycamsAccount( AdditionalAccountdetailsRequestModel additionalAccDetailsRequestModel);
}

class AdditionalAccDetailsDatasourceImpl extends BaseDio
    implements AdditionalAccDetailsDatasource {

  Future<AdditionalAccountResponseModel> mycamsAccount(
      AdditionalAccountdetailsRequestModel additionalAccDetailsRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.camsDetails,data: additionalAccDetailsRequestModel.toJson());
      if (response.statusCode == 200) {
        return AdditionalAccountResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}
