import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/common_response_model.dart';
import 'package:lms/aa_getx/modules/sell_collateral/data/models/request/sell_collateral_request_model.dart';
import 'package:lms/aa_getx/modules/sell_collateral/data/models/request/sell_collateral_response_model.dart';

abstract class SellCollateralDatasource {
  Future<CommonResponseModel> requestSellCollateralOTP();

  Future<SellCollateralResponseModel> requestSellCollateralSecurities(SellCollateralRequestModel sellCollateralRequestModel);
}

class SellCollateralDatasourceImpl with BaseDio implements SellCollateralDatasource {

  @override
  Future<CommonResponseModel> requestSellCollateralOTP()  async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(
        Apis.sellCollateralOtp,
      );
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

  @override
  Future<SellCollateralResponseModel> requestSellCollateralSecurities(SellCollateralRequestModel sellCollateralRequestModel)  async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.sellCollateral,
          data: sellCollateralRequestModel.toJson());
      if (response.statusCode == 200) {
        return SellCollateralResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}