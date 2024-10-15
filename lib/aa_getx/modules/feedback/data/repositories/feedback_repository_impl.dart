import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/feedback/data/data_source/feedback_data_source.dart';
import 'package:lms/aa_getx/modules/feedback/data/models/request/feedback_request_model.dart';
import 'package:lms/aa_getx/modules/feedback/domain/entities/request/feedback_request_entity.dart';
import 'package:lms/aa_getx/modules/feedback/domain/entities/response/feedback_response_entity.dart';
import 'package:lms/aa_getx/modules/feedback/domain/repositories/feedback_repository.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utils/type_def.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {

  final FeedbackDataSource feedbackDataSource;
  FeedbackRepositoryImpl(this.feedbackDataSource);


  @override
  ResultFuture<FeedbackResponseEntity> submitFeedback(FeedbackRequestEntity feedbackRequestEntity) async {
    try {
      FeedbackRequestModel feedbackRequestModel =
      FeedbackRequestModel.fromEntity(feedbackRequestEntity);
      final cibilOtpVerificationResponseModel =
      await feedbackDataSource.submitFeedback(feedbackRequestModel);
      return DataSuccess(cibilOtpVerificationResponseModel.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }

}
