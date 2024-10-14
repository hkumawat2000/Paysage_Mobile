import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/models/response/mf_scheme_response_model.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/data/models/request/mf_scheme_request_model.dart';

abstract class PledgeMfDatasource{
  Future<MfSchemeResponseModel> getSchemesList(MFSchemeRequestModel mfSchemeRequestmodel);

}

class PledgeMfDatasourceImpl with BaseDio implements PledgeMfDatasource{
  
  Future<MfSchemeResponseModel> getSchemesList(MFSchemeRequestModel mfSchemeRequestmodel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.getScheme);
      if (response.statusCode == 200) {
        return MfSchemeResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}