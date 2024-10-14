import 'package:lms/aa_getx/modules/feedback/data/models/request/feedback_request_model.dart';
import 'package:lms/aa_getx/modules/feedback/data/models/response/feedback_response_model.dart';

import '../../../../core/network/base_dio.dart';

abstract class FeedbackDataSource {

  Future<FeedbackResponseModel> submitFeedback(FeedbackRequestModel feedbackRequestModel);

}

class FeedbackDataSourceImpl with BaseDio implements CibilDataSource {

}