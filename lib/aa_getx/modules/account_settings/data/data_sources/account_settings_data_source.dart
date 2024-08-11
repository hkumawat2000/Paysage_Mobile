import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/account_settings/data/models/request/update_profile_and_pin_request_model.dart';
import 'package:lms/aa_getx/modules/account_settings/data/models/update_profile_and_pin_response_model.dart';

/// AccountSettingsDataSource is an abstract class defining the contract for fetching
/// data from various sources.
/// This abstract class outlines the methods that concrete data source
/// implementations should implement, such as fetching data from a remote API, local database, or any other data source.
abstract class AccountSettingsDataSource {
  Future<UpdateProfileAndPinResponseModel> updateProfilePicAndPin(
      UpdateProfileAndPinRequestModel updateProfileAndPinRequestModel);


}



/// AccountSettingsDataSourceImpl is the concrete implementation of the AccountSettingsDataSource
/// interface.
/// This class implements the methods defined in AccountSettingsDataSource to fetch
/// data from a remote API or other data sources.
class AccountSettingsDataSourceImpl with BaseDio implements AccountSettingsDataSource {
  
    Future<UpdateProfileAndPinResponseModel> updateProfilePicAndPin(
      UpdateProfileAndPinRequestModel updateProfileAndPinRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(
        Apis.updateProfileAndPin,
        data: updateProfileAndPinRequestModel.toJson(),
      );
      if (response.statusCode == 200) {
        return UpdateProfileAndPinResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }


}