
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/network/responsebean/MyLoansResponse.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/ErrorMessageWidget.dart';
import 'package:lms/widgets/LoadingWidget.dart';
import 'package:lms/widgets/NoDataWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:grouped_buttons/grouped_buttons.dart';

import 'MyLoansBloc.dart';
import 'SingleMyActiveLoanScreen.dart';

class MyActiveLoanScreen extends StatefulWidget {
  @override
  MyActiveLoanScreenState createState() => MyActiveLoanScreenState();
}

enum SingingCharacter { lafayette, jefferson }

class MyActiveLoanScreenState extends State<MyActiveLoanScreen>
    with SingleTickerProviderStateMixin {
  Preferences? preferences;
  final myLoansBloc = MyLoansBloc();
  int selectedValue = 1;
  List<String> _texts = [];
  String? loan_selecte;
  SingingCharacter _character = SingingCharacter.lafayette;

  void getLoanDetails() async {
//    MyLoansResponse temp = await myLoansBloc.myActiveLoans();
  }

  @override
  void initState() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getLoanDetails();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: colorBg, body: getMyLoansList());
  }

  Widget getMyLoansList() {
    return StreamBuilder(
      stream: myLoansBloc.myActiveLoan,
      builder: (context, AsyncSnapshot<MyLoansData> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null || snapshot.data!.loans!.length == 0) {
            return _buildNoDataWidget();
          } else {
            return myActiveLoans(snapshot);
          }
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget myActiveLoans(AsyncSnapshot<MyLoansData> snapshot) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: 10,
                ),
                activeLoanCard(snapshot)
              ]),
            )
          ];
        },
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            activeLoanItem(snapshot),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    'Loans(${snapshot.data!.loans!.length.toString()})',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: appTheme),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            totalLoanList(snapshot),
            SizedBox(
              height: 5,
            ),
            applicationunderProcess()
          ],
        ));
  }

  Widget activeLoanCard(AsyncSnapshot<MyLoansData> snapshot) {
    var totalCollateralValue, totalSanctionedValue, totalLoanBalance;
    if (snapshot.data!.totalDrawingPower != 0)
      totalCollateralValue = roundDouble(snapshot.data!.totalDrawingPower!, 2);
    if (snapshot.data!.totalSanctionedLimit != 0)
      totalSanctionedValue = roundDouble(snapshot.data!.totalSanctionedLimit!, 2);
    if (snapshot.data!.totalOutstanding != 0)
      totalLoanBalance = roundDouble(snapshot.data!.totalOutstanding!, 2);
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: colorLightBlue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0)), // set rounded corner radius
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
//                              ReusableSubmitButton(),
                              Icon(
                                Icons.share,
                                size: 15,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '₹ ${totalSanctionedValue != null ? totalSanctionedValue.toString() : "0"}',
                                style: boldTextStyle_30,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 3.0, left: 10.0),
                                child: Container(
                                  height: 40.0,
                                  width: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '₹${totalCollateralValue != null ? totalCollateralValue.toString() : "0"}',
                                style: boldTextStyle_30,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, bottom: 8.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'SANCTIONED LIMIT',
                                style: kSecurityLiteStyle.copyWith(fontSize: 12.0),
                              ),
                              Text(
                                'DRAWING POWER',
                                style: kSecurityLiteStyle.copyWith(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, bottom: 8.0, right: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '₹${totalLoanBalance != null ? totalLoanBalance.toString() : "0"}',
                                style: boldTextStyle_30,
                              ),
                              Text(
                                'LOAN BALANCE',
                                style: kSecurityLiteStyle.copyWith(fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: RaisedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'VIEW STATEMENT',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: colorWhite,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  shape: new RoundedRectangleBorder(
//                                borderRadius: new BorderRadius.circular(30.0),
                                      borderRadius: new BorderRadius.only(
                                          bottomLeft: Radius.circular(15.0),
                                          bottomRight: Radius.circular(15.0))),
                                  textColor: Colors.white,
                                  color: appTheme,
                                  onPressed: () {
//                                    Navigator.push(
//                                      context,
//                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget activeLoanList(AsyncSnapshot<MyLoansData> snapshot) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: snapshot.data!.loans!.length,
      itemBuilder: (context, index) {
        return activeLoanItem(snapshot);
      },
    );
  }

  Widget activeLoanItem(AsyncSnapshot<MyLoansData> snapshot) {
    return Column(
      children: <Widget>[
        snapshot.data!.totalTotalCollateralValue != null
            ? Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 3.0),
                              // set border width
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              // set rounded corner radius
                              boxShadow: [
                                BoxShadow(blurRadius: 10, color: Colors.white, offset: Offset(1, 3))
                              ] // make rounded corner of border
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.yellowAccent,
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                        // set rounded corner radius
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              color: Colors.white,
                                              offset: Offset(1, 3))
                                        ] // make rounded corner of border
                                        ),
                                    child: Icon(
                                      Icons.restore,
                                      size: 30.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Collateral Value",
                                          style: TextStyle(color: colorLightGray, fontSize: 12)),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '₹${snapshot.data!.totalTotalCollateralValue != null ? snapshot.data!.totalTotalCollateralValue.toString() : "0"}',
                                        style: TextStyle(
                                            color: appTheme,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        snapshot.data!.totalMarginShortfall != 0.0
            ? Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 3.0),
                              // set border width
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              // set rounded corner radius
                              boxShadow: [
                                BoxShadow(blurRadius: 10, color: Colors.white, offset: Offset(1, 3))
                              ] // make rounded corner of border
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                        color: Colors.yellowAccent,
                                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                        // set rounded corner radius
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 10,
                                              color: Colors.white,
                                              offset: Offset(1, 3))
                                        ] // make rounded corner of border
                                        ),
                                    child: Icon(
                                      Icons.restore,
                                      size: 30.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Margin ShortFall",
                                              style:
                                                  TextStyle(color: colorLightGray, fontSize: 12)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            '₹${snapshot.data!.totalMarginShortfall != null ? snapshot.data!.totalMarginShortfall.toString() : "0"}',
                                            style: TextStyle(
                                                color: appTheme,
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: IconButton(
                                              onPressed: () async {
                                                showModalBottomSheet(
                                                    backgroundColor: Colors.transparent,
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder: (BuildContext bc) {
                                                      return marginshortFallInfo(
                                                          snapshot.data!.totalTotalCollateralValue,
                                                          snapshot.data!.totalMarginShortfall);
                                                    });
                                              },
                                              icon: Icon(
                                                Icons.info_outline,
                                                color: Colors.blue,
                                              ),
                                              iconSize: 12,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text("")
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              snapshot.data!.totalMarginShortfall.toString() != null
                                  ? takeActionWidget(0, snapshot)
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  Widget takeActionWidget(index, AsyncSnapshot<MyLoansData> snapshot) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 3,
        ),
        SizedBox(
          width: 70,
          height: 25,
          child: RaisedButton(
            color: appTheme,
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext bc) {
                    return marginshortFallAction(index, snapshot);
                  });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Take Action",
              style: TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget totalLoanList(AsyncSnapshot<MyLoansData> snapshot) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: snapshot.data!.loans!.length,
      itemBuilder: (context, index) {
        return totalLoanListItem(snapshot, index);
      },
    );
  }

  Widget totalLoanListItem(AsyncSnapshot<MyLoansData> snapshot, index) {
    var obBal = roundDouble(snapshot.data!.loans![index].drawingPower!, 2);
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(10),
          color: colorWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Acc No.",
                    style: TextStyle(fontSize: 12, color: colorLightGray),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    snapshot.data!.loans![index].name!,
                    style:
                        TextStyle(fontSize: 18, color: colorDarkGray, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "OD Bal",
                    style: TextStyle(fontSize: 12, color: colorLightGray),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "₹ ${obBal != null ? obBal.toString() : "0"}",
                    style:
                        TextStyle(fontSize: 18, color: colorDarkGray, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.filter_frames,
                      color: appTheme,
                      size: 15,
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          ),
        ),
        onTap: () {
//          Navigator.push(context, MaterialPageRoute(
//            builder: (BuildContext context) =>SingleMyActiveLoanScreen(snapshot.data.loans[index])
//          ));
        },
      ),
    );
  }

  Widget applicationunderProcess() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 100),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "New application under process",
                style: TextStyle(fontSize: 16, color: appTheme, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return LoadingWidget();
  }

  Widget _buildErrorWidget(String error) {
    return ErrorMessageWidget(error: error);
  }

  Widget _buildNoDataWidget() {
    return NoDataWidget();
  }

  Widget marginshortFallInfo(total_col, marginshortfall) {
    var required_value = total_col + marginshortfall;
    return new Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 350,
          width: 375,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Loan Balance",
                      style: TextStyle(fontSize: 18, color: colorLightGray),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Rs.3,90,000",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: colorDarkGray),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Margin ShortFall',
                  style: TextStyle(color: appTheme, fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Required collateral value",
                      style: TextStyle(fontSize: 18, color: colorLightGray),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Rs.$required_value",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold, color: colorDarkGray),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Available collateral value",
                      style: TextStyle(fontSize: 18, color: colorLightGray),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Rs.$total_col",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: colorDarkGray),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Divider(
                  thickness: 1.5,
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Shortfall",
                      style: TextStyle(color: appTheme, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Rs.$marginshortfall",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: red),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please take necessary action to mitigate the Margin shortfall within the allowed time limit, to avoid forced sale of your securities",
                  style: TextStyle(fontSize: 12, color: red),
                ),
                SizedBox(
                  height: 27,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 45,
                      width: 120,
                      child: Material(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        elevation: 1.0,
                        color: appTheme,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget marginshortFallAction(index, AsyncSnapshot<MyLoansData> snapshot) {
    _texts.clear();
    List<double> shortFallList = [];
    for (int i = 0; i < snapshot.data!.loans!.length; i++) {
      _texts.add(snapshot.data!.loans![i].name!);
      shortFallList.add(snapshot.data!.loans![i].shortfallC!);
    }

    return new Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              height: 350,
              width: 375,
              decoration: new BoxDecoration(
                color: colorWhite,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Select Account",
                          style: TextStyle(
                              color: colorLightAppTheme, fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // RadioButtonGroup(
                        //     labels: _texts,
                        //     labelStyle: TextStyle(
                        //         color: colorLightappTheme,
                        //         fontSize: 18,
                        //         fontWeight: FontWeight.bold),
                        //     onSelected: (String selected) {
                        //       loan_selecte = selected;
                        //       printLog("select:$loan_selecte");
                        //     }),
                        Column(
                            children: shortFallList
                                .map((e) => Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        '₹ ${e}',
                                        style: TextStyle(
                                            color: colorDarkGray,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ))
                                .toList())
                      ],
                    ),
                    SizedBox(
                      height: 65,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          height: 40,
                          width: 80,
                          child: Material(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            elevation: 1.0,
                            color: appTheme,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                if (loan_selecte != null) {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (BuildContext context) =>
//                                             SingleMyActiveLoanScreen(
//                                                 snapshot.data.loans[index])));
                                } else {
                                  Utility.showToastMessage(Strings.valid_account_select);
                                }
                              },
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ))),
    );
  }
}
