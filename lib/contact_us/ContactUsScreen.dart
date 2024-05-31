import 'package:lms/contact_us/ContactUSBloc.dart';
import 'package:lms/contact_us/ContactUsDescriptionScreen.dart';
import 'package:lms/contact_us/thank_you.dart';
import 'package:lms/network/requestbean/ContactUsRequestBean.dart';
import 'package:lms/network/responsebean/ContactUsResponseBean.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final contactUSBloc = ContactUSBloc();
  List<ContactUsData> contactUsDataList = [];
  bool isApiResponse = false;
  bool isViewMoreApiResponse = false;
  TextEditingController? searchController;
  TextEditingController? messageController;
  Preferences preferences = new Preferences();
  var userEmail, userName, userMobile;

  @override
  void initState() {
    searchController = TextEditingController();
    messageController = TextEditingController();
    setState(() {
      isApiResponse = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldkey,
        resizeToAvoidBottomInset: false,
        backgroundColor: colorBg,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: colorBg,
          leading: IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: isApiResponse ? SafeArea(
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      headingText(Strings.contact_us),
                      SizedBoxHeightWidget(20.0),
                      Text(
                        Strings.contact_us_msg,
                        style: TextStyle(color: colorBlack, fontSize: 18),
                      ),
                      SizedBox(height: 30),
                      Text(Strings.write_us,style: boldTextStyle_24.copyWith(color: colorBlack)),
                      SizedBox(height: 10),
                      messageField(),
                      SizedBox(height: 30),
                      Center(
                        child: Container(
                          height: 50,
                          width: 140,
                          alignment: Alignment.center,
                          child: Material(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            elevation: 4.0,
                            color: messageController!.text.length < 10? colorGrey : appTheme,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: messageController!.text.length < 10 ? null :() {
                                Utility.isNetworkConnection().then((isNetwork) {
                                  if (isNetwork) {
                                    contactUsAPI();
                                  } else {
                                    Utility.showToastMessage(Strings.no_internet_message);
                                  }
                                });
                              },
                              child: Text(
                                Strings.submit,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      advertiseCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
            : Center(child: Text(Strings.please_wait)),
      ),
    );
  }

  Widget getCommonIssues() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30),
        contactUsDataList.length != 0 ?
        Text(
          Strings.common_issues,
          style: boldTextStyle_24.copyWith(color: colorBlack),
        )
        : SizedBox(),
        SizedBox(height: 10),
       contactUsDataList.length != 0
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: contactUsDataList.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        child: ContactUsIssuesTile(contactUsDataList[index].topic,
                            contactUsDataList[index].description),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => ContactUsDescription(contactUsDataList[index].topic,
                                      contactUsDataList[index].description)));
                        },
                      );
                    },
                  )
                : Text(Strings.issues_not_found),
        Divider(color: colorDarkGray, height: 1),
        !isViewMoreApiResponse &&  contactUsDataList.length != 0
            ? GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: Text(Strings.view_more),
                ),
                onTap: () {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      getMoreCommonIssues();
                    } else {
                      Utility.showToastMessage(Strings.no_internet_message);
                    }
                  });
                },
              )
            : SizedBox(),
      ],
    );
  }

  Widget messageField() {
    final theme = Theme.of(context);
    return StreamBuilder(
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Theme(
          data: theme.copyWith(primaryColor: appTheme),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            obscureText: false,
            controller: messageController,
            style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
            decoration: new InputDecoration(
              counterText: "",
              hintText: Strings.message,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
              focusColor: Colors.grey,
              border: new OutlineInputBorder(
                borderSide: new BorderSide(color: colorBlack),
              ),
            ),
            maxLines: 10,
            minLines: 3,
            keyboardType: TextInputType.multiline,
            onChanged: (value){
              setState(() {
              });
            },
          ),
        );
      },
    );
  }

  Widget advertiseCard() {
    return Center(
      child: Card(
        elevation: 2.0,
        color: colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
          width: 300,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Column(
            children: <Widget>[
              Container(
                // height: 80,
                // width: 80,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: new BoxDecoration(
                  color: colorBg,
                  borderRadius: new BorderRadius.all(Radius.circular(60.0)),
                ),
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                    AssetsImagePath.spark_loan_logo,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                Strings.lms,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: appTheme),
              ),
              SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }

  getMoreCommonIssues() async {
    contactUSBloc.getContactUsData("", 1).then((value) {
      if (value.isSuccessFull!) {
        contactUsDataList.clear();
        setState(() {
          isViewMoreApiResponse = true;
          if (value.contactUsData != null) {
            contactUsDataList.addAll(value.contactUsData!);
          }
        });
      } else {
        commonDialog(context, Strings.something_went_wrong_try, 0);
      }
    });
  }

  getSearchedCommonIssues(String value) {
    contactUSBloc.getContactUsData(value, 1).then((value) {
      if (value.isSuccessFull!) {
        contactUsDataList.clear();
        if (value.contactUsData != null) {
          setState(() {
            contactUsDataList.addAll(value.contactUsData!);
          });
        }
      } else {
        commonDialog(context, Strings.something_went_wrong_try, 0);
      }
    });
  }

  void contactUsAPI() async {
    userEmail = await preferences.getEmail();
    userMobile = await preferences.getMobile();
    if (messageController!.value.text.trim().isEmpty) {
      Utility.showToastMessage(Strings.valid_message);
    } else {
      ContactUsRequestBean contactUsRequestBean = ContactUsRequestBean(
          message: messageController!.value.text.trim());
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      contactUSBloc.contactUs(contactUsRequestBean).then((value) {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = userMobile;
          parameter[Strings.email] = userEmail;
          parameter[Strings.message] = messageController!.value.text.trim();
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.contact_us_prm, parameter);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ThankYouScreen()));
        } else if (value.errorCode == 403) {
          commonDialog(context, Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(value.errorMessage!);
        }
      });
    }
  }
}

class ContactUsIssuesTile extends StatelessWidget {
  final title;
  final description;

  ContactUsIssuesTile(this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: colorDarkGray, height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title,
                        style: TextStyle(
                            color: appTheme,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    SizedBox(height: 2),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: colorBlack, fontSize: 12)),
                    ),
                  ],
                ),
              ),
              Image.asset(AssetsImagePath.forward, height: 18, width: 16),
            ],
          ),
        ),
      ],
    );
  }
}
