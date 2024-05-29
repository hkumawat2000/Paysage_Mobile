// import 'package:lms/dummy/constants.dart';
// import 'package:lms/network/responsebean/AllApprovedListResponse.dart';
// import 'package:lms/network/responsebean/SecurityCategoryResponseBean.dart';
// import 'package:lms/util/AssetsImagePath.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Style.dart';
// import 'package:lms/widgets/ErrorMessageWidget.dart';
// import 'package:lms/widgets/LoadMoreWidget.dart';
// import 'package:lms/widgets/LoadingWidget.dart';
// import 'package:lms/widgets/NoDataWidget.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ApprovedSharesList extends StatefulWidget {
//   @override
//   ApprovedSharesListState createState() => ApprovedSharesListState();
// }
//
// class ApprovedSharesListState extends State<ApprovedSharesList> {
//   final dashboardBloc = DashboardBloc();
//   TextEditingController searchController = TextEditingController();
//   List<AllApprovedList> searchShareList = [];
//   List<AllApprovedList> filterShareList = [];
//   List<AllApprovedList> originalShareList = [];
//   ScrollController _scrollController = new ScrollController();
//   SecurityCategoryModel _securityCategoryModel;
//   bool isComingFromFilter = false;
//   bool isComingFromSearch = false;
//   String filterName;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     getUserDetailsMyCartSecurities();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
//         if (!isComingFromFilter) {
//           dashboardBloc.loadMoreApproved(0, "");
//         } else {
//           dashboardBloc.loadMoreApproved(1, filterName);
//         }
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     dashboardBloc.dispose();
//     super.dispose();
//   }
//
//   void getUserDetailsMyCartSecurities() async {
//     dashboardBloc.getApprovalCount();
//     dashboardBloc.securityCategory();
//     dashboardBloc.getUserDetailsMyCartSecurities(0, "");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF8F9FE),
//       appBar: AppBar(
//         backgroundColor: Color(0xFFF8F9FE),
//         elevation: 0.0,
//         title: appBarTitle,
//         leading: IconButton(
//           icon: ArrowToolbarBackwardNavigation(),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: actionIcon,
//             onPressed: () {
//               setState(() {
//                 if (this.actionIcon.icon == Icons.search) {
//                   this.actionIcon = Icon(Icons.close, color: colorGrey);
//                   this.appBarTitle = TextFormField(
//                     onChanged: (value) {
//                       filterSearchResults(value);
//                     },
//                     controller: searchController,
//                     style: TextStyle(
//                       color: colorGrey,
//                     ),
//                     decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.search, color: colorGrey),
//                         hintText: Strings.search,
//                         hintStyle: TextStyle(color: colorGrey)),
//                   );
//                 } else {
//                   searchController.clear();
//                   searchShareList.clear();
//                   searchShareList.addAll(originalShareList);
//                   this.actionIcon = Icon(
//                     Icons.search,
//                     color: colorGrey,
//                   );
//                   this.appBarTitle = Text("");
//                 }
//               });
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           detailsWidget(),
//           SizedBox(height: 10),
//           Expanded(
//               child: searchShareList.length != 0 || searchController.text.isNotEmpty
//                   ? getAllApprovedList(searchShareList)
//                   : getSecuritiesList()),
//         ],
//       ),
//     );
//   }
//
//   Widget appBarTitle = Text("");
//   Icon actionIcon = Icon(
//     Icons.search,
//     color: colorGrey,
//   );
//
//   Widget detailsWidget() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
//       child: Column(
//         children: <Widget>[
//           Row(
//             children: <Widget>[
//               headingText(Strings.approved_securities),
//               IconButton(
//                 icon: Icon(
//                   Icons.share,
//                   size: 25,
//                   color: colorGrey,
//                 ),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               securityCategoryType(),
//               SizedBox(width: 20),
//               Padding(
//                 padding: const EdgeInsets.only(right: 20.0),
//                 child: Container(
//                   width: 30,
//                   height: 30,
//                   child: Image.asset(
//                     AssetsImagePath.pdf,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget getSecuritiesList() {
//     return StreamBuilder(
//       stream: dashboardBloc.listAllApproved,
//       builder: (context, AsyncSnapshot<List<AllApprovedList>> snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data == null && snapshot.data.length == 0) {
//             return _buildNoDataWidget();
//           } else {
//             printLog("Original List Length ::: ${originalShareList.length}");
//             originalShareList.addAll(snapshot.data);
//             return getAllApprovedList(originalShareList);
//           }
//         } else if (snapshot.hasError) {
//           return _buildErrorWidget(snapshot.error);
//         } else {
//           return _buildLoadingWidget();
//         }
//       },
//     );
//   }
//
//   Widget getAllApprovedList(List<AllApprovedList> snapshot) {
//     return snapshot.length == 0
//         ? Center(child: Text("No result found"))
//         : ListView.builder(
//             controller: _scrollController,
//             itemCount: snapshot.length + 1,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return index == snapshot.length
//                   ? _buildLoadingWidget()
//                   : Padding(
//                       padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
//                       child: Card(
//                         child: Container(
//                           margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
//                           decoration: new BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: new BorderRadius.all(Radius.circular(15.0)),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 10),
//                                 child: Text(
//                                   snapshot[index].securityName,
//                                   style: TextStyle(
//                                       color: appTheme, fontSize: 17, fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Row(
//                                 children: <Widget>[
//                                   IconButton(
//                                     icon: Icon(
//                                       Icons.beenhere,
//                                       color: Colors.lightGreen,
//                                       size: 15,
//                                     ),
//                                     onPressed: () {},
//                                   ),
//                                   Text(
//                                     snapshot[index].category != null?snapshot[index].category:"",
//                                     style: TextStyle(
//                                         color: Colors.lightGreen,
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//             });
//   }
//
//   Widget securityCategoryType() {
//     return StreamBuilder(
//       stream: dashboardBloc.listSecurityCategory,
//       builder: (context, AsyncSnapshot<List<SecurityCategoryModel>> snapshot) {
//         return DropdownButtonHideUnderline(
//           child: DropdownButton<SecurityCategoryModel>(
//             icon: Image.asset(
//               AssetsImagePath.filter,
//               height: 30,
//               width: 30,
//             ),
//             items: snapshot.data
//                     ?.map((leave) => DropdownMenuItem<SecurityCategoryModel>(
//                           child: Text(leave.name),
//                           value: leave,
//                         ))
//                     ?.toList() ??
//                 [],
//             onChanged: changedDropDownSecurityCategory,
//           ),
//         );
//       },
//     );
//   }
//
//   void changedDropDownSecurityCategory(SecurityCategoryModel securityCategoryModel) {
//     if (securityCategoryModel.name != "All") {
//       setState(() {
//         searchController.clear();
//         searchShareList.clear();
//         isComingFromFilter = true;
//         _securityCategoryModel = securityCategoryModel;
//         filterName = _securityCategoryModel.name;
//         dashboardBloc.getUserDetailsMyCartSecurities(1, _securityCategoryModel.name).then((value) {
//           setState(() {
//             originalShareList.clear();
//           });
//         });
//       });
//     } else {
//       setState(() {
//         searchController.clear();
//         searchShareList.clear();
//         originalShareList.clear();
//         _securityCategoryModel = securityCategoryModel;
//         dashboardBloc.getUserDetailsMyCartSecurities(0, "").then((value) {
//           setState(() {
//             originalShareList.clear();
//           });
//         });
//       });
//     }
//   }
//
//   void filterSearchResults(String query) {
//     List<AllApprovedList> dummySearchList = List<AllApprovedList>();
//     dummySearchList.addAll(originalShareList);
//     if (query.isNotEmpty) {
//       List<AllApprovedList> dummyListData = List<AllApprovedList>();
//       dummySearchList.forEach((item) {
//         if (item.securityName.toLowerCase().contains(query.toLowerCase())) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         isComingFromSearch = true;
//         searchShareList.clear();
//         searchShareList.addAll(dummyListData);
//       });
//     } else {
//       setState(() {
//         searchShareList.clear();
//         searchShareList.addAll(originalShareList);
//       });
//     }
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
// }
