// import 'package:choice/util/AssetsImagePath.dart';
// import 'package:choice/util/Colors.dart';
// import 'package:choice/util/strings.dart';
// import 'package:flutter/material.dart';
//
// class PaymentSettingMenu extends StatefulWidget {
//   @override
//   _PaymentSettingMenuState createState() => _PaymentSettingMenuState();
// }
//
// class _PaymentSettingMenuState extends State<PaymentSettingMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         ListView.builder(
//             itemCount: 3,
//             scrollDirection: Axis.vertical,
//             shrinkWrap: true,
//             physics: ScrollPhysics(),
//             itemBuilder: (BuildContext context, int index) {
//               return PaymentSetting(AssetImage(AssetsImagePath.atm),
//                   'HDFC A/c xxxxxxxxxx5678');
//             }),
//         Divider(color: colorGrey),
//         GestureDetector(
//             child: Container(
//               padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 borderRadius:
//                 BorderRadius.all(Radius.circular(10)),
//                 border: Border.all(color: red),
//               ),
//               child: Text(
//                 'Add New',
//                 style: TextStyle(
//                     fontSize: 14,
//                     color: colorBlack,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Gilroy'),
//               ),
//             ),
//             onTap: () {
//               showModalBottomSheet(
//                 backgroundColor: Colors.transparent,
//                 context: context,
//                 isScrollControlled: true,
//                 isDismissible: false,
//                 enableDrag: false,
//                 builder: (BuildContext bc) {
//                   return AddNewPaymentMethod();
//                 },
//               );
//             }),
//       ],
//     );
//   }
// }
//
//
// class PaymentSetting extends StatefulWidget {
//   final leadingIcon;
//   final title;
//
//   const PaymentSetting(this.leadingIcon, this.title);
//
//   @override
//   _PaymentSettingState createState() => _PaymentSettingState();
// }
//
// class _PaymentSettingState extends State<PaymentSetting> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Divider(color: colorGrey),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             children: [
//               Image(
//                 image: widget.leadingIcon,
//                 height: 24,
//                 width: 20,
//                 color: colorGreen,
//               ),
//               SizedBox(width: 10),
//               Text(
//                 widget.title,
//                 style: TextStyle(color: appTheme, fontWeight: FontWeight.bold),
//               ),
//               Spacer(),
//               Icon(
//                 Icons.remove_circle_outline,
//                 color: colorGrey,
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class AddNewPaymentMethod extends StatefulWidget {
//   @override
//   _AddNewPaymentMethodState createState() => _AddNewPaymentMethodState();
// }
//
// class _AddNewPaymentMethodState extends State<AddNewPaymentMethod> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   List<String> _locations = [
//     'New Bank Account',
//     'New Bank Account',
//     'New Bank Account',
//     'New Bank Account'
//   ];
//   String? _selectedLocation;
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.transparent,
//       bottomNavigationBar: AnimatedPadding(
//         duration: Duration(milliseconds: 150),
//         curve: Curves.easeOut,
//         padding: EdgeInsets.all(0),
//         child: Container(
//           height: (MediaQuery.of(context).size.height) - (300),
//           width: double.infinity,
//           decoration: new BoxDecoration(
//             color: colorWhite,
//             borderRadius: new BorderRadius.only(
//               topLeft: const Radius.circular(20.0),
//               topRight: const Radius.circular(20.0),
//             ),
//           ),
//           child: AddPaymentMethodDialog(),
//         ),
//       ),
//     );
//   }
//
//   Widget AddPaymentMethodDialog() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             GestureDetector(
//               child: Container(
//                 alignment: Alignment.topRight,
//                 child: Icon(
//                   Icons.cancel_outlined,
//                   color: colorGrey,
//                   size: 26,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             Text(
//               Strings.add_new_payment_method,
//               style: TextStyle(
//                 fontSize: 20,
//                 color: red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Container(
//               padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//               decoration: BoxDecoration(
//                 border: Border.all(color: appTheme, width: 1),
//               ),
//               child: DropdownButton(
//                 hint: Text('New Bank Account'),
//                 underline: SizedBox(),
//                 isExpanded: true,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedLocation = newValue as String?;
//                   });
//                 },
//                 items: _locations.map((location) {
//                   return DropdownMenuItem(
//                     child: new Text(location),
//                     value: location,
//                   );
//                 }).toList(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Name',
//                 hintText: 'Complete Name',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'IFSC',
//                 hintText: 'IFSC',
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Account #',
//                 hintText: 'Account #',
//               ),
//             ),
//             // SizedBox(height: 10),
//             // Text(
//             //   Strings.add_new_payment_method_footer,
//             //   style: TextStyle(
//             //     fontSize: 12,
//             //     color: appTheme,
//             //     fontWeight: FontWeight.bold,
//             //   ),
//             // ),
//             SizedBox(height: 20),
//             Center(
//               child: Card(
//                 elevation: 6.0,
//                 color: colorWhite,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: CircleAvatar(
//                     radius: 20,
//                     backgroundColor: colorGreen,
//                     child: Icon(Icons.add, color: colorWhite, size: 20),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }
// }
