class FeedbackRequestEntity {
  int? doNotShowAgain;
  int? bullsEye;
  int? canDoBetter;
  int? relatedToUserExperience;
  int? relatedToFunctionality;
  int? others;
  String? comment;
  int? fromMoreMenu;

  FeedbackRequestEntity(
      {this.doNotShowAgain,
      this.bullsEye,
      this.canDoBetter,
      this.relatedToUserExperience,
      this.relatedToFunctionality,
      this.others,
      this.comment,
      this.fromMoreMenu});
}