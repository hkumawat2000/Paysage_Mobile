// import 'dart:convert';
// import 'dart:io';
// import 'package:lms/login/LoginDao.dart';
// import 'package:lms/network/responsebean/TDSListResponseBean.dart';
// import 'package:lms/network/responsebean/UploadTDSDaoResponseBean.dart';
// import 'package:lms/shares/LoanOTPVerification.dart';
// import 'package:lms/tds/UploadTDSBloc.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Utility.dart';
// import 'package:lms/util/strings.dart';
// import 'package:lms/widgets/ErrorMessageWidget.dart';
// import 'package:lms/widgets/LoadingDialogWidget.dart';
// import 'package:lms/widgets/LoadingWidget.dart';
// import 'package:lms/widgets/NoDataWidget.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class UploadTDS extends StatefulWidget {
//   @override
//   _UploadTDSState createState() => _UploadTDSState();
// }
//
// class _UploadTDSState extends State<UploadTDS> {
//   UploadTDSBloc _uploadTDSBloc = UploadTDSBloc();
//   ScrollController _scrollController = new ScrollController();
//   File? tdsFile;
//
//   @override
//   void initState() {
//     super.initState();
//     _uploadTDSBloc.getTDSList();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//         printLog('On scrollbar scrolling');
//         _uploadTDSBloc.loadMoreTDS();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Color(0xFFF8F9FE),
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Image.asset(
//               width: 17,
//               height: 17,
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           backgroundColor: Color(0xFFF8F9FE),
//           elevation: 0.0,
//           centerTitle: true,
//         ),
//         floatingActionButton: new FloatingActionButton(
//           backgroundColor: appTheme,
//           onPressed: () {
//             checkPermission();
//           },
//           child: const Icon(Icons.add),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         body: NestedScrollView(
//             physics: ScrollPhysics(),
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 SliverList(
//                   delegate: SliverChildListDelegate(
//                     [
//                       titleCart(),
//                     ],
//                   ),
//                 )
//               ];
//             },
//             body: StreamBuilder(
//               stream: _uploadTDSBloc.tdslist,
//               builder: (context, AsyncSnapshot<List<TDS>> snapshot) {
//                 printLog("snapshot $snapshot");
//                 if (snapshot.hasData) {
//                   if (snapshot.data == null || snapshot.data!.length == 0) {
//                     return _buildNoDataWidget();
//                   } else {
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           margin: EdgeInsets.all(10),
//                           padding: EdgeInsets.symmetric(vertical: 10),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.rectangle,
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             color: Colors.white,
//                           ),
//                           child: ListTile(
//                             title: Row(
//                               children: [
//                                 Image.asset(
//                                   width: 30,
//                                   height: 30,
//                                 ),
//                                 SizedBox(width: 10),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(snapshot.data![index].name!,
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold)),
//                                     SizedBox(height: 5),
//                                     Text(
//                                       'PDF',
//                                       style: TextStyle(fontSize: 11),
//                                     ),
//                                     SizedBox(height: 5),
//                                     Text(
//                                       snapshot.data![index].year!,
//                                       style: TextStyle(fontSize: 11),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             // trailing: IconButton(
//                             //   icon: Icon(
//                             //     Icons.clear,
//                             //     size: 15,
//                             //   ),
//                             //   onPressed: () {},
//                             // ),
//                             onTap: () {},
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 } else if (snapshot.hasError) {
//                   return _buildErrorWidget(snapshot.error.toString());
//                 } else {
//                   return _buildLoadingWidget();
//                 }
//               },
//             )),
//       ),
//     );
//   }
//
//   //List<String> docPaths;
//
//   void _getDocuments() async {
//     List<String> docPaths = [];
//     printLog("before docPaths $docPaths");
//     // docPaths = await DocumentsPicker.pickDocuments;
//
//     if (!mounted) return;
//     printLog("docPaths after $docPaths");
//     if(docPaths.length>0){
//       File file = File(docPaths[0]);
//       uploadTDSDialogBox(context, file);
//       docPaths = [];
//     }
//   }
//
//   uploadTDSDialogBox(BuildContext context, File file) {
//     String fileName = file.path.split('/').last;
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(15.0))),
//             content: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[
//                       GestureDetector(
//                         child: Icon(
//                           Icons.cancel,
//                           color: Colors.grey,
//                           size: 20,
//                         ),
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                   Text(
//                     "Upload TDS Certificate",
//                     style: TextStyle(fontSize: 20, color: appTheme),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Column(
//                         children: <Widget>[
//                           Text("$fileName will be uploaded to LMS",
//                               style: TextStyle(
//                                   fontSize: 16.0, color: Colors.grey)),
//                         ],
//                       )),
//                   SizedBox(height: 10),
//                   Container(
//                     height: 40,
//                     width: 100,
//                     child: Material(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(35)),
//                       elevation: 1.0,
//                       color: appTheme,
//                       child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () {
//                             Navigator.pop(context);
//                             uploadTDSCertificate(file);
//                           },
//                           child: Text("Submit", style: TextStyle(color: Colors.white),)),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   refreshList() {
//     printLog("REFRESHSHHSHS");
//     _uploadTDSBloc.getTDSList();
//     setState(() {});
//   }
//
//   Widget _buildLoadingWidget() {
//     return LoadingWidget();
//   }
//
//   Widget _buildErrorWidget(String error) {
//     return ErrorMessageWidget(error: error);
//   }
//
//   Widget _buildNoDataWidget() {
//     return NoDataWidget();
//   }
//
//   Widget titleCart() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, top: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Upload\nTDS Certificates',
//             style: TextStyle(
//                 color: appTheme, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
//
//   checkPermission() async {
//     var status = await Permission.storage.status;
//     printLog("STORAGE permission status $status");
//     if(status == PermissionStatus.granted){
//       _getDocuments();
//     }
//     else{
//       var storage_permission_access = await Permission.storage.request();
//       printLog("STORAGE storage_permission_access status $storage_permission_access");
//       if(storage_permission_access == PermissionStatus.granted){
//         _getDocuments();
//       }
//       else{
//
//       }
//     }
//   }
//
//   void uploadTDSCertificate(File file) {
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     int currentYear = DateTime.now().year;
//     int nextYear = currentYear + 1;
//     _uploadTDSBloc.uploadTDS("1000", "${currentYear.toString}-${nextYear.toString()}", file).then((responseBean) {
//       printLog("responseBean $responseBean");
//     Navigator.pop(context);
//
//     if (responseBean.isSuccessFull!) {
//       Utility.showToastMessage(Strings.tds_upload);
//       _uploadTDSBloc.getTDSList();
//     } else {
//         Utility.showToastMessage(responseBean.message!.message!);
//       }
//   });
// }
// }
