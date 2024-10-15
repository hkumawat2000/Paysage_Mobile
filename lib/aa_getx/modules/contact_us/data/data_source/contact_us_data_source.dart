import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/modules/contact_us/data/models/request/contactus_request_model.dart';
import 'package:lms/aa_getx/modules/contact_us/data/models/response/contactus_response_model.dart';

import '../../../../core/network/base_dio.dart';

abstract class ContactUsDataSource {
  Future<ContactUsResponseModel> contactUs(ContactUsRequestModel contactUsRequestModel);
}

class ContactUsDataSourceImpl with BaseDio implements ContactUsDataSource {

  @override
  Future<ContactUsResponseModel> contactUs(ContactUsRequestModel contactUsRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.contactUs, data: contactUsRequestModel.toJson());
      if (response.statusCode == 200) {
        return ContactUsResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

}