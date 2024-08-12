import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/dashboard/data/models/force_update_response_model.dart';

/// DashboardDataSource is an abstract class defining the contract for fetching
/// data from various sources.
/// This abstract class outlines the methods that concrete data source
/// implementations should implement, such as fetching data from a remote API, local database, or any other data source.
abstract class DashboardDataSource {
  Future<ForceUpdateResponseModel> forceUpdate();
}

/// DashboardDataSourceDataSourceImpl is the concrete implementation of the DashboardDataSource
/// interface.
/// This class implements the methods defined in DashboardDataSource to fetch
/// data from a remote API or other data sources.
class DashboardDataSourceDataSourceImpl
    with BaseDio
    implements DashboardDataSource {
  Future<ForceUpdateResponseModel> forceUpdate() async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.get(Apis.forceUpdate);
      if (response.statusCode == 200) {
        return ForceUpdateResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }
}
