//
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Preferences.dart';
// import 'package:lms/util/Utility.dart';
// import 'package:lms/util/strings.dart';
// import 'package:lms/widgets/LoadingDialogWidget.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:flushbar/flushbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'CompleteKYCBloc.dart';
//
// class EditChoiceInformationScreen extends StatefulWidget{
//   String panNo, address, name, bankName, accountNo, ifscCode,userId;
//   @override
//   EditChoiceInformationScreenState createState() => EditChoiceInformationScreenState();
//   EditChoiceInformationScreen(this.panNo, this.address, this.name, this.bankName, this.accountNo, this.ifscCode,this.userId);
// }
//
// class EditChoiceInformationScreenState extends State<EditChoiceInformationScreen>{
//   ScrollController _scrollController = new ScrollController();
//   TextEditingController fullnameController;
//   TextEditingController addressController;
//   Preferences preferences;
//   final completeKYCBloc = CompleteKYCBloc();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     fullnameController = TextEditingController(text: widget.name);
//     addressController = TextEditingController(text: widget.address);
//
//     preferences = Preferences();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//         backgroundColor: Color(0xFFF8F9FE),
//         body: userDetails()
//
//     );
//   }
//
//   Widget userDetails(){
//     return Padding(
//         padding: const EdgeInsets.all(15),
//         child: SingleChildScrollView(
//             child:  Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(height: 10,),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Account Verification",
//                       style: TextStyle(
//                           color: appTheme,
//                           fontSize: 25,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 20,),
//                     Container(
//                       padding: const EdgeInsets.all(15),
//                       decoration: new BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: new BorderRadius.all(Radius.circular(15.0)),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           SizedBox(height: 10,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text('Personal information', style: TextStyle(color: appTheme, fontSize: 17,fontWeight: FontWeight.bold),),
// //                              Container(
// //                                height: 30,
// //                                width: 65,
// //                                child: Material(
// //                                  shape: RoundedRectangleBorder(
// //                                      borderRadius: BorderRadius.circular(35)),
// //                                  elevation: 1.0,
// //                                  color: appTheme,
// //                                  child: MaterialButton(
// //                                      minWidth: MediaQuery.of(context).size.width,
// //                                      onPressed: () async {
// //                                        networkCheck.isNetworkConnection().then((isNetwork) {
// //                                          if (isNetwork) {
// //                                            editUserDetails();
// //
// //                                          } else {
// //                                            showToastMessage(Strings.no_internet_message);
// //                                          }
// //                                        });
// //                                        },
// //                                      child: Text(
// //                                        "Save",style: TextStyle(
// //                                          color: Colors.white
// //                                      ),
// //                                      )
// //                                  ),
// //                                ),
// //                              )
//                             ],
//                           ),
//                           SizedBox(height: 10,),
//                           Text('Holder Name',style: TextStyle(color: colorGrey, fontSize: 14),),
//                           SizedBox(height: 5,),
//                           nameFeild(),
//                           SizedBox(height: 10,),
//                           Text('Address',style: TextStyle(color: colorGrey, fontSize: 14),),
//                           SizedBox(height: 5,),
//                          addressFeild(),
//                           SizedBox(height: 10,),
//                           Text('PAN No',style: TextStyle(color: colorGrey, fontSize: 14),),
//                           SizedBox(height: 5,),
//                           Text(widget.panNo != null ? widget.panNo.replaceRange(0, widget.panNo.length - 2, "xxxxxxxx"): "ACSPU1322P",style: TextStyle(color: Colors.black, fontSize: 15),),
//                           SizedBox(height: 10,),
//                           Text('Aadhar No',style: TextStyle(color: colorGrey, fontSize: 14),),
//                           SizedBox(height: 5,),
//                           Text('xxxxxxxx58',style: TextStyle(color: Colors.black, fontSize: 15),),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20,),
//                     Container(
//                       padding: const EdgeInsets.all(15),
//
//                       decoration: new BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: new BorderRadius.all(Radius.circular(15.0)),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: <Widget>[
//                           SizedBox(height: 10,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text('Bank information', style: TextStyle(color: appTheme, fontSize: 17,fontWeight: FontWeight.bold),),
// //                              Container(
// //                                height: 30,
// //                                width: 60,
// //                                child: Material(
// //                                  shape: RoundedRectangleBorder(
// //                                      borderRadius: BorderRadius.circular(35)),
// //                                  elevation: 1.0,
// //                                  color: appTheme,
// //                                  child: MaterialButton(
// //                                      minWidth: MediaQuery.of(context).size.width,
// //                                      onPressed: () async {
// //                                      },
// //                                      child: Text(
// //                                        "Edit",style: TextStyle(
// //                                          color: Colors.white
// //                                      ),
// //                                      )
// //                                  ),
// //                                ),
// //                              )
//                             ],
//                           ),
//
//                           SizedBox(height: 10,),
//                           Text('Account Number',style: TextStyle(color: colorGrey, fontSize: 14),),
//                           SizedBox(height: 5,),
//
//                           Text(widget.accountNo !=null ? widget.accountNo: "916010008054697 ",style: TextStyle(color: Colors.black, fontSize: 15),)  ,
//                           SizedBox(height: 10,),
//                           Text('Bank Name',style: TextStyle(color: colorGrey, fontSize: 14),),
//                           SizedBox(height: 5,),
//
//                           Text(widget.bankName !=null ? widget.bankName: "AXIS BANK ",style: TextStyle(color: Colors.black, fontSize: 15),) ,
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 40,),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Container(
//                           height: 45,
//                           width: 130,
//
//                           child: Material(
//                             color: Color(0xFFF8F9FE),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(35),
//                                 side: BorderSide(color: appTheme)),
//                             elevation: 1.0,
//                             child: MaterialButton(
//                               minWidth: MediaQuery.of(context).size.width,
//                               onPressed: () async {
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 'Cancel',
//                                 style: TextStyle(color: appTheme),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           height: 45,
//                           width: 130,
//                           child: Material(
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                             elevation: 1.0,
//                             color: appTheme,
//                             child: MaterialButton(
//                               minWidth: MediaQuery.of(context).size.width,
//                               onPressed: () async {
//                                 Utility.isNetworkConnection().then((isNetwork) {
//                                   if (isNetwork) {
//                                     editUserDetails();
//                                   } else {
//                                     showSnackBar(_scaffoldKey);
//                                   }
//                                 });
// //                                customDialogBox(context);
//
//                               },
//                               child: Text(
//                                 'Update',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//
//                   ],
//                 ),
//               ],
//             )
//         )
//     );
//   }
//
//   Widget nameFeild() {
//     final theme = Theme.of(context);
//     return StreamBuilder(
//       builder: (context, AsyncSnapshot<String> snapshot) {
//         return Padding(
//             padding: const EdgeInsets.only(left: 0, right: 0),
//             child: Theme(
//               data: theme.copyWith(primaryColor: appTheme),
//               child: TextFormField(
//                 obscureText: false,
//                 controller: fullnameController,
//                 decoration: new InputDecoration(
//                   counterText: "",
//                   focusColor: colorGrey,
//                   enabledBorder: new UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: appTheme,
//                       width: 0.5,
//                     ),
//                   ),
//                 ),
//                 keyboardType: TextInputType.text,
//               ),
//             ));
//       },
//     );
//   }
//
//   Widget addressFeild() {
//     final theme = Theme.of(context);
//     return StreamBuilder(
//       builder: (context, AsyncSnapshot<String> snapshot) {
//         return Padding(
//             padding: const EdgeInsets.only(left: 0, right: 0),
//             child: Theme(
//               data: theme.copyWith(primaryColor: appTheme),
//               child: TextFormField(
//                 obscureText: false,
//                 controller: addressController,
//                 decoration: new InputDecoration(
//                   counterText: "",
//                   focusColor: colorGrey,
//                   enabledBorder: new UnderlineInputBorder(
//                     borderSide: BorderSide(
//                       color: appTheme,
//                       width: 0.5,
//                     ),
//                   ),
//                 ),
//                 keyboardType: TextInputType.text,
//               ),
//             ));
//       },
//     );
//   }
//
//   customDialogBox(BuildContext context) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(15.0))),
//             content:
//             Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.end,
//
//                     children: <Widget>[
//                       GestureDetector(
//                         child: Icon(
//                           Icons.cancel,color: Colors.grey,
//                           size: 20,
//                         ),
//                         onTap: (){
//                           Navigator.pop(context);
//                         },
//
//                       ),
//                     ],
//                   ),
//                   Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: new Text(Strings.kyc_update_kyc,
//                             style:TextStyle(fontSize: 16.0,color: Colors.grey)),
//                       )//
//                   ),
//                   Container(
//                     height: 40,
//                     width: 100,
//                     child: Material(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(35)),
//                       elevation: 1.0,
//                       color: appTheme,
//                       child: MaterialButton(
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(builder: (BuildContext context) => DashBoard()))
//
//                            ;
//                           },
//                           child: Text("Confirm", style: TextStyle(color: Colors.white),)
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//           );
//         });
//   }
//
//   void editUserDetails(){
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     completeKYCBloc.editUserKYC(fullnameController.text, addressController.text, widget.userId).then((value) {
//       Navigator.pop(context);
//       if(value.isSuccessFull){
//         Utility.showToastMessage(Strings.edit_KYC_success);
//       }else{
//         if(value.errorCode == 417){
//           customDialogBox(context);
//         }
//         else{
//           Utility.showToastMessage(value.errorMessage);
//         }
//       }
//     });
//   }
//
//   // sendDetailsDialogBox(BuildContext context) {
//   //   return showModalBottomSheet(
//   //       backgroundColor: Colors.transparent,
//   //       context: context,
//   //       isScrollControlled: true,
//   //       builder: (BuildContext bc) {
//   //         return SendDetailsDialog(widget.name);
//   //       });
//   // }
//
// }