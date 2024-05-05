import 'package:choice/feedback/FeedbackRepository.dart';
import 'package:choice/network/requestbean/FeedbackRequestBean.dart';
import 'package:choice/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:choice/network/responsebean/FeedbackResponse.dart';

class FeedbackBloc {
  FeedbackBloc();
  final feedbackRepository = FeedbackRepository();

  Future<AuthLoginResponse> submitFeedback(FeedbackRequestBean feedbackPopUpRequestBean) async{
    AuthLoginResponse wrapper = await feedbackRepository.submitFeedback(feedbackPopUpRequestBean);
    return wrapper;
  }
}