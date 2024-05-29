import 'package:lms/common_widgets/constants.dart';
import 'package:lms/network/responsebean/NotificationResponseBean.dart';
import 'package:lms/notification/NotificationBloc.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final notificationBloc = NotificationBloc();
  List<NotificationData> notificationList = <NotificationData>[];
  bool isResponsed = false;
  // final SlidableController slidableController = SlidableController();

  @override
  void initState() {
    notificationBloc.getNotification().then((value) {
      if(value.isSuccessFull!){
        if(value.notificationData != null && value.notificationData!.length != 0) {
          notificationList.addAll(value.notificationData!);
          notificationList.removeWhere((element) => element.isCleared == 1);
        }
        setState((){
          isResponsed = true;
        });
      } else if(value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
    super.initState();
  }

  Future<bool> _willPopCallback() async {
    Navigator.pop(context, "cancel");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorBg,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: colorBg,
          leading: IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () {
              Navigator.pop(context, "cancel");
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  headingText("Notifications"),
                  isResponsed
                      ? notificationList.length == 0
                      ? SizedBox()
                      : GestureDetector(
                    child: Text(Strings.clear_all, style: kSecurityLiteStyle.copyWith(fontSize: 15.0)),
                    onTap: (){
                      Utility.isNetworkConnection().then((isNetwork) async {
                        if (isNetwork) {
                          deleteDialog(context, "", Strings.clear_all);
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  ) : SizedBox(),
                ],
              ),
              SizedBox(height: 14),
              !isResponsed
                  ? Expanded(child: Center(child: Text(Strings.please_wait)))
                  : notificationList.length == 0
                  ? Expanded(child: Center(child: Text("No notification found")))
                  : Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: notificationList.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: UniqueKey(),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.001,
                        openThreshold: 0.5,
                        dismissible: DismissiblePane(onDismissed: () {
                          Utility.isNetworkConnection().then((isNetwork) async {
                            if (isNetwork) {
                              deleteApiCall(notificationList[index].name!, Strings.delete);
                            } else {
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        }),
                        children: [
                          SlidableAction(
                            autoClose: true,
                            backgroundColor: Colors.transparent,
                            foregroundColor: red,
                            icon: Icons.delete,
                            onPressed: (BuildContext context) => null,
                          ),
                        ],
                      ),
                      child: notificationTile(
                          index,
                          notificationList[index].title,
                          notificationList[index].message,
                          notificationList[index].time,
                          notificationList[index].notificationType == "Success"
                              ? Image.asset(AssetsImagePath.success_notification, height: 36, width: 36)
                              : Image.asset(AssetsImagePath.warning_notification, height: 36, width: 36),
                          notificationList[index].name,
                          notificationList[index].isRead,
                          notificationList[index].isCleared,
                          notificationList[index].screenToOpen,
                          notificationList[index].loan
                      ),
                      // secondaryActions: [
                      //   IconSlideAction(
                      //     color: Colors.transparent,
                      //     closeOnTap: true,
                      //     iconWidget: Image.asset(AssetsImagePath.delete_notification, height: 40, width: 40),
                      //     onTap: () {
                      //       Utility.isNetworkConnection().then((isNetwork) async {
                      //         if (isNetwork) {
                      //           deleteDialog(context, notificationList[index].name!, Strings.delete);
                      //         } else {
                      //           Utility.showToastMessage(Strings.no_internet_message);
                      //         }
                      //       });
                      //     },
                      //   )
                      // ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> deleteDialog(BuildContext context,String name, String isComingFor) {
    return showDialog<bool>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(isComingFor == Strings.delete ? Strings.delete_pop_up : Strings.clear_all_pop_up, style: regularTextStyle_16_dark),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35), side: BorderSide(color: red)),
                          elevation: 1.0,
                          color: colorWhite,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Utility.isNetworkConnection().then((isNetwork) async {
                                if (isNetwork) {
                                  Navigator.of(context).pop(false);
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
                            child: Text(
                              Strings.no,
                              style: buttonTextRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 40,
                        child: Material(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          elevation: 1.0,
                          color: appTheme,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              Utility.isNetworkConnection().then((isNetwork) async {
                                if (isNetwork) {
                                  Navigator.of(context).pop(true);
                                  deleteApiCall(name, isComingFor);
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
                            child: Text(
                              Strings.yes,
                              style: buttonTextWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  deleteApiCall(String name, String isComingFor){
    // LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    notificationBloc.deleteOrClearNotification(0, 1, name).then((value) {
      // Navigator.pop(context);
      if(value.isSuccessFull!){
        setState(() {
          if(isComingFor == Strings.delete) {
            notificationList.removeWhere((element) => element.name == name);
          } else if(isComingFor == Strings.clear_all) {
            notificationList.clear();
          }
        });
      } else if(value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  Widget notificationTile(index, notificationTitle, notificationBody, notificationTime, notificationImage, name, isRead, isClear, screenToOpen, String? loan){
   return GestureDetector(
     child: Card(
       color: isRead == 1 ? colorWhite : colorLightBlue,
       elevation: 0,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.all(Radius.circular(10)),
       ),
       margin: EdgeInsets.symmetric(vertical: 6.0),
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             CircleAvatar(
               child: notificationImage,
               radius: 18.0,
             ),
             SizedBox(width: 10),
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(
                     notificationTitle,
                     style: selectSecuritiesHeading,
                   ),
                   SizedBox(height: 10),
                   Text(
                     notificationBody,
                     style: kSecurityLiteStyle.copyWith(color: colorBlack),
                   ),
                   SizedBox(height: 12),
                   Row(
                     children: <Widget>[
                       Image.asset(AssetsImagePath.timer,height: 15,width: 15),
                       Padding(
                         padding: const EdgeInsets.only(left: 4),
                         child: Text(
                           notificationTime,
                           style: kSecurityLiteStyle,
                         ),
                       )
                     ],
                   )
                 ],
               ),
             ),
           ],
         ),
       ),
     ),
     onTap: (){
       Utility.isNetworkConnection().then((isNetwork) async {
         if (isNetwork) {
           if(isRead == 0) {
             LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
             notificationBloc.deleteOrClearNotification(1, 0, name).then((value) {
               Navigator.pop(context);
               if (value.isSuccessFull!) {
                 setState(() {
                   notificationList[index].isRead = 1;
                 });
                 notificationNavigator(context, screenToOpen, loan);
               } else if(value.errorCode == 403) {
                 commonDialog(context, Strings.session_timeout, 4);
               } else {
                 Utility.showToastMessage(value.errorMessage!);
               }
             });
           } else {
             notificationNavigator(context, screenToOpen, loan);
           }
         } else {
           Utility.showToastMessage(Strings.no_internet_message);
         }
       });
     },
   );
  }
}
