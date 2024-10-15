import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/modules/feedback/data/models/request/feedback_request_model.dart';
import 'package:lms/aa_getx/modules/feedback/data/models/response/feedback_response_model.dart';

import '../../../../core/network/base_dio.dart';

abstract class FeedbackDataSource {

  Future<FeedbackResponseModel> submitFeedback(FeedbackRequestModel feedbackRequestModel);

}

class FeedbackDataSourceImpl with BaseDio implements FeedbackDataSource {
  @override
  Future<FeedbackResponseModel> submitFeedback(FeedbackRequestModel feedbackRequestModel) async {
    Dio dio = await getBaseDio();
    try {
      final response = await dio.post(Apis.feedback, data: feedbackRequestModel.toJson());
      if (response.statusCode == 200) {
        return FeedbackResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e) {
      throw handleDioClientError(e);
    }
  }

}