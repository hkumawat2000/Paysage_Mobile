import 'package:lms/login/LoginDao.dart';
import 'package:lms/network/requestbean/LogoutRequestBean.dart';
import 'package:lms/network/responsebean/ProfileResposoneBean.dart';
import 'package:lms/pin/PinScreen.dart';
import 'package:lms/profile/ProfileBloc.dart';
import 'package:lms/shares/LoanOTPVerification.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/ErrorMessageWidget.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/LoadingWidget.dart';
import 'package:lms/widgets/NoDataWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final profileBloc = ProfileBloc();
  Preferences preferences = Preferences();
  Utility utility = new Utility();
  ProfileData profileData = new ProfileData();


  @override
  void initState() {
    getProfile();
    super.initState();
  }

  void getProfile() async {
    profileBloc.getProfile().then((value) {
      if (value.isSuccessFull!) {
        Utility.showToastMessage(Strings.success);
      } else {
        Utility.showToastMessage(Strings.fail);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    "Profile",
                    style: TextStyle(
                        color: appTheme, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: profile(),
          )
        ],
      ),
    );
  }

  Widget profile() {
    return StreamBuilder(
        stream: profileBloc.profileData,
        builder: (context, AsyncSnapshot<ProfileData> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return _buildNoDataWidget();
            } else {
              return getProfileWidget(snapshot);
            }
          } else if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error.toString());
          } else {
            return _buildLoadingWidget();
          }
        });
  }

  Widget getProfileWidget(AsyncSnapshot<ProfileData> snapshot) {
    var user_name = snapshot.data!.firstName! + " " + snapshot.data!.lastName!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.person_pin,
                color: Colors.black,
                size: 60,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("CRN No :",
                              style: TextStyle(color: colorGrey, fontSize: 14)),
                          Text(
                            "123456",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "User Status :",
                                style: TextStyle(color: colorGrey, fontSize: 14),
                              ),
                              Text(
                                "Active",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "KYC Status :",
                                style: TextStyle(color: colorGrey, fontSize: 14),
                              ),
                              Text(
                                "KYC",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'User Profile',
                        style: TextStyle(
                            color: appTheme, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Name',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data != null ? user_name : "",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Father Name',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "OM SAI Kumar",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Mother Name',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "SHRILA OM SAI KUMAR",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Age',
                                style: TextStyle(color: colorGrey, fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "34",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Gender',
                                style: TextStyle(color: colorGrey, fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Male",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Marital Status',
                                style: TextStyle(color: colorGrey, fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Married",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Contact',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data != null ? snapshot.data!.phone! : "",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Address',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "H NO 4-1-300/4/A BTS COLONY,VIKARABAD",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'PAN No',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "xxxxxxxx2P",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Aadhar No',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'xxxxxxxx58',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Bank Details',
                        style: TextStyle(
                            color: appTheme, fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Account Number',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "xxxxxxxxxxxxx97 ",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Penny drop',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "FGHJHGFDFGHJHGF",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: new BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: new BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Registered Date',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "22 JUNE, 2020",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Agent ID',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "5678765",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Source ID: ',
                                style: TextStyle(color: colorGrey, fontSize: 14),
                              ),
                              Text(
                                "5678765",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Source Name: ',
                                style: TextStyle(color: colorGrey, fontSize: 14),
                              ),
                              Text(
                                "SDFG ASDF",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'DMAT Account',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "1234577889",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        snapshot.data != null ? snapshot.data!.email! : " ",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'SPARK Mobile',
                                style: TextStyle(color: colorGrey, fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.data != null ? snapshot.data!.phone! : "",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Emergency Contact',
                                style: TextStyle(color: colorGrey, fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.data != null ? snapshot.data!.phone! : "",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Choice Mobile',
                                style: TextStyle(color: colorGrey, fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                snapshot.data != null ? snapshot.data!.phone! : "",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Loan Account No',
                        style: TextStyle(color: colorGrey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "xxxxxxxxxxxxxx24",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Pending Payment: ',
                                style: TextStyle(color: colorGrey, fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "20,000",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Pending Interest: ',
                                style: TextStyle(color: colorGrey, fontSize: 12),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "20%",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'CBIL Score: ',
                                style: TextStyle(color: colorGrey, fontSize: 14),
                              ),
                              Text(
                                "400",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Referral Code: ',
                                style: TextStyle(color: colorGrey, fontSize: 14),
                              ),
                              Text(
                                "1234",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return ErrorMessageWidget(error: error);
  }

  Widget _buildNoDataWidget() {
    return NoDataWidget();
  }

  Widget _buildLoadingWidget() {
    return LoadingWidget();
  }
}
