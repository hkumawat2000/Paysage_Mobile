import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/feedback/domain/entities/request/feedback_request_entity.dart';
import 'package:lms/aa_getx/modules/feedback/domain/entities/response/feedback_response_entity.dart';
import 'package:lms/aa_getx/modules/feedback/domain/repositories/feedback_repository.dart';

class FeedbackUsecase implements UsecaseWithParams<FeedbackResponseEntity, FeedbackParams>{

  final FeedbackRepository feedbackRepository;
  FeedbackUsecase(this.feedbackRepository);

  @override
  ResultFuture<FeedbackResponseEntity> call(FeedbackParams params) async {
    return await feedbackRepository.submitFeedback(params.feedbackRequestEntity);
  }


}

class FeedbackParams {
  final FeedbackRequestEntity feedbackRequestEntity;
  FeedbackParams({
    required this.feedbackRequestEntity,
  });
}