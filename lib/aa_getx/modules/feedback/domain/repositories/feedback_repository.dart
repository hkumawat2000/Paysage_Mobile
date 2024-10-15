import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/feedback/domain/entities/request/feedback_request_entity.dart';
import 'package:lms/aa_getx/modules/feedback/domain/entities/response/feedback_response_entity.dart';

abstract class FeedbackRepository {

  ResultFuture<FeedbackResponseEntity> submitFeedback(FeedbackRequestEntity feedbackRequestEntity);

}