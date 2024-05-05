import 'package:choice/feedback/FeedbackDao.dart';
import 'package:choice/network/requestbean/FeedbackRequestBean.dart';
import 'package:choice/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:choice/network/responsebean/FeedbackResponse.dart';

class FeedbackRepository{
  final feedbackDao = FeedbackDao();

  Future<AuthLoginResponse> submitFeedback(FeedbackRequestBean feedbackPopUpRequestBean) => feedbackDao.submitFeedback(feedbackPopUpRequestBean);
}