import 'package:lms/feedback/FeedbackDao.dart';
import 'package:lms/network/requestbean/FeedbackRequestBean.dart';
import 'package:lms/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:lms/network/responsebean/FeedbackResponse.dart';

class FeedbackRepository{
  final feedbackDao = FeedbackDao();

  Future<AuthLoginResponse> submitFeedback(FeedbackRequestBean feedbackPopUpRequestBean) => feedbackDao.submitFeedback(feedbackPopUpRequestBean);
}