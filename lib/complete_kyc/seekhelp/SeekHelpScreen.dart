// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'ChatAppBar.dart';
// import 'ChatListWidget.dart';
// import 'InputWidget.dart';
//
// class SeekHelpScreen extends StatefulWidget{
//   @override
//   SeekHelpScreenState createState() => SeekHelpScreenState();
//
// }
//
// class SeekHelpScreenState extends State<SeekHelpScreen>{
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.grey.shade50,
//             appBar: ChatAppBar(), // Custom app bar for chat screen
//             body: Stack(children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   ChatListWidget(),//Chat list
//                   InputWidget() // The input widget
//                 ],
//               ),
//             ]
//             )
//         )
//     );
//   }
//
// }