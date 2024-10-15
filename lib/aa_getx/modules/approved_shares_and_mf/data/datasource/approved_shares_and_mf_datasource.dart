import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/data/models/approved_securities_response_model.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/data/models/demat_acct_response_model.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/data/models/request/approved_securities_request_model.dart';

abstract class ApprovedSharesAndMfDatasource {
  Future<DematAcctResponseModel> getDematAccountDetails();
  Future<ApprovedSecuritiesResponseModel> getApprovedSecurities(ApprovedSecuritiesRequestModel approvedSecuritiesRequestModel);
}

class ApprovedSharedAndMfDataSourceImpl
    with BaseDio
    implements ApprovedSharesAndMfDatasource {

  Future<DematAcctResponseModel> getDematAccountDetails() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.dematAcDetails);
      if (response.statusCode == 200) {
        return DematAcctResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }


  Future<ApprovedSecuritiesResponseModel> getApprovedSecurities(
      ApprovedSecuritiesRequestModel approvedSecuritiesRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(
        Apis.approvedSecuritiesList,
        data: approvedSecuritiesRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return ApprovedSecuritiesResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}
