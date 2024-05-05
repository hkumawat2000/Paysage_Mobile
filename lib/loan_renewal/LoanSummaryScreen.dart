
import 'package:choice/common_widgets/constants.dart';
import 'package:choice/my_loan/MyLoansBloc.dart';
import 'package:choice/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:choice/network/responsebean/NewDashboardResponse.dart';
import 'package:choice/new_dashboard/NewDashboardScreen.dart';
import 'package:choice/terms_conditions/TermsConditions.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/NoDataWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoanSummaryScreen extends StatefulWidget {
  bool? UpdateKyc;
  String? loanRenewalName;
  String? loanName;


  LoanSummaryScreen(this.UpdateKyc, this.loanRenewalName, this.loanName);

  @override
  LoanSummaryScreenState createState() => LoanSummaryScreenState();
}

class LoanSummaryScreenState extends State<LoanSummaryScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final myLoansBloc = MyLoansBloc();
  Loan? loan;
  String? stockAt;

  @override
  void initState() {
    loanDetailsApi(widget.loanName);
    super.initState();

  }

  loanDetailsApi(loanName){
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
        myLoansBloc.getLoanDetails(loanName).then((value){
          setState(() {
            if(value.isSuccessFull!){
              Navigator.pop(context);
              loan = value.data!.loan!;
              stockAt = value.data!.pledgorBoid!;
              // Navigator.push(context, MaterialPageRoute(builder: (context) => LoanSummaryScreen(loan ,false, value.data!.pledgorBoid!, widget.loanRenewalName)));
            }else if (value.errorCode == 403){
              commonDialog(context, Strings.session_timeout, 4);
            } else {
              Navigator.pop(context);
              commonDialog(context, value.errorMessage!, 0);
            }
          });
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: colorBg,
        appBar: AppBar(
          leading: IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: colorBg,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            loan != null && loan!.toString().isNotEmpty? loan!.name! : "",
            style: mediumTextStyle_18_gray_dark,
          ),
        ),
        body: loan != null && loan.toString().isNotEmpty ? loan!.items != null ? allMyCartData(): NoDataWidget() : NoDataWidget()
    );
  }

  Widget allMyCartData() {
    return NestedScrollView(
      physics: ScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: headingText(Strings.my_vault),
                ),
                pledgeCart(loan!.items!.length.toString(), numberToString(loan!.totalCollateralValue!.toStringAsFixed(2)), loan!.instrumentType!),
              ],
            ),
          )
        ];
      },
      body: Column(
        children: <Widget>[
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(loan!.instrumentType! == Strings.shares ? Strings.shares_selected : Strings.schemes_selected,
                    style: kDefaultTextStyle.copyWith(
                        fontWeight: FontWeight.bold, color: appTheme)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _myCart(),
            ),
          ),
          bottomSection(),
        ],
      ),
    );
  }

  Widget bottomSection() {
    var eligible_amount;
    eligible_amount = numberToString(loan!.drawingPower!.toStringAsFixed(2));
    return Container(
      height: 130,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 3.0),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0)),
        boxShadow: [
          BoxShadow(
              blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
        ], // make rounded corner of border
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: subHeadingText(Strings.eligible_loan_small)
                ),
                Text(
                  '₹' + eligible_amount,
                  style: textStyleGreenStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 45,
                width: 100,
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  elevation: 1.0,
                  color: appTheme,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TermsConditionsScreen(loan!.drawingPower!.toString(), "", stockAt!, Strings.loanRenewal, widget.loanRenewalName, loan!.instrumentType!)));
                    },
                    child: Text(Strings.ok,style: buttonTextWhite,),
                  ),
                ),
              )

            ],
          ),
        ],
      ),
    );
  }

  Widget pledgeCart(totalScrips,pledgedTotalCollateralValue,loanType) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: colorLightBlue,
          border: Border.all(color: colorLightBlue, width: 3.0),
          // set border width
          borderRadius: BorderRadius.all(
              Radius.circular(15.0)), // set rounded corner radius
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            largeHeadingText('₹' + pledgedTotalCollateralValue),
            SizedBox(
              height: 2,
            ),
            Text(loan!.instrumentType! == Strings.shares ? Strings.values_selected_securities : Strings.values_selected_schemes, style: subHeading),
            // mediumHeadingText(Strings.values_selected_securities),
            SizedBox(
              height: 14,
            ),
            subHeadingText(totalScrips.toString()),
            SizedBox(
              height: 2,
            ),
            Text(loan!.instrumentType! == Strings.shares ? Strings.scrips : Strings.schemes, style: subHeading),
            // mediumHeadingText(Strings.scrips),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _myCart() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: loan!.items!.length,
          itemBuilder: (context, index) {

            return Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: scripsNameText(loan!.instrumentType! == Strings.shares
                                ? loan!.items![index].securityName
                                : "${loan!.items![index].securityName} [${loan!.items![index].folio}]")),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Table(
                      children: [
                        TableRow(
                          children: [
                            Column(
                              children: [
                                scripsValueText(loan!.items![index].pledgedQuantity.toString()),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(loan!.instrumentType! == Strings.shares ? Strings.pledge_qty : Strings.pledge_units, style: subHeading),
                                // mediumHeadingText(Strings.pledge_qty),
                              ],
                            ),
                            Column(
                              children: [
                                scripsValueText('₹' + loan!.items![index].amount!.toStringAsFixed(2)),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(Strings.value_selected, style: subHeading),
                                // mediumHeadingText(Strings.value_selected),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: colorLightAppTheme
                                      // color: widget.loanItems[index].lenderApprovalStatus == "Approved"
                                      //     ? colorLightGreen
                                      //     : widget.loanItems[index].lenderApprovalStatus == "Rejected"
                                      //     ? colorLightRed
                                      //     : colorLightappTheme,
                                    ),
                                  child: Text(loan!.instrumentType! == "Shares" ? "Pledged" : "Lien",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: semiBold,
                                        color: colorWhite
                                      ))
                                  // child: Text(widget.loanItems[index].lenderApprovalStatus!,
                                    //     style: TextStyle(
                                    //       fontSize: 12,
                                    //       fontWeight: semiBold,
                                    //       color: widget.loanItems[index].lenderApprovalStatus == "Approved"
                                    //           ? colorGreen
                                    //           : widget.loanItems[index].lenderApprovalStatus == "Rejected"
                                    //           ? red
                                    //           : colorWhite,
                                    //     ))
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

}

