import 'package:lms/feedback/FeedbackBloc.dart';
import 'package:lms/feedback/NewFeedbackScreen.dart';
import 'package:lms/network/requestbean/FeedbackRequestBean.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FeedbackDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FeedbackDialogState();
  }
}

class FeedbackDialogState extends State<FeedbackDialog> {
  bool checkBoxValue = false;
  int doNotShow = 0;
  final feedbackBloc = FeedbackBloc();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        height: 120,
        child: Column(
          children: <Widget>[
            Text(Strings.provide_feedback,
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBoxHeightWidget(10.0),
            doNotShowDialogAgain(),
            SizedBoxHeightWidget(10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 30,
                  width: 80,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: doNotShow == 0 ? colorGrey : appTheme,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: doNotShow == 0 ? null : () async {
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            if(doNotShow == 1){
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          NewFeedbackScreen(Strings.pop_up, doNotShow)));
                            }
                          } else {
                            Utility.showToastMessage(Strings.no_internet_message);
                          }
                        });
                      },
                      child: Text(
                        Strings.yes,
                        style: buttonTextWhite,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 80,
                  child: Material(
                    color: colorBg,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(color: red)),
                    elevation: 1.0,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            if(doNotShow == 1){
                              postFeedback();
                            } else {
                              Navigator.pop(context);
                            }
                          } else {
                            Utility.showToastMessage(Strings.no_internet_message);
                          }
                        });
                      },
                      child: Text(
                        Strings.no,
                        style: buttonTextRed,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget doNotShowDialogAgain() {
    return Row(
      children: [
        Transform.scale(
          scale: 0.8,
          child: Checkbox(
              value: checkBoxValue,
              activeColor: appTheme,
              onChanged: (bool? newValue) {
                setState(() {
                  checkBoxValue = newValue!;
                  if (checkBoxValue) {
                    doNotShow = 1;
                  } else {
                    doNotShow = 0;
                  }
                });
              }),
        ),
        Expanded(
          child: Text(
            Strings.do_not_show_again,
            style: TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  postFeedback(){
    Navigator.pop(context);
    // LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    FeedbackRequestBean feedbackRequestBean;
    feedbackRequestBean = new FeedbackRequestBean(
        doNotShowAgain: 1,
        bullsEye: 0,
        canDoBetter: 0,
        relatedToUserExperience: 0,
        relatedToFunctionality: 0,
        others: 0,
        comment: '',
        fromMoreMenu: 0
    );
    feedbackBloc.submitFeedback(feedbackRequestBean).then((value) {
      if (value.isSuccessFull!) {
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }
}
