// import 'package:lms/contact_us/thank_you.dart';
// import 'package:lms/dummy/constants.dart';
// import 'package:lms/login/LoginDao.dart';
// import 'package:lms/network/requestbean/ContactUsRequestBean.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Preferences.dart';
// import 'package:lms/util/Style.dart';
// import 'package:lms/util/Utility.dart';
// import 'package:lms/util/strings.dart';
// import 'package:lms/widgets/LoadingDialogWidget.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'ContactUSBloc.dart';
//
// class ContactScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return ContactScreenState();
//   }
// }
//
// class ContactScreenState extends State<ContactScreen> {
//   final contactUSBloc = ContactUSBloc();
//   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//   TextEditingController messageController;
//   Preferences preferences = new Preferences();
//   var userEmail, userName;
//   String reason;
//   List<DropdownMenuItem<String>> _dropDownReasonItems;
//   List reasonList = [
//     'Account opening',
//     'Apply for a new loan',
//     'Logins and Permissions',
//     'LMS',
//     'Fees and Charges',
//     'Loan Management',
//     'Manage Profile',
//     'Transaction and Balance view',
//     'Pledging securities',
//     'Digital safety and security',
//     'Loan Repayment'
//   ];
//
//   @override
//   void initState() {
//     autoFetchData();
//     _dropDownReasonItems = getDropDownReasons();
//     messageController = TextEditingController();
//     super.initState();
//   }
//
//   List<DropdownMenuItem<String>> getDropDownReasons() {
//     List<DropdownMenuItem<String>> items = new List();
//     for (String status in reasonList) {
//       items.add(
//         DropdownMenuItem(
//           value: status,
//           child: Text(status),
//         ),
//       );
//     }
//     return items;
//   }
//
//   void changedDropDownReasonItem(String selectedReason) {
//     setState(() {
//         reason = selectedReason;
//         printLog(reason);
//       },
//     );
//   }
//
//   Future<void> autoFetchData() async {
//     userEmail = await preferences.getEmail();
//     userName = await preferences.getFullName();
//     printLog("Mail::$userEmail");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldkey,
//       backgroundColor: colorbg,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 IconButton(
//                   icon: ArrowToolbarBackwardNavigation(),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     'Contact us',
//                     style: boldTextStyle_30,
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     width: 30,
//                     height: 30,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey, width: 2.0),
//                       // set border width
//                       borderRadius: BorderRadius.all(Radius.circular(55.0)),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: Text(
//                         "?",
//                         style: extraBoldTextStyle_18_gray,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             reasonDropDown(),
//             SizedBox(
//               height: 20,
//             ),
//             messageField(),
//             SizedBox(
//               height: 30,
//             ),
//             Container(
//               height: 50,
//               width: 140,
//               child: Material(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(35),
//                 ),
//                 elevation: 4.0,
//                 color: appTheme,
//                 child: MaterialButton(
//                   minWidth: MediaQuery.of(context).size.width,
//                   onPressed: () {
//                     Utility.isNetworkConnection().then((isNetwork) {
//                       if (isNetwork) {
//                         contactUsAPI();
//                       } else {
//                         showSnackBar(_scaffoldkey);
//                       }
//                     });
//                   },
//                   child: Text(
//                     'Submit',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             advertiseCard(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget reasonDropDown() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 30, right: 30),
//       child: DropdownButton<String>(
//         isDense: true,
//         isExpanded: true,
//         value: reason,
//         hint: Text('Reason'),
//         icon: ArrowDown(),
//         onChanged: changedDropDownReasonItem,
//         items: _dropDownReasonItems,
//       ),
//     );
//   }
//
//   Widget messageField() {
//     final theme = Theme.of(context);
//     return StreamBuilder(
//       builder: (context, AsyncSnapshot<String> snapshot) {
//         return Padding(
//           padding: const EdgeInsets.only(left: 30, right: 30),
//           child: Theme(
//             data: theme.copyWith(primaryColor: appTheme),
//             child: TextFormField(
//               textCapitalization: TextCapitalization.sentences,
//               obscureText: false,
//               controller: messageController,
//               style: TextStyle(color: Colors.grey.shade800, fontSize: 15),
//               decoration: new InputDecoration(
//                 counterText: "",
//                 hintText: "Message",
//                 hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
//                 focusColor: Colors.grey,
//                 enabledBorder: new UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: appTheme,
//                     width: 0.5,
//                   ),
//                 ),
//               ),
//               keyboardType: TextInputType.text,
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget advertiseCard(){
//     return Container(
//       width: 300,
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//       decoration: new BoxDecoration(
//         color: Colors.white,
//         borderRadius: new BorderRadius.all(Radius.circular(15.0)),
//       ),
//       child: Column(
//         children: <Widget>[
//           Container(
//             height: 80,
//             width: 80,
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             decoration: new BoxDecoration(
//               color: colorbg,
//               borderRadius: new BorderRadius.all(Radius.circular(50.0)),
//             ),
//             child: Logo(),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text(
//             'LMS',
//             style: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.bold,
//                 color: appTheme),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             '+91-9090-909090',
//             style: TextStyle(color: Colors.grey.shade800),
//           ),
//           Text('customercare@spark.loans',
//               style: TextStyle(color: Colors.grey.shade800)),
//         ],
//       ),
//     );
//   }
//
//   void contactUsAPI() {
//     if (reason == null) {
//       Utility.showToastMessage("Please select reason");
//     } else if (messageController.value.text.trim().isEmpty) {
//       Utility.showToastMessage("Please enter reason message");
//     } else {
//       ContactUsRequestBean contactUsRequestBean = ContactUsRequestBean(
//           subject: reason,
//           message: messageController.value.text.trim(),
//           sender: "vikaspawar2112@gmail.com");
//       LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//       contactUSBloc.contactUs(contactUsRequestBean).then((value) {
//         Navigator.pop(context);
//         if (value.isSuccessFull) {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (BuildContext context) => ThankYouScreen()));
//         } else {
//           Utility.showToastMessage(value.errorMessage);
//         }
//       });
//     }
//   }
// }
