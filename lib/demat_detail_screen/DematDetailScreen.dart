// import 'dart:async';
//
// import 'package:choice/DematDetailScreen/DematDetailsBloc.dart';
// import 'package:choice/DematDetailScreen/DematdetailsDao.dart';
// import 'package:choice/accountsetting/AccountSettingScreen.dart';
// import 'package:choice/network/requestbean/DematDetailNewRequest.dart';
// import 'package:choice/network/requestbean/DematDetailRequest.dart';
// import 'package:choice/network/responsebean/DematAcResponse.dart';
// import 'package:choice/newdashboard/NewDashboardScreen.dart';
// import 'package:choice/AdditionalAccountDetail/AdditionalAccountDetailScreen.dart';
// import 'package:choice/nsdl/InformationScreen.dart';
// import 'package:choice/pledge_eligibility/shares/SecuritySelectionScreen.dart';
// import 'package:choice/shares/SharesSecuritiesScreen.dart';
// import 'package:choice/util/AssetsImagePath.dart';
// import 'package:choice/util/Colors.dart';
// import 'package:choice/util/Preferences.dart';
// import 'package:choice/util/Style.dart';
// import 'package:choice/util/Utility.dart';
// import 'package:choice/util/strings.dart';
// import 'package:choice/widgets/LoadingDialogWidget.dart';
// import 'package:choice/widgets/WidgetCommon.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
//
// import 'DematDetailsResponse.dart';
//
// class DematDetailScreen extends StatefulWidget {
//   int isSkip; //1-On boarding & -Dashboard, 2-Mutual Fund, 3-Account setting
//   String? loanApplicationStatus;
//   String? loanName;
//   String? instrumentType;
//   String? pledgorBoid;
//
//   DematDetailScreen(this.isSkip, this.loanApplicationStatus, this.loanName, this.instrumentType, this.pledgorBoid);
//
//   @override
//   _DematDetailScreenState createState() => _DematDetailScreenState();
// }
//
// class _DematDetailScreenState extends State<DematDetailScreen> {
//   String? selectedValue = 'NSDL';
//   bool dpIDValidator = true;
//   bool dpIDLenEight = true;
//   bool clientIDLenEight = true;
//   bool clientIDValidator = true;
//   TextEditingController dpIdController = TextEditingController();
//   TextEditingController clientIdController = TextEditingController();
//   List<DematAc> dematAcList = [];
//   DematDetailsBloc dematDetailsBloc = DematDetailsBloc();
//
//   bool dpidInOrNOT = false;
//   bool showTable = false;
//   bool isEditButtonOn = false;
//   int? timeForEdit;
//   int? now;
//   FocusNode clientIDFocus  = FocusNode();
//   bool isReadOnly = false;
//   bool isAPICalled = false;
//   String? dematAcNumber;
//
//   List<DematList1> dematList = [];
//   Preferences preferences = new Preferences();
//
//   @override
//   void initState() {
//     preferences.setOkClicked(false);
//     if(widget.isSkip == 2 || widget.isSkip == 3){
//       preferences.setIsVisitedCams(false);
//     }else{
//       preferences.setIsVisitedCams(true);
//     }
//     dematAcDetailsAPI();
//     printLog("Pledgor BOID => ${widget.pledgorBoid.toString()}");
//     printLog("loanName => ${widget.loanName.toString()}");
//     printLog("loanApplicationStatus => ${widget.loanApplicationStatus.toString()}");
//     printLog("instrumentType => ${widget.instrumentType.toString()}");
//
//     if(widget.loanApplicationStatus.toString().isNotEmpty){
//       if(widget.instrumentType == "Shares"){
//         if(widget.loanApplicationStatus.toString() == "Approved" || widget.loanApplicationStatus.toString() == "Pending"){
//           dematAcNumber = widget.pledgorBoid.toString();
//         }
//       }else{
//       }
//     }
//     super.initState();
//   }
//
//   void dematAcDetailsAPI() {
//     Utility.isNetworkConnection().then((isNetwork) async {
//       if (isNetwork) {
//         LoadingDialogWidget.showLoadingWithoutBack(context, Strings.please_wait);
//         dematDetailsBloc.dematAcDetails().then((value) {
//           Navigator.pop(context);
//           setState(() {
//             isAPICalled = true;
//           });
//           if (value.isSuccessFull!) {
//             if(value.dematAc != null){
//               setState(() {
//                 dematAcList = value.dematAc!;
//                 List<int> isChoiceList = List.generate(value.dematAc!.length, (index) => value.dematAc![index].isChoice!).toSet().toList();
//                 if(widget.isSkip == 1 && isChoiceList.contains(1)) {
//                   commonDialog(context, "The demat details in the table are retrieved from Choice Broking Limited", 0);
//                 }
//                 for (int i = 0; i < dematAcList.length; i++) {
//                   int now = DateTime.now().microsecond;
//                   dematList.add(new DematList1(
//                       clientId: dematAcList[i].clientId,
//                       dpid: dematAcList[i].dpid,
//                       depository: dematAcList[i].depository,
//                       timeStamps: now,
//                       isChoice: dematAcList[i].isChoice
//                   ));
//                 }
//               });
//             }
//           } else if (value.errorCode == 403) {
//             commonDialog(context, Strings.session_timeout, 4);
//           } else {
//             Utility.showToastMessage(value.errorMessage!);
//           }
//         });
//       } else {
//         Utility.showToastMessage(Strings.no_internet_message);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: WillPopScope(
//         onWillPop: () async {
//           if(widget.isSkip == 1){
//             return false;
//           }else if(widget.isSkip == 2){
//             return true;
//           }else{
//             if(dpIdController.text.isNotEmpty || clientIdController.text.isNotEmpty) {
//               showDialogBoxOnSubmit(2);
//             }
//             return true;
//           }
//         },
//         child: Scaffold(
//           backgroundColor: colorbg,
//           resizeToAvoidBottomInset: true,
//           appBar: AppBar(
//             backgroundColor: colorbg,
//             elevation: 0,
//             leading: widget.isSkip != 1 ? IconButton(
//               icon: ArrowToolbarBackwardNavigation(),
//               onPressed: () {
//                 if(widget.isSkip == 2){
//                   Navigator.pop(context);
//                 }else if(widget.isSkip == 3){
//                   if(dpIdController.text.isNotEmpty || clientIdController.text.isNotEmpty) {
//                     showDialogBoxOnSubmit(2);
//                   }else{
//                     Navigator.pop(context);}
//                 }
//               },
//             ) : Container(),
//             actions: [
//               widget.isSkip == 1  ? Material(
//                 child: MaterialButton(
//                   onPressed: () {
//                     if(widget.isSkip == 1){
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   AdditionalAccountDetailScreen(1, "", "", "")));
//                     }
//                   },
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(35)),
//                   elevation: 1.0,
//                   child: Text("Skip",
//                       style: TextStyle(color: appTheme, fontSize: 17)),
//                 ),
//               ) : Container(),
//             ],
//           ),
//           body: Theme(
//             data: theme.copyWith(primaryColor: appTheme),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
//                 child: Stack(
//                   children: [
//                     SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 8,
//                           ),
//                           subHeadingText(
//                             Strings.additional_account_detail_1,
//                           ),
//                           SizedBox(height: 30),
//                           Align(
//                               alignment: Alignment.topLeft,
//                               child: subHeadingText(Strings.dipository)),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Row(
//                               children: [
//                                 Radio(
//                                   activeColor: appTheme,
//                                   value: Strings.nsdl,
//                                   groupValue: selectedValue,
//                                   onChanged: (value) {
//                                     //printLog(value);
//                                     setState(() {
//                                       selectedValue = value as String?;
//                                     });
//                                     printLog(selectedValue);
//                                   },
//                                 ),
//                                 Text(Strings.nsdl),
//                                 SizedBox(
//                                   width: 45,
//                                 ),
//                                 Radio(
//                                   activeColor: appTheme,
//                                   value: Strings.cdsl,
//                                   groupValue: selectedValue,
//                                   onChanged: (value) {
//                                     //printLog(value);
//                                     setState(() {
//                                       selectedValue = value as String?;
//                                     });
//                                     printLog(selectedValue);
//                                   },
//                                 ),
//                                 Text(Strings.cdsl),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 150,
//                                   child: TextField(
//                                     controller: dpIdController,
//                                     maxLength: 8,
//                                     textInputAction: TextInputAction.next,
//                                     inputFormatters: [
//                                       FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
//                                     ],
//                                     //autofocus: true,
//                                     decoration: new InputDecoration(
//                                       counterText: '',
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Colors.grey),
//                                       ),
//                                       focusedBorder: new OutlineInputBorder(
//                                           borderSide:
//                                           new BorderSide(color: appTheme)),
//                                       hintStyle: TextStyle(color: colorGrey),
//                                       labelStyle: TextStyle(color: appTheme),
//                                       hintText: Strings.dpid,
//                                       labelText: Strings.dpid,
//                                       errorText: dpIDValidator ? dpIDLenEight ? null : "Invalid DP ID" : "*DP ID is mandatory",
//                                       errorBorder: new OutlineInputBorder(
//                                         borderSide: new BorderSide(color: Colors.red, width: 0.0),
//                                       ),
//                                       focusedErrorBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(Radius.circular(4)),
//                                         borderSide: BorderSide(
//                                           width: 1,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     ),
//                                     onChanged: (value) {
//                                       setState(() {
//
//                                         dpIdController.text.isNotEmpty
//                                             ? dpIDValidator = true
//                                             : null;
//
//                                         dpIdController.text.length == 8 ? dpIDLenEight = true : null;
//
//                                         if ((dpIdController.text.trim().startsWith('IN')) || (dpIdController.text.trim().startsWith('in'))) {
//                                           dpidInOrNOT = true;
//                                         } else {
//                                           dpidInOrNOT = false;
//                                         }
//                                         print("value ==> ${dpidInOrNOT.toString()}");
//
//
//                                         if (value.length == 8) {
//                                           FocusScope.of(context).requestFocus(clientIDFocus);
//                                         }
//
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topRight,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       commonDialog(context, "The first 8 digit of the Demat account number or BO ID, allocated by the Broker, is the Depository Participant (DP) ID. You can find the Demat details in the Account Detail section of the Trading App or in the Client Master Report.", 0);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(right: 10),
//                                       child: Image.asset(
//                                         AssetsImagePath.info,
//                                         height: 18.0,
//                                         width: 18.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Align(
//                             alignment: Alignment.topLeft,
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 150,
//                                   child: TextField(
//                                     controller: clientIdController,
//                                     maxLength: 8,
//                                     focusNode: clientIDFocus,
//                                     inputFormatters: [
//                                       FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
//                                     ],
//                                     //autofocus: true,
//                                     decoration: new InputDecoration(
//                                       counterText: '',
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(color: Colors.grey),
//                                       ),
//                                       focusedBorder: new OutlineInputBorder(
//                                           borderSide: new BorderSide(color: appTheme)),
//                                       hintStyle: TextStyle(color: colorGrey),
//                                       labelStyle: TextStyle(color: appTheme),
//                                       hintText: Strings.client_id,
//                                       labelText: Strings.client_id,
//                                       errorText: clientIDValidator ? clientIDLenEight ? null : "Invalid Client ID" : "*Client ID is mandatory",
//                                       errorBorder: new OutlineInputBorder(
//                                         borderSide: new BorderSide(color: Colors.red, width: 0.0),
//                                       ),
//                                       focusedErrorBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.all(Radius.circular(4)),
//                                         borderSide: BorderSide(
//                                           width: 1,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     ),
//                                     onChanged: (value){
//                                       setState(() {
//                                         clientIdController.text.isNotEmpty
//                                             ? clientIDValidator = true
//                                             : null;
//                                         clientIdController.text.length == 8 ? clientIDLenEight = true :null;
//                                         clientIdController.text.length == 8 ? FocusScope.of(context).unfocus() : null;
//
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topRight,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       commonDialog(context, "The last 8 digit of the Demat account number or BO ID, allocated by the Broker, is the Client ID. You can find the Demat details in the Account Detail section of the Trading App or in the Client Master Report.", 0);
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(right: 10),
//                                       child: Image.asset(
//                                         AssetsImagePath.info,
//                                         height: 18.0,
//                                         width: 18.0,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 60,
//                           ),
//                           AbsorbPointer(
//                             absorbing: dpIdController.text.isNotEmpty &&
//                                 clientIdController.text.isNotEmpty
//                                 ? false
//                                 : true,
//                             child: Container(
//                               height: 45,
//                               width: 120,
//                               child: Material(
//                                 color: dpIdController.text.isNotEmpty &&
//                                     clientIdController.text.isNotEmpty
//                                     ? appTheme
//                                     : colorGrey,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(35)),
//                                 elevation: 1.0,
//                                 child: MaterialButton(
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                                   minWidth: MediaQuery.of(context).size.width,
//                                   onPressed: () {
//                                     //showDialogBox();
//                                     printLog(selectedValue);
//                                     printLog(dpIdController.text);
//                                     printLog(clientIdController.text);
//                                     Utility.isNetworkConnection()
//                                         .then((isNetwork) async {
//                                       if (isNetwork) {
//                                         setState(() {
//                                           FocusScope.of(context).unfocus();
//                                           int now = DateTime.now().millisecondsSinceEpoch;
//                                           print("now time ==> $now");
//                                           if ((dpIdController.text.trim().startsWith('IN')) || (dpIdController.text.trim().startsWith('in'))) {
//                                             dpidInOrNOT = true;
//                                           } else {
//                                             dpidInOrNOT = false;
//                                           }
//                                           if(dpIdController.text.isNotEmpty && clientIdController.text.isNotEmpty){
//                                             if(dpIdController.text.length == 8 && clientIdController.text.length == 8){
//
//                                               if (selectedValue == Strings.nsdl) {
//                                                 if (dpidInOrNOT == false) {
//                                                   showDialogBoxWithEditOption(true, false);
//                                                 } else {
//                                                   if(isEditButtonOn){
//                                                     for(int i = 0; i<dematList.length; i++){
//                                                       if(timeForEdit == dematList[i].timeStamps){
//                                                         dematList[i].depository = selectedValue;
//                                                         dematList[i].clientId = clientIdController.text;
//                                                         dematList[i].dpid = dpIdController.text;
//                                                         timeForEdit = 0;
//                                                         isEditButtonOn = false;
//                                                       }
//                                                     }
//                                                     dematDetailAPI(0);
//                                                   }else{
//                                                     bool sameDematAC = false;
//                                                     String? existingDematAC;
//                                                     String userEnteredDematAC = dpIdController.text + clientIdController.text;
//                                                     for(int i =0; i<dematList.length; i++){
//                                                       existingDematAC = dematList[i].dpid! + dematList[i].clientId!;
//                                                       if(userEnteredDematAC.toLowerCase() == existingDematAC.toLowerCase()){
//                                                         sameDematAC = true;
//                                                       }
//                                                     }
//                                                     if(!sameDematAC){
//                                                       dematList.add(new DematList1(
//                                                           clientId: clientIdController.text,
//                                                           depository: selectedValue.toString(),
//                                                           dpid: dpIdController.text,
//                                                           isChoice: 0,
//                                                           timeStamps: now
//                                                       ));
//                                                       dematDetailAPI(0);
//                                                     }else{
//                                                       Utility.showToastMessage("Demat Details Already exist");
//                                                     }
//                                                   }
//
//                                                   clientIdController.clear();
//                                                   selectedValue = 'NSDL';
//                                                   dpIdController.clear();
//                                                   // showTable = true;
//                                                   // dematDetailAPI(0);
//                                                 }
//                                               } else {
//                                                 if (dpidInOrNOT == true) {
//                                                   showDialogBoxWithEditOption(true, false);
//                                                 } else {
//                                                   showDialogBox();
//                                                 }
//                                               }
//                                             }else {
//                                               if(dpIdController.text.length < 8 && clientIdController.text.length < 8){
//                                                 dpIDLenEight = false;
//                                                 clientIDLenEight = false;
//                                               }else if(clientIdController.text.length < 8){
//                                                 clientIDLenEight = false;
//                                               }else if(dpIdController.text.length < 8){
//                                                 dpIDLenEight = false;
//                                               }
//                                             }
//                                           }else{
//                                           }
//
//                                         });
//                                       } else {
//                                         Utility.showToastMessage(Strings.no_internet_message);
//                                       }
//                                     });
//                                   },
//                                   child: Text(
//                                     dematList.isNotEmpty ? isEditButtonOn ? "Save" : "ADD" : "ADD",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           dematList.isNotEmpty ? Align(alignment: Alignment.centerLeft,
//                               child: tableDematList()) : Container(),
//                           SizedBox(
//                             height: 40,
//                           ),
//                           widget.isSkip != 3 ? dematList.isNotEmpty ? AbsorbPointer(
//                             absorbing: dematList.isNotEmpty ? false : true,
//                             child: Container(
//                               height: 45,
//                               width: 120,
//                               child: Material(
//                                 color: dematList.isNotEmpty ? appTheme : colorGrey,
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                                 elevation: 1.0,
//                                 child: MaterialButton(
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                                   minWidth: MediaQuery.of(context).size.width,
//                                   onPressed: () {
//                                     //showDialogBox();
//                                     printLog(selectedValue);
//                                     printLog(dpIdController.text);
//                                     printLog(clientIdController.text);
//                                     Utility.isNetworkConnection().then((isNetwork) async {
//                                       if (isNetwork) {
//                                         if(dpIdController.text.isNotEmpty || clientIdController.text.isNotEmpty) {
//                                           showDialogBoxOnSubmit(1);
//                                         } else {
//                                           forwardArrowRedirection();
//                                         }
//                                       } else {
//                                         Utility.showToastMessage(Strings.no_internet_message);
//                                       }
//                                     });
//                                   },
//                                   child: ArrowForwardNavigation(),
//                                 ),
//                               ),
//                             ),
//                           ) : Container() : Container(),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           isAPICalled ? widget.isSkip != 1 ? dematList.length == 0 ? Text("Note: Demat account details is mandatory for pledge", style: regularTextStyle_14_gray_dark,): Container() : Container() : Container(),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   showDialogBox() {
//     return showDialog<void>(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0))),
//           content: const Text(Strings.demat_do_not_provide),
//           actions: <Widget>[
//             Center(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     width: 100,
//                     child: Material(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(35)),
//                       elevation: 1.0,
//                       color: appTheme,
//                       child: MaterialButton(
//                         minWidth: MediaQuery.of(context).size.width,
//                         onPressed: () {
//                           setState(() {
//                             selectedValue = 'NSDL';
//                             dpIdController.clear();
//                             clientIdController.clear();
//                             Navigator.pop(context);
//                           });
//                         },
//                         child: Text(
//                           "Reset",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10,),
//                   Container(
//                     width: 100,
//                     child: Material(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(35)),
//                       elevation: 1.0,
//                       color: appTheme,
//                       child: MaterialButton(
//                         minWidth: MediaQuery.of(context).size.width,
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           Strings.cancel,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   showDialogBoxOnSubmit(isFrom) {
//     return showDialog<void>(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: colorWhite,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           content: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(Strings.proceed_with_edited_on),
//                 SizedBox(height: 20),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 45,
//                         child: Material(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           elevation: 1.0,
//                           color: appTheme,
//                           child: MaterialButton(
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                             minWidth: MediaQuery.of(context).size.width,
//                             onPressed: () {
//                               setState(() {
//                                 Navigator.pop(context);
//                                 if(dpIdController.text.isNotEmpty && clientIdController.text.isNotEmpty) {
//                                   if(dpIdController.text.length == 8 && clientIdController.text.length == 8){
//                                     if (selectedValue == Strings.nsdl) {
//                                       if (dpidInOrNOT == false) {
//                                         showDialogBoxWithEditOption(true, isFrom);
//                                       } else if (dpidInOrNOT) {
//                                         int now = DateTime.now().millisecondsSinceEpoch;
//                                         print("now time ==> $now");
//                                         if (isEditButtonOn) {
//                                           for (int i = 0; i < dematList.length; i++) {
//                                             if (timeForEdit == dematList[i].timeStamps) {
//                                               dematList[i].depository = selectedValue;
//                                               dematList[i].clientId =
//                                                   clientIdController.text;
//                                               dematList[i].dpid = dpIdController.text;
//                                               timeForEdit = 0;
//                                             }
//                                             isEditButtonOn = false;
//                                             dematDetailAPI(isFrom);
//                                             break;
//                                           }
//                                         } else {
//                                           bool sameDematAC = false;
//                                           String? existingDematAC;
//                                           String userEnteredDematAC = dpIdController.text + clientIdController.text;
//                                           for (int i = 0; i < dematList.length; i++) {
//                                             existingDematAC = dematList[i].dpid! + dematList[i].clientId!;
//                                             if (userEnteredDematAC.toLowerCase() == existingDematAC.toLowerCase()) {
//                                               sameDematAC = true;
//                                             }
//                                           }
//                                           if (!sameDematAC) {
//                                             dematList.add(new DematList1(
//                                                 clientId: clientIdController.text,
//                                                 depository: selectedValue.toString(),
//                                                 dpid: dpIdController.text,
//                                                 isChoice: 0,
//                                                 timeStamps: now
//                                             ));
//                                             dematDetailAPI(isFrom);
//                                           } else {
//                                             Utility.showToastMessage(
//                                                 "Demat Details Already exist");
//                                           }
//                                         }
//                                         clientIdController.clear();
//                                         selectedValue = 'NSDL';
//                                         dpIdController.clear();
//
//                                       }
//                                     } else {
//                                       if (dpidInOrNOT == true) {
//                                         showDialogBoxWithEditOption(true, isFrom);
//                                       } else {
//                                         showDialogBox();
//                                       }
//                                     }
//                                   }else {
//                                     if(dpIdController.text.length < 8 && clientIdController.text.length < 8){
//                                       dpIDLenEight = false;
//                                       clientIDLenEight = false;
//                                     }else if(clientIdController.text.length < 8){
//                                       clientIDLenEight = false;
//                                     }else if(dpIdController.text.length < 8){
//                                       dpIDLenEight = false;
//                                     }
//                                   }
//                                 }else{
//                                   if(dpIdController.text.isEmpty){
//                                     dpIDValidator = false;
//                                   }else if(clientIdController.text.isEmpty){
//                                     clientIDValidator = false;
//                                   }else{
//                                     dpIDValidator = false;
//                                     clientIDValidator = false;
//                                   }
//                                 }
//                               });
//                             },
//                             child: Text(Strings.yes, style: TextStyle(color: Colors.white)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Expanded(
//                       child: Container(
//                         height: 45,
//                         child: Material(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           elevation: 1.0,
//                           color: appTheme,
//                           child: MaterialButton(
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                             minWidth: MediaQuery.of(context).size.width,
//                             onPressed: () {
//                               if(isFrom == 1) {
//                                 Navigator.pop(context);
//                                 forwardArrowRedirection();
//                               } else if(isFrom == 2) {
//                                 Navigator.pop(context);
//                                 Navigator.pop(context);
//                               }
//                             },
//                             child: Text(Strings.no, style: TextStyle(color: Colors.white)),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   showDialogBoxWithEditOption(callAPI, isFrom) {
//     return showDialog<void>(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: colorWhite,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           content: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Text(Strings.demat_detail_mismatch),
//                   ),
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 40,
//                       child: Material(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35),
//                             side: BorderSide(color: red)),
//                         elevation: 1.0,
//                         color: colorWhite,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () {
//                             Navigator.pop(context, Strings.ok);
//                           },
//                           child: Text(
//                             Strings.edit,
//                             style: buttonTextRed,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Container(
//                       width: 100,
//                       height: 40,
//                       child: Material(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35)),
//                         elevation: 1.0,
//                         color: appTheme,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () {
//                             setState(() {
//                               int now = DateTime.now().millisecondsSinceEpoch;
//                               print("now time ==> $now");
//                               if(isEditButtonOn){
//                                 for(int i = 0; i<dematList.length; i++){
//                                   if(timeForEdit == dematList[i].timeStamps){
//                                     dematList[i].depository = selectedValue;
//                                     dematList[i].clientId = clientIdController.text;
//                                     dematList[i].dpid = dpIdController.text;
//                                     timeForEdit = 0;
//                                     if(callAPI) {
//                                       dematDetailAPI(isFrom);
//                                     }else{
//
//                                     }
//                                     isEditButtonOn = false;
//                                     break;
//                                   }
//                                 }
//                               }else{
//                                 bool sameDematAC = false;
//                                 String? existingDematAC;
//                                 String userEnteredDematAC = dpIdController
//                                     .text + clientIdController.text;
//                                 for (int i = 0; i < dematList.length; i++) {
//                                   existingDematAC = dematList[i].dpid! +
//                                       dematList[i].clientId!;
//                                   if (userEnteredDematAC.toLowerCase() == existingDematAC.toLowerCase()) {
//                                     sameDematAC = true;
//                                   }
//                                 }
//                                 if (!sameDematAC) {
//                                   dematList.add(new DematList1(
//                                       clientId: clientIdController.text,
//                                       depository: selectedValue.toString(),
//                                       dpid: dpIdController.text,
//                                       isChoice: 0,
//                                       timeStamps: now
//                                   ));
//                                   if(callAPI) {
//                                     dematDetailAPI(isFrom);
//                                   }else{
//
//                                   }
//                                 } else {
//                                   Utility.showToastMessage(
//                                       "Demat Details Already exist");
//                                   // if(callAPI) {
//                                   // dematDetailAPI(isFrom);
//                                   // }else{
//                                   // }
//                                 }
//                               }
//
//                               clientIdController.clear();
//                               selectedValue = 'NSDL';
//                               dpIdController.clear();
//                               Navigator.pop(context);
//                             });
//                           },
//                           child: Text(
//                             Strings.ok,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   showDialogForVerification() {
//     return showDialog<void>(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10.0))),
//           content: const Text("Details Verified"),
//           actions: <Widget>[
//             Center(
//               child: Container(
//                 width: 100,
//                 child: Material(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(35)),
//                   elevation: 1.0,
//                   color: appTheme,
//                   child: MaterialButton(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                     minWidth: MediaQuery.of(context).size.width,
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => DashBoard()));
//                     },
//                     child: Text(
//                       Strings.ok,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   void dematDetailAPI(isFrom) {
//     Utility.isNetworkConnection().then((isNetwork) async {
//       if (isNetwork) {
//         Demat dematObj = new Demat();
//         List<DematList1> dematAC = [];
//         List<DematList1> dematACNew = [];
//         dematACNew.addAll(dematList);
//
//         print("length ====> ${dematAC.length}");
//         print("length ====> ${dematACNew.length}");
//         // dematObj.list = dematAC;
//         dematObj.list = dematACNew;
//         DematDetailNewRequest dematDetailNewRequest = DematDetailNewRequest();
//         dematDetailNewRequest.demat = dematObj;
//         LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//         dematDetailsBloc.dematDetails(dematDetailNewRequest).then((value) {
//           Navigator.pop(context);
//           if (value.isSuccessFull!) {
//             if(isFrom == 1){
//               forwardArrowRedirection();
//             }else if(isFrom == 2){
//               Navigator.pop(context);
//             }else{
//
//             }
//             // Utility.showToastMessage("Verified successfully");
//             // if(widget.isSkip == 2){
//             //
//             //   Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //           builder: (context) => SecuritySelectionScreen(dematAcList, true)));
//             // }else if(widget.isSkip == 1) {
//             //   Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //           builder: (context) => AdditionalAccountDetailScreen(1, "", "", "")));
//             // }else{
//             //   Navigator.pop(context);
//             // }
//           } else if (value.errorCode == 403) {
//             commonDialog(context, Strings.session_timeout, 4);
//           } else {
//             printLog(value.errorMessage);
//             Utility.showToastMessage(value.errorMessage!);
//           }
//         });
//       } else {
//         Utility.showToastMessage(Strings.no_internet_message);
//       }
//     });
//   }
//
//   forwardArrowRedirection(){
//     if(widget.isSkip == 2){
//       print("list --> ${dematAcList.length.toString()}");
//       for (int i = 0; i < dematList.length; i++) {
//         dematAcList.add(new DematAc(
//             clientId: dematList[i].clientId,
//             dpid: dematList[i].dpid,
//             depository: dematList[i].depository,
//             isChoice: dematList[i].isChoice,
//             stockAt: dematList[i].dpid! + dematList[i].clientId!
//         ));
//       }
//
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => SecuritySelectionScreen(dematAcList)));
//     }else if(widget.isSkip == 1) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => AdditionalAccountDetailScreen(1, "", "", "")));
//     }else{
//       Navigator.pop(context);
//     }
//   }
//
//   Widget tableDematList() {
//     return Visibility(
//       visible: dematList.isNotEmpty,
//       child: Container(
//         width: MediaQuery.of(context).size.width - 40,
//         child: Column(
//           children: [
//             Table(
//               border: TableBorder.all(
//                   color: Colors.grey,
//                   style: BorderStyle.solid,
//                   width: 0.5),
//               columnWidths: {
//                 0: FlexColumnWidth(2),
//                 1: FlexColumnWidth(2.6),
//                 2: FlexColumnWidth(2.7),
//                 3: FlexColumnWidth(2.7),
//                 4: FlexColumnWidth(3.8),
//               },
//               children: [
//                 TableRow(children: [
//                   Container(child:Center(child: Padding(
//                     padding: const EdgeInsets.only(top:8, bottom: 8),
//                     child: Text('Sr. No.', style: TextStyle(fontSize: 14.0)),
//                   ))),
//                   Container(child:Padding(
//                     padding: const EdgeInsets.only(top:8, bottom: 8, right: 6),
//                     child: Center(child: Text('Depository', style: TextStyle(fontSize: 14.0))),
//                   )),
//                   Container(child:Padding(
//                     padding: const EdgeInsets.only(top:8, bottom: 8, right: 8),
//                     child: Center(child: Text('DP ID', style: TextStyle(fontSize: 14.0))),
//                   )),
//                   Container(child:Padding(
//                     padding: const EdgeInsets.only(top:8, bottom: 8, right: 8),
//                     child: Center(child: Text('Client ID', style: TextStyle(fontSize: 14.0))),
//                   )),
//                   Container(child:Padding(
//                     padding: const EdgeInsets.only(top:8, bottom: 8, right: 8),
//                     child: Center(child: Text('Action', style: TextStyle(fontSize: 14.0))),
//                   )),
//                 ]),
//               ],
//             ),
//             ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: dematList.length,
//                 itemBuilder: (context, index) {
//                   return Table(
//                     border: TableBorder.all(
//                         color: Colors.grey,
//                         style: BorderStyle.solid,
//                         width: 0.5),
//                     columnWidths: {
//                       0: FlexColumnWidth(2),
//                       1: FlexColumnWidth(2.6),
//                       2: FlexColumnWidth(2.7),
//                       3: FlexColumnWidth(2.7),
//                       4: FlexColumnWidth(3.8),
//                     },
//                     children: [
//                       TableRow( children: [
//                         Container(child:Padding(
//                           padding: const EdgeInsets.only(top:8, bottom: 8),
//                           child: Center(child: Text("${(index+1).toString()}.", style: TextStyle(fontSize: 13.0))),
//                         )),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 4, top:8, bottom: 8, right: 8),
//                           child: Container(child:Center(child: Text(dematList[index].depository.toString(), style: TextStyle(fontSize: 13.0)))),
//                         ),
//                         Container(child:Padding(
//                           padding: const EdgeInsets.only(left: 4, top:8, bottom: 8, right: 8),
//                           child: Center(child: Text(dematList[index].dpid.toString(), style: TextStyle(fontSize: 13.0))),
//                         )),
//                         Container(child:Padding(
//                           padding: const EdgeInsets.only(left: 4, top:8, bottom: 8, right: 8),
//                           child: Center(child: Text(dematList[index].clientId.toString(), style: TextStyle(fontSize: 13.0))),
//                         )),
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Center(
//                               child: dematList[index].isChoice != 1 ? IconButton(
//                                 constraints: BoxConstraints(),
//                                 padding: EdgeInsets.only(right: 3),
//                                 icon: Center(
//                                   child: Icon(
//                                     Icons.edit,
//                                     size: 15,
//                                     color: appTheme,
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   Utility.isNetworkConnection()
//                                       .then((isNetwork) async {
//                                     if (isNetwork) {
//                                       setState(() {
//                                         if(dematAcNumber == dematList[index].dpid!.toString() + dematList[index].clientId!.toString() && (widget.loanApplicationStatus.toString() != null && widget.loanApplicationStatus.toString() == "Approved")){
//                                           commonDialog(context, "Your loan account ${widget.loanName.toString()} is active", 0);
//                                         }else if(dematAcNumber == dematList[index].dpid!.toString() + dematList[index].clientId!.toString() && (widget.loanApplicationStatus.toString() != null && widget.loanApplicationStatus.toString() == "Pending")){
//                                           commonDialog(context, "You have a pending loan application", 0);
//                                         }else{
//                                           selectedValue = dematList[index].depository.toString();
//                                           dpIdController.text = dematList[index].dpid.toString();
//                                           print("DPID ==> ${dematList[index].dpid.toString()}");
//                                           clientIdController.text = dematList[index].clientId.toString();
//                                           isEditButtonOn = true;
//                                           timeForEdit = dematList[index].timeStamps;
//                                         }
//                                       });
//
//                                     }else {
//                                       Utility.showToastMessage(
//                                           Strings.no_internet_message);
//                                     }
//                                   });
//                                 },
//                               ) : Container(),
//                             ),
//                             Center(
//                               child: dematList[index].isChoice != 1 ? IconButton(
//                                 constraints: BoxConstraints(),
//                                 padding: EdgeInsets.only(top: 2),
//                                 icon: Center(
//                                   child: Icon(
//                                     Icons.delete,
//                                     size: 15,
//                                     color: appTheme,
//
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   Utility.isNetworkConnection()
//                                       .then((isNetwork) async {
//                                     if (isNetwork) {
//                                       if(dematAcNumber == dematList[index].dpid!.toString() + dematList[index].clientId!.toString() && (widget.loanApplicationStatus.toString() != null && widget.loanApplicationStatus.toString() == "Approved")){
//                                         commonDialog(context, "Your loan account ${widget.loanName.toString()} is active", 0);
//                                       }else if(dematAcNumber == dematList[index].dpid!.toString() + dematList[index].clientId!.toString() && (widget.loanApplicationStatus.toString() != null && widget.loanApplicationStatus.toString() == "Pending")){
//                                         commonDialog(context, "You have a pending loan application", 0);
//                                       }else{
//                                         if(timeForEdit == dematList[index].timeStamps){
//                                           Utility.showToastMessage("Cannot be deleted");
//                                         }else {
//                                           deleteYesNoDialog(context, "Are you sure you want to delete?", index);
//                                         }
//                                       }
//                                     }else {
//                                       Utility.showToastMessage(
//                                           Strings.no_internet_message);
//                                     }
//                                   });
//                                 },
//                               ) : Container(),
//                             )
//                           ],
//                         ),
//                       ]),
//                     ],
//                   );
//                 }
//             ),
//           ],
//         ),
//
//         // child: Table(
//         //   border: TableBorder.all(
//         //       color: Colors.grey,
//         //       style: BorderStyle.solid,
//         //       width: 1),
//         //   children: [
//         //     TableRow(children: [
//         //       Container(child:Center(child: Padding(
//         //         padding: const EdgeInsets.all(8.0),
//         //         child: Text('Sr. No.', style: TextStyle(fontSize: 15.0)),
//         //       ))),
//         //       Container(child:Padding(
//         //         padding: const EdgeInsets.all(8.0),
//         //         child: Center(child: Text('Depository', style: TextStyle(fontSize: 15.0))),
//         //       )),
//         //       Container(child:Padding(
//         //         padding: const EdgeInsets.all(8.0),
//         //         child: Center(child: Text('DP ID', style: TextStyle(fontSize: 15.0))),
//         //       )),
//         //       Container(child:Padding(
//         //         padding: const EdgeInsets.all(8.0),
//         //         child: Center(child: Text('Client ID', style: TextStyle(fontSize: 15.0))),
//         //       )),
//         //     ]),
//         //     TableRow( children: [
//         //       Container(child:Padding(
//         //         padding: const EdgeInsets.all(8.0),
//         //         child: Center(child: Text('1')),
//         //       )),
//         //       Padding(
//         //         padding: const EdgeInsets.all(8.0),
//         //         child: Container(child:Center(child: Text(dematList[0]))),
//         //       ),
//         //       Container(child:Padding(
//         //         padding: const EdgeInsets.all(8.0),
//         //         child: Center(child: Text(dematList[1])),
//         //       )),
//         //       Container(child:Padding(
//         //         padding: const EdgeInsets.all(8.0),
//         //         child: Center(child: Text(dematList[2])),
//         //       )),
//         //     ]),
//         //   ],
//         // ),
//       ),
//     );
//   }
//
//
//   Future<bool> deleteYesNoDialog(BuildContext context, msg, index) async {
//     return await showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           content: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: new Text(msg,
//                         style: regularTextStyle_16_dark),
//                   ), //
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 40,
//                       width: 100,
//                       child: Material(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35),
//                             side: BorderSide(color: red)),
//                         elevation: 1.0,
//                         color: colorWhite,
//                         child: MaterialButton(
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             Utility.isNetworkConnection().then((isNetwork) {
//                               if (isNetwork) {
//                                 Navigator.pop(context);
//                               } else{
//                                 Utility.showToastMessage(Strings.no_internet_message);
//                               }
//                             });
//                           },
//                           child: Text(
//                             Strings.no,
//                             style: buttonTextRed,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Container(
//                       height: 40,
//                       width: 100,
//                       child: Material(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35)),
//                         elevation: 1.0,
//                         color: appTheme,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             Utility.isNetworkConnection().then((isNetwork) {
//                               if (isNetwork) {
//                                 setState(() {
//                                   dematList.removeAt(index);
//                                   Navigator.pop(context);
//                                   dematDetailAPI(false);
//                                 });
//                               }else{
//                                 Utility.showToastMessage(Strings.no_internet_message);
//                               }
//                             });
//                           },
//                           child: Text(
//                             Strings.yes,
//                             style: buttonTextWhite,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     ) ?? false;
//   }
//
// // Future<bool> allowPrepopulateDematTable() async {
// //   return await showDialog(
// //     barrierDismissible: false,
// //     context: context,
// //     builder: (BuildContext context) {
// //       return AlertDialog(
// //         backgroundColor: Colors.white,
// //         shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.all(Radius.circular(15.0))),
// //         content: Container(
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.center,
// //             mainAxisSize: MainAxisSize.min,
// //             children: <Widget>[
// //               Center(
// //                 child: new Text(Strings.demat_data_prepopulate,
// //                     style: regularTextStyle_16_dark), //
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               Row(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Expanded(
// //                     child: Container(
// //                       height: 40,
// //                       width: 100,
// //                       child: Material(
// //                         shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(35),
// //                             side: BorderSide(color: red)),
// //                         elevation: 1.0,
// //                         color: colorWhite,
// //                         child: MaterialButton(
// //                           minWidth: MediaQuery.of(context).size.width,
// //                           onPressed: () async {
// //                             Utility.isNetworkConnection().then((isNetwork) {
// //                               if (isNetwork) {
// //                                 Navigator.pop(context);
// //                               } else {
// //                                 Utility.showToastMessage(Strings.no_internet_message);
// //                               }
// //                             });
// //                           },
// //                           child: Text(Strings.no, style: buttonTextRed),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   SizedBox(
// //                     width: 5,
// //                   ),
// //                   Expanded(
// //                     child: Container(
// //                       height: 40,
// //                       width: 100,
// //                       child: Material(
// //                         shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(35)),
// //                         elevation: 1.0,
// //                         color: appTheme,
// //                         child: MaterialButton(
// //                           minWidth: MediaQuery.of(context).size.width,
// //                           onPressed: () async {
// //                             Utility.isNetworkConnection().then((isNetwork) {
// //                               if (isNetwork) {
// //                                 setState(() {
// //                                   for (int i = 0; i < dematAcList.length; i++) {
// //                                     int now = DateTime.now().microsecond;
// //                                     dematList.add(new DematList1(
// //                                         clientId: dematAcList[i].clientId,
// //                                         dpid: dematAcList[i].dpid,
// //                                         depository: dematAcList[i].depository,
// //                                         timeStamps: now,
// //                                         isChoice: dematAcList[i].isChoice
// //                                     ));
// //                                   }
// //                                   Navigator.pop(context);
// //                                 });
// //                               } else {
// //                                 Utility.showToastMessage(Strings.no_internet_message);
// //                               }
// //                             });
// //                           },
// //                           child: Text(Strings.yes, style: buttonTextWhite),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       );
// //     },
// //   ) ?? false;
// // }
//
// }
