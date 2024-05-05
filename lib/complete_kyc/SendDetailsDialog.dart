//
// import 'package:choice/util/Colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// class SendDetailsDialog extends StatefulWidget {
//   String userName;
//
//   @override
//   SendDetailsDialogState createState() => new SendDetailsDialogState();
//   SendDetailsDialog(this.userName);
//
// }
//
// class SendDetailsDialogState extends State<SendDetailsDialog>
//     with TickerProviderStateMixin {
//
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         backgroundColor: Colors.transparent,
//         bottomNavigationBar: AnimatedPadding(
//           duration: Duration(milliseconds: 150),
//           curve: Curves.easeOut,
//           padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Container(
//               height: 250,
//               decoration: new BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: new BorderRadius.only(
//                   topLeft: const Radius.circular(25.0),
//                   topRight: const Radius.circular(25.0),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Image.asset(
//                       width: 60,
//                       height: 60,
//                     ),
//                     SizedBox(height: 30,),
//                     new Text("Your updated details will be send to our support system",
//                         style:TextStyle(fontSize: 14,color: Colors.black)),
//                     SizedBox(height: 20,),
//                     Container(
//                       height: 40,
//                       width: 200,
//                       child: Material(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35)),
//                         elevation: 1.0,
//                         color: appTheme,
//                         child: MaterialButton(
//                             minWidth: MediaQuery.of(context).size.width,
//                             onPressed: () async {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
//                             },
//                             child: Text("Next", style: TextStyle(color: Colors.white),)
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//           ),
//         ));
//   }
// }
