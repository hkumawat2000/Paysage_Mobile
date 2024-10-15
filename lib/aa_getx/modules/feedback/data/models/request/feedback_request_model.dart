// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/feedback/domain/entities/request/feedback_request_entity.dart';

class FeedbackRequestModel {
  int? doNotShowAgain;
  int? bullsEye;
  int? canDoBetter;
  int? relatedToUserExperience;
  int? relatedToFunctionality;
  int? others;
  String? comment;
  int? fromMoreMenu;

  FeedbackRequestModel(
      {this.doNotShowAgain,
      this.bullsEye,
      this.canDoBetter,
      this.relatedToUserExperience,
      this.relatedToFunctionality,
      this.others,
      this.comment,
      this.fromMoreMenu});

  FeedbackRequestModel.fromJson(Map<String, dynamic> json) {
    doNotShowAgain = json['do_not_show_again'];
    bullsEye = json['bulls_eye'];
    canDoBetter = json['can_do_better'];
    relatedToUserExperience = json['related_to_user_experience'];
    relatedToFunctionality = json['related_to_functionality'];
    others = json['others'];
    comment = json['comment'];
    fromMoreMenu = json['from_more_menu'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['do_not_show_again'] = this.doNotShowAgain;
    data['bulls_eye'] = this.bullsEye;
    data['can_do_better'] = this.canDoBetter;
    data['related_to_user_experience'] = this.relatedToUserExperience;
    data['related_to_functionality'] = this.relatedToFunctionality;
    data['others'] = this.others;
    data['comment'] = this.comment;
    data['from_more_menu'] = this.fromMoreMenu;
    return data;
  }

  factory FeedbackRequestModel.fromEntity(
      FeedbackRequestEntity feedbackRequestEntity) {
    return FeedbackRequestModel(
      doNotShowAgain: feedbackRequestEntity.doNotShowAgain != null
          ? feedbackRequestEntity.doNotShowAgain as int
          : null,
      bullsEye: feedbackRequestEntity.bullsEye != null
          ? feedbackRequestEntity.bullsEye as int
          : null,
      canDoBetter: feedbackRequestEntity.canDoBetter != null
          ? feedbackRequestEntity.canDoBetter as int
          : null,
      relatedToUserExperience:
          feedbackRequestEntity.relatedToUserExperience != null
              ? feedbackRequestEntity.relatedToUserExperience as int
              : null,
      relatedToFunctionality:
          feedbackRequestEntity.relatedToFunctionality != null
              ? feedbackRequestEntity.relatedToFunctionality as int
              : null,
      others: feedbackRequestEntity.others != null
          ? feedbackRequestEntity.others as int
          : null,
      comment: feedbackRequestEntity.comment != null
          ? feedbackRequestEntity.comment as String
          : null,
      fromMoreMenu: feedbackRequestEntity.fromMoreMenu != null
          ? feedbackRequestEntity.fromMoreMenu as int
          : null,
    );
  }
}
