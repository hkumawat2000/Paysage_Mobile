import 'package:lms/feedback/FeedbackRepository.dart';
import 'package:lms/network/requestbean/FeedbackRequestBean.dart';
import 'package:lms/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:lms/network/responsebean/FeedbackResponse.dart';

class FeedbackBloc {
  FeedbackBloc();
  final feedbackRepository = FeedbackRepository();

  Future<AuthLoginResponse> submitFeedback(FeedbackRequestBean feedbackPopUpRequestBean) async{
    AuthLoginResponse wrapper = await feedbackRepository.submitFeedback(feedbackPopUpRequestBean);
    return wrapper;
  }
}