// import 'package:lms/util/Colors.dart';
// import 'package:flutter/material.dart';
//
// class SavedAddressedMenu extends StatefulWidget {
//   @override
//   _SavedAddressedMenuState createState() => _SavedAddressedMenuState();
// }
//
// class _SavedAddressedMenuState extends State<SavedAddressedMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SavedAddressedItems('Home', 'Apt./Door #, Building Name Society Name, Street Name & Locality Area, City Name 000000 State Name, Country'),
//         SavedAddressedItems('Office', 'Apt./Door #, Building Name Society Name, Street Name & Locality Area, City Name 000000 State Name, Country'),
//       ],
//     );
//   }
// }
//
// class SavedAddressedItems extends StatefulWidget {
//
//   final title;
//   final address;
//
//   const SavedAddressedItems(this.title, this.address);
//
//   @override
//   _SavedAddressedItemsState createState() => _SavedAddressedItemsState();
// }
//
// class _SavedAddressedItemsState extends State<SavedAddressedItems> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Divider(color: colorGrey),
//             SizedBox(height: 10),
//             Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold)),
//             Padding(
//               padding: const EdgeInsets.only(right: 30,bottom: 10),
//               child: Text(widget.address,
//                   style:TextStyle(color: colorGrey)),
//             ),
//           ],
//         ),
//         Container(
//           alignment: Alignment.topRight,
//           padding: EdgeInsets.fromLTRB(5, 20, 5, 10),
//           child: Icon(Icons.edit,color: colorGreen),
//         )
//       ],
//     );
//   }
// }