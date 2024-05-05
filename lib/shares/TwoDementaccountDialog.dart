// import 'package:choice/Eligibility/CheckEligibilityScreen.dart';
// import 'package:choice/network/responsebean/ApprovedListResponseBean.dart';
// import 'package:choice/network/responsebean/CheckEligibilityResponseBean.dart';
// import 'package:choice/shares/SharesSecuritiesScreen.dart';
// import 'package:choice/util/Colors.dart';
// import 'package:choice/util/Preferences.dart';
// import 'package:choice/util/Utility.dart';
// import 'package:choice/util/strings.dart';
// import 'package:choice/widgets/LoadingDialogWidget.dart';
// import 'package:choice/widgets/WidgetCommon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:grouped_buttons/grouped_buttons.dart';
//
// class TwoDematAccountDialog extends StatefulWidget {
//   final lender;
//   bool isEmailVerified;
//   int canPledge;
//   List<ShareListData> shareSecurities = [];
//   List<EligibilityData> eligibleSecurities = [];
//   List<String?> stockAt;
//   String isComingFor;
//
//   @override
//   State<StatefulWidget> createState() => TwoDematAccountDialogState();
//
//   TwoDematAccountDialog(this.lender, this.isEmailVerified, this.canPledge , this.shareSecurities, this.eligibleSecurities, this.stockAt, this.isComingFor);
// }
//
// class TwoDematAccountDialogState extends State<TwoDematAccountDialog> {
//   var selectedDematAC;
//   Preferences preferences = new Preferences();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         bottomNavigationBar: AnimatedPadding(
//           duration: Duration(milliseconds: 150),
//           curve: Curves.easeOut,
//           padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Container(
//               height: 380,
//               decoration: new BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: new BorderRadius.only(
//                   topLeft: const Radius.circular(20.0),
//                   topRight: const Radius.circular(20.0),
//                 ),
//               ),
//               child: ScrollConfiguration(
//                 behavior: new ScrollBehavior()
//                   ..buildViewportChrome(context, Container(), AxisDirection.down),
//                 child: NestedScrollView(
//                   physics: NeverScrollableScrollPhysics(),
//                   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//                     return <Widget>[
//                       SliverList(
//                         delegate: SliverChildListDelegate([
//                           SizedBox(height: 0.1),
//                         ]),
//                       )
//                     ];
//                   },
//                   body: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       SizedBox(height: 20),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child:  Text(Strings.select_demat_ac,
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 color: red,
//                                 fontWeight: FontWeight.bold)),
//                       ),
//                       SizedBox(height: 20),
//                       Expanded(
//                         child: Stack(
//                           children: [
//                             SingleChildScrollView(
//                               child: Padding(
//                                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 45),
//                                 child: ListView.builder(
//                                     physics: NeverScrollableScrollPhysics(),
//                                     shrinkWrap: true,
//                                     itemCount: widget.stockAt.length,
//                                     itemBuilder: (context, index) {
//                                       return RadioListTile<String?>(
//                                         value: widget.stockAt[index],
//                                         groupValue: selectedDematAC,
//                                         activeColor: appTheme,
//                                         dense: true,
//                                         title: Text(
//                                             widget.stockAt[index]!,
//                                           style: TextStyle(color: colorLightappTheme, fontSize: 14, fontWeight: FontWeight.bold),
//                                         ),
//                                         onChanged: (value) {
//                                           setState(() {
//                                             printLog("Selected => $value");
//                                             setState(() {
//                                               selectedDematAC = value;
//                                             });
//                                           });
//                                         },
//                                       );
//                                     }
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 10),
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: <Widget>[
//                                     Container(
//                                       height: 40,
//                                       width: 100,
//                                       child: Material(
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(35)),
//                                         elevation: 1.0,
//                                         color: selectedDematAC != null ? appTheme : colorLightGray,
//                                         child: AbsorbPointer(
//                                           absorbing: selectedDematAC != null ? false : true,
//                                           child: MaterialButton(
//                                               minWidth: MediaQuery.of(context).size.width,
//                                               onPressed: () async {
//                                                 Utility.isNetworkConnection().then((isNetwork) {
//                                                   if (isNetwork) {
//                                                     getDematDetails();
//                                                   } else {
//                                                     Utility.showToastMessage(Strings.no_internet_message);
//                                                   }
//                                                 });
//                                               },
//                                               child: Text(Strings.next, style: TextStyle(color: colorWhite))
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//           ),
//         ),
//     );
//   }
//
//   getDematDetails(){
//     if(selectedDematAC != null){
//       LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//       if(widget.isComingFor == Strings.shares){
//         List<ShareListData> selectedDematSecurities = [];
//         widget.shareSecurities.forEach((element) {
//           if(element.stockAt == selectedDematAC){
//             selectedDematSecurities.add(element);
//           }
//         });
//         printLog("selectedDematSecurities ==> ${selectedDematSecurities.length}");
//         Navigator.pop(context);
//         if(selectedDematSecurities.length != 0){
//           Navigator.push(
//               context,
//               MaterialPageRoute(builder: (BuildContext context) =>
//                   SharesSecuritiesScreen(selectedDematSecurities, selectedDematAC)));
//         } else {
//           commonDialog(context, Strings.nonEligibleSecurities, 0);
//         }
//       } else if(widget.isComingFor == Strings.check_eligibility){
//         List<EligibilityData> approvedSecurityList = [];
//         widget.eligibleSecurities.forEach((element) {
//           if(element.stock_at == selectedDematAC){
//             approvedSecurityList.add(element);
//           }
//         });
//         printLog("approvedSecurityList ==> ${approvedSecurityList.length}");
//         Navigator.pop(context);
//         Navigator.pop(context);
//         Navigator.pop(context);
//         if(approvedSecurityList.length != 0){
//           Navigator.push(context, MaterialPageRoute(
//               builder: (BuildContext context) => CheckEligibilityScreen(
//                   widget.lender, widget.isEmailVerified,
//                   widget.canPledge, approvedSecurityList)));
//         } else {
//           commonDialog(context, Strings.nonEligibleSecurities, 0);
//         }
//       }
//     }
//   }
// }
