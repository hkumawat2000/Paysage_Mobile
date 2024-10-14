// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/feedback/domain/entities/response/feedback_response_entity.dart';

class FeedbackResponseModel {
  String? message;

  FeedbackResponseModel({this.message});

  FeedbackResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }

  FeedbackResponseEntity toEntity() =>
  FeedbackResponseEntity(
      message: message,
  
  );
}
