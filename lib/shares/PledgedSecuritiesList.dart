import 'package:choice/common_widgets/constants.dart';
import 'package:choice/network/responsebean/NewDashboardResponse.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/NoDataWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';

class PledgedSecuritiesListScreen extends StatefulWidget {
  List<CommonItems> pendingEsignItem;
  String loanApplicationName;
  double totalCollateralValue, drawingPower;
  final loanType;


  PledgedSecuritiesListScreen(this.pendingEsignItem,this.loanApplicationName,this.totalCollateralValue,this.drawingPower, this.loanType);

  @override
  PledgedSecuritiesListScreenState createState() => PledgedSecuritiesListScreenState();
}

class PledgedSecuritiesListScreenState extends State<PledgedSecuritiesListScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

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
            widget.loanApplicationName,
            style: mediumTextStyle_18_gray_dark,
          ),
        ),
        body: widget.pendingEsignItem.isNotEmpty ? allMyCartData() : NoDataWidget()
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
                pledgeCart(widget.pendingEsignItem.length.toString(), numberToString(widget.totalCollateralValue.toStringAsFixed(2)), widget.loanType),
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
                Text(widget.loanType == Strings.shares ? Strings.shares_selected : Strings.schemes_selected,
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
    String eligibleAmount;
    eligibleAmount = numberToString(widget.drawingPower.toStringAsFixed(2));
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
                  '₹' + eligibleAmount,
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      Navigator.pop(context);
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
            Text(widget.loanType == Strings.shares ? Strings.values_selected_securities : Strings.values_selected_schemes, style: subHeading),
            // mediumHeadingText(Strings.values_selected_securities),
            SizedBox(
              height: 14,
            ),
            subHeadingText(totalScrips.toString()),
            SizedBox(
              height: 2,
            ),
            Text(widget.loanType == Strings.shares ? Strings.scrips : Strings.schemes, style: subHeading),
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
        itemCount: widget.pendingEsignItem.length,
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
                          child: scripsNameText(widget.loanType == Strings.shares
                              ? widget.pendingEsignItem[index].securityName
                              : "${widget.pendingEsignItem[index].securityName} [${widget.pendingEsignItem[index].folio}]")),
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
                              scripsValueText(widget.pendingEsignItem[index].pledgedQuantity.toString()),
                              SizedBox(
                                height: 5,
                              ),
                              Text(widget.loanType == Strings.shares ? Strings.pledge_qty : Strings.pledge_units, style: subHeading),
                              // mediumHeadingText(Strings.pledge_qty),
                            ],
                          ),
                          Column(
                            children: [
                              scripsValueText('₹' + widget.pendingEsignItem[index].amount!.toStringAsFixed(2)),
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
                                  color: widget.pendingEsignItem[index].lenderApprovalStatus == "Approved"
                                      ? colorLightGreen
                                      : widget.pendingEsignItem[index].lenderApprovalStatus == "Rejected"
                                      ? colorLightRed
                                      : colorLightAppTheme,
                                ),
                                child: Text(widget.pendingEsignItem[index].lenderApprovalStatus!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: semiBold,
                                    color: widget.pendingEsignItem[index].lenderApprovalStatus == "Approved"
                                        ? colorGreen
                                        : widget.pendingEsignItem[index].lenderApprovalStatus == "Rejected"
                                        ? red
                                        : colorWhite,
                                  ),
                                ),
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
      ),
    );
  }
}

