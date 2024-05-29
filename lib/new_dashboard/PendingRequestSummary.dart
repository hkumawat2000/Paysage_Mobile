import 'package:lms/common_widgets/constants.dart';
import 'package:lms/network/responsebean/LoanSummaryResponseBean.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/NoDataWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class PendingRequestSummary extends StatefulWidget {

  var isComingFor;
  var loanApplicationName;
  var requestedDate;
  var collateralValue;
  var scripts;
  List<SellItems> sellItems;
  List<UnpledgeItems> unpledgedItems;
  String? loanType;


  PendingRequestSummary(this.isComingFor, this.loanApplicationName, this.requestedDate, this.collateralValue, this.scripts, this.sellItems, this.unpledgedItems, this.loanType);

  @override
  _PendingRequestSummaryState createState() => _PendingRequestSummaryState();
}

class _PendingRequestSummaryState extends State<PendingRequestSummary> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {

    if(widget.sellItems != null){
      widget.sellItems.sort((a,b) => a.securityName!.toLowerCase().compareTo(b.securityName!.toLowerCase()));
    }

    if(widget.unpledgedItems != null){
      widget.unpledgedItems.sort((a,b) => a.securityName!.toLowerCase().compareTo(b.securityName!.toLowerCase()));
    }

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
            icon: Icon(
              Icons.arrow_back_ios,
              color: appTheme,
              size: 15,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: colorBg,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            widget.loanApplicationName,
            style: mediumTextStyle_16_dark,
          ),
        ),
        body: allMyCartData()
    );
  }

  Widget allMyCartData() {
    var displayDate = widget.requestedDate;
    var displayDateFormatter = new DateFormat('MMM dd, yyyy');
    var date = DateTime.parse(displayDate);
    String formattedDate = displayDateFormatter.format(date);

    return NestedScrollView(
      physics: ScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Requested Date : ',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: colorLightGray),
                      ),
                      Text(
                        formattedDate,
                        style: subHeadingValue,
                      )
                    ],
                  ),
                ),
                pledgeCart(widget.scripts, numberToString(widget.collateralValue.toStringAsFixed(2))),
              ],
            ),
          )
        ];
      },
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(widget.loanType == Strings.shares ? Strings.shares_selected : Strings.schemes_selected,
                    style: kDefaultTextStyle.copyWith(
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: widget.isComingFor == Strings.sell_collateral
                  ? sellPledgedSecurities(widget.sellItems)
                  : unPledgedSecurities(widget.unpledgedItems),
            ),
          ),
        ],
      ),
    );
  }

  Widget pledgeCart(totalScrips, pledgedTotalCollateralValue) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: colorLightBlue,
          border: Border.all(color: colorLightBlue, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10, right: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '₹' + pledgedTotalCollateralValue.toString(),
                style: subHeadingValue,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.loanType == Strings.shares
                    ? widget.isComingFor == Strings.sell_collateral
                    ? 'SELL COLLATERAL VALUE'
                    : 'UNPLEDGE COLLATERAL VALUE'
                    : widget.isComingFor == Strings.sell_collateral
                    ? 'INVOKE VALUE'
                    : 'REVOKE VALUE',
                style: subHeading,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                totalScrips.toString(),
                style: subHeadingValue,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.loanType == Strings.shares ? Strings.scrips : Strings.schemes,
                style: subHeading,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget sellPledgedSecurities(List<SellItems> items) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: scripsNameText(widget.loanType == Strings.shares
                              ? items[index].securityName : "${items[index].securityName} [${items[index].folio}]"),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text("${items[index].securityCategory!} (LTV: ${items[index].eligiblePercentage!.toStringAsFixed(2)}%)",
                        style: boldTextStyle_12_gray),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: scripsValueText(widget.loanType == Strings.shares
                                  ? items[index].quantity.toString().split(".")[0]
                                  : items[index].quantity.toString()),
                            ),
                            Expanded(
                              child: scripsValueText(widget.loanType == Strings.shares
                                  ? "₹${items[index].price!.toStringAsFixed(2)}"
                                  : "₹${items[index].price!.toString()}"),
                            ),
                            Expanded(
                              child: scripsValueText(widget.loanType == Strings.shares
                                  ? "₹${items[index].amount!.toStringAsFixed(2)}"
                                  : "₹${items[index].amount!.toString()}"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(child: mediumHeadingText(widget.loanType == Strings.shares ? Strings.pledge_qty : Strings.pledge_units)),
                            Expanded(child: mediumHeadingText(widget.loanType == Strings.shares ? Strings.price : Strings.nav)),
                            Expanded(child: mediumHeadingText(Strings.value)),
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

  Widget unPledgedSecurities(List<UnpledgeItems> items) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: scripsNameText(widget.loanType == Strings.shares
                              ? items[index].securityName : "${items[index].securityName} [${items[index].folio}]"),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text("${items[index].securityCategory!} (LTV: ${items[index].eligiblePercentage!.toStringAsFixed(2)}%)",
                        style: boldTextStyle_12_gray),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: scripsValueText(widget.loanType == Strings.shares
                                  ? items[index].quantity.toString().split(".")[0]
                                  : items[index].quantity.toString()),
                            ),
                            Expanded(
                              child: scripsValueText(widget.loanType == Strings.shares
                                  ? "₹${items[index].price!.toStringAsFixed(2)}"
                                  : "₹${items[index].price!.toString()}"),
                            ),
                            Expanded(
                              child: scripsValueText(widget.loanType == Strings.shares
                                  ? "₹${items[index].amount!.toStringAsFixed(2)}"
                                  : "₹${items[index].amount!.toString()}"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(child: mediumHeadingText(widget.loanType == Strings.shares ? Strings.pledge_qty : Strings.pledge_units)),
                            Expanded(child: mediumHeadingText(widget.loanType == Strings.shares ? Strings.price : Strings.nav)),
                            Expanded(child: mediumHeadingText(Strings.value)),
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
