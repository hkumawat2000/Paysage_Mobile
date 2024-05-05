class FeedbackRequestBean {
  int? doNotShowAgain;
  int? bullsEye;
  int? canDoBetter;
  int? relatedToUserExperience;
  int? relatedToFunctionality;
  int? others;
  String? comment;
  int? fromMoreMenu;

  FeedbackRequestBean(
      {this.doNotShowAgain,
        this.bullsEye,
        this.canDoBetter,
        this.relatedToUserExperience,
        this.relatedToFunctionality,
        this.others,
        this.comment,
        this.fromMoreMenu});

  FeedbackRequestBean.fromJson(Map<String, dynamic> json) {
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
}
