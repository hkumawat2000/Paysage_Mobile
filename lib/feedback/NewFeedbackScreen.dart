import 'package:lms/feedback/FeedbackBloc.dart';
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/network/requestbean/FeedbackRequestBean.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';

class NewFeedbackScreen extends StatefulWidget {
  final comeFrom;
  final doNotShowAgain;

  NewFeedbackScreen(this.comeFrom, this.doNotShowAgain);

  @override
  NewFeedbackScreenState createState() => NewFeedbackScreenState();
}

class NewFeedbackScreenState extends State<NewFeedbackScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController? commentController;
  final feedbackBloc = FeedbackBloc();
  bool firstCheck = false;
  bool secondCheck = false;
  bool firstCheckVisibility = false;
  bool secondCheckVisibility = false;
  bool userExperienceCheck = false;
  bool functionalityCheck = false;
  bool otherCheck = false;
  bool suggestionsVisibility = false;
  var submitText = '';
  String main = '', doBetter = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    commentController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        leading: IconButton(
          icon: ArrowToolbarBackwardNavigation(),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: colorBg,
        elevation: 0.0,
        // centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: headingText("Feedback"),
                  ),
                ],
              ),
              SizedBoxHeightWidget(10.0),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text("Please give your valuable feedback"),
                  ),
                ],
              ),
              SizedBoxHeightWidget(20.0),
              firstCheckBox(),
              Visibility(visible: firstCheckVisibility, child: firstFeedBackData()),
              SizedBoxHeightWidget(10.0),
              secondCheckBox(),
              Visibility(visible: secondCheckVisibility, child: secondFeedBackData()),
              SizedBoxHeightWidget(50.0),
              submitFeedback(),
              SizedBoxHeightWidget(50.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget firstCheckBox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: [
          Checkbox(
              value: firstCheck,
              // value: 'first',
              activeColor: appTheme,
              // groupValue: main,
              onChanged: (bool? newValue) {
                setState(() {
                  if (newValue!) {
                    firstCheck = newValue;
                    secondCheck = false;
                    firstCheckVisibility = true;
                    secondCheckVisibility = false;
                    suggestionsVisibility = true;
                    commentController!.text= "";
                  } else {
                    firstCheck = newValue;
                    firstCheckVisibility = false;
                    suggestionsVisibility = false;
                    commentController!.text = "";
                  }
                });
              }),
          Expanded(
            child: Text("LMS have hit the bull's eye with the product",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget secondCheckBox() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        children: [
          Checkbox(
              value: secondCheck,
              activeColor: appTheme,
              onChanged: (bool? newValue) {
                setState(() {
                  if (newValue!) {
                    secondCheck = newValue;
                    firstCheck = false;
                    secondCheckVisibility = true;
                    firstCheckVisibility = false;
                    suggestionsVisibility = false;
                    userExperienceCheck = false;
                    functionalityCheck = false;
                    otherCheck = false;
                    commentController!.text = "";
                  } else {
                    secondCheck = newValue;
                    suggestionsVisibility = false;
                    secondCheckVisibility = false;
                    userExperienceCheck = false;
                    functionalityCheck = false;
                    otherCheck = false;
                    commentController!.text = "";
                  }
                });
              }),
          Expanded(
            child: Text('LMS can do better', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget firstFeedBackData() {
    return Column(
      children: [
        Text('Thank you for appreciating our hard work!!'),
        suggestions(),
      ],
    );
  }

  Widget secondFeedBackData() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 38.0),
          child: Text("You can help us improve our product. Please select"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 28.0),
          child: Column(
            children: [
              userExperienceCheckBox(),
              functionalityCheckBox(),
              otherCheckBox(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: suggestions(),
        ),
      ],
    );
  }

  Widget userExperienceCheckBox() {
    return Row(
      children: [
        Checkbox(
            value: userExperienceCheck,
            activeColor: appTheme,
            onChanged: (bool? newValue) {
              setState(() {
                if (newValue!) {
                  userExperienceCheck = newValue;
                  functionalityCheck = false;
                  otherCheck = false;
                  suggestionsVisibility = true;
                  secondCheck = true;
                  commentController!.text = "";
                } else {
                  userExperienceCheck = newValue;
                  suggestionsVisibility = false;
                  commentController!.text = "";
                }
              });
            }),
        Expanded(
          child: Text('Related to User Experience'),
        ),
      ],
    );
  }

  Widget functionalityCheckBox() {
    return Row(
      children: [
        Checkbox(
            value: functionalityCheck,
            activeColor: appTheme,
            onChanged: (bool? newValue) {
              setState(() {
                if (newValue!) {
                  functionalityCheck = newValue;
                  userExperienceCheck = false;
                  otherCheck = false;
                  suggestionsVisibility = true;
                  secondCheck = true;
                  commentController!.text = "";
                } else {
                  functionalityCheck = newValue;
                  suggestionsVisibility = false;
                  commentController!.text = "";
                }
              });
            }),
        Expanded(
          child: Text('Related to Functionality'),
        ),
      ],
    );
  }

  Widget otherCheckBox() {
    return Row(
      children: [
        Checkbox(
            value: otherCheck,
            activeColor: appTheme,
            onChanged: (newValue) {
              setState(() {
                if (newValue!) {
                  otherCheck = newValue;
                  functionalityCheck = false;
                  userExperienceCheck = false;
                  suggestionsVisibility = true;
                  secondCheck = true;
                  commentController!.text = "";
                } else {
                  otherCheck = newValue;
                  suggestionsVisibility = false;
                  commentController!.text = "";
                }
              });
            }),
        Expanded(
          child: Text('Others'),
        ),
      ],
    );
  }

  Widget suggestions() {
    return Visibility(
      visible: suggestionsVisibility,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 6, 10, 10),
        child: Container(
          height: 120,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(const Radius.circular(8)),
          ),
          child: Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: SizedBox(
                height: 115.0,
                child: TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  controller: commentController,
                  maxLength: 500,
                  maxLines: 50,
                  decoration: InputDecoration(
                    hintText: "You can write your suggestions to us:",
                    hintStyle: TextStyle(fontSize: 12),
                    border: InputBorder.none,
                  ),
                  onTap: (){
                    if(commentController!.text.length <= 500){
                      submitText = commentController!.text;
                    } else {
                      setState(() {
                        commentController!.text = submitText;
                        FocusScope.of(context).unfocus();
                      });
                    }
                  },
                  onChanged: (val){
                    setState(() {
                      if(commentController!.text.length <= 500){
                        submitText = commentController!.text;
                      } else {
                        commentController!.text = submitText;
                        FocusScope.of(context).unfocus();
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget submitFeedback() {
    return Container(
      height: 45,
      width: 145,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        elevation: 1.0,
        color: commentController!.text.length == 0 ? colorGrey : appTheme,
        child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: commentController!.text.length == 0 ? null :() async {
            Utility.isNetworkConnection().then((isNetwork) {
              if (isNetwork) {
                if(commentController!.text.length <= 500){
                  submitFeedbackData();
                } else {
                  Utility.showToastMessage(Strings.more_500_char);
                }
              } else {
                Utility.showToastMessage(Strings.no_internet_message);
              }
            });
          },
          child: Text(
            Strings.submit,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  void submitFeedbackData() {
    if (!firstCheck && !secondCheck) {
      Utility.showToastMessage(Strings.atleast_one_feedback);
    } else {
      if (secondCheck) {
        if (!userExperienceCheck && !functionalityCheck && !otherCheck) {
          Utility.showToastMessage(Strings.atleast_one_favor);
        } else {
          sendFeedbackData();
        }
      } else {
        sendFeedbackData();
      }
    }
  }

  void sendFeedbackData() async {
    Preferences preferences = new Preferences();
    String email = await preferences.getEmail();
    String? mobile = await preferences.getMobile();
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    FeedbackRequestBean? feedbackRequestBean;
    if (widget.comeFrom == Strings.more_menu) {
      feedbackRequestBean = new FeedbackRequestBean(
          doNotShowAgain: widget.doNotShowAgain,
          bullsEye: firstCheck ? 1 : 0,
          canDoBetter: secondCheck ? 1 : 0,
          relatedToUserExperience: userExperienceCheck ? 1 : 0,
          relatedToFunctionality: functionalityCheck ? 1 : 0,
          others: otherCheck ? 1 : 0,
          comment: commentController!.text.toString().trim(),
          fromMoreMenu: 1
      );
    } else if(widget.comeFrom == Strings.pop_up){
      feedbackRequestBean = new FeedbackRequestBean(
          doNotShowAgain: widget.doNotShowAgain,
          bullsEye: firstCheck ? 1 : 0,
          canDoBetter: secondCheck ? 1 : 0,
          relatedToUserExperience: userExperienceCheck ? 1 : 0,
          relatedToFunctionality: functionalityCheck ? 1 : 0,
          others: otherCheck ? 1 : 0,
          comment: commentController!.text.toString().trim(),
          fromMoreMenu: 0
      );
    }
    feedbackBloc.submitFeedback(feedbackRequestBean!).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.do_not_show_again_prm] = feedbackRequestBean!.doNotShowAgain;
        parameter[Strings.bulls_eye] = feedbackRequestBean.bullsEye;
        parameter[Strings.can_do_better] = feedbackRequestBean.canDoBetter;
        parameter[Strings.related_to_user_experience] = feedbackRequestBean.relatedToUserExperience;
        parameter[Strings.related_to_functionality] = feedbackRequestBean.relatedToFunctionality;
        parameter[Strings.others] = feedbackRequestBean.others;
        parameter[Strings.message] = feedbackRequestBean.comment;
        parameter[Strings.from_more_menu] = feedbackRequestBean.fromMoreMenu;
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.feedback_submit, parameter);

        Utility.showToastMessage(value.message!);
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }
}
