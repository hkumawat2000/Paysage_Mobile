import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/widgets/common_widgets.dart';
import 'package:lms/aa_getx/modules/notification/presentation/controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => controller.willPopCallback(),
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: colorBg,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: colorBg,
          leading: IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () => Get.back(result: "cancel"),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Obx(
            () => Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    headingText("Notifications"),
                    controller.isResponsed.isTrue
                        ? controller.notificationList.length == 0
                            ? SizedBox()
                            : GestureDetector(
                                child: Text(Strings.clear_all,
                                    style: kSecurityLiteStyle.copyWith(
                                        fontSize: 15.0)),
                                onTap: () => controller.clearAllClicked(),
                              )
                        : SizedBox(),
                  ],
                ),
                SizedBox(height: 14),
                controller.isResponsed.isFalse
                    ? Expanded(child: Center(child: Text(Strings.please_wait)))
                    : controller.notificationList.length == 0
                    ? Expanded(
                    child: Center(
                        child: Text(Strings.noNotificationFoundString)))
                    : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.notificationList.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          controller.onDismissClicked(
                              controller.notificationList[index]);
                        },
                        confirmDismiss:
                            (DismissDirection direction) async {
                          final confirmed =
                          await Get.dialog<bool>(AlertDialog(
                            title: const Text('Are you sure you want to delete?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Get.back(result: false),
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back(result: true);
                                  controller.onDismissClicked(
                                      controller
                                          .notificationList[index]);
                                },
                                child: const Text('Yes'),
                              )
                            ],
                          ));
                          return confirmed;
                        },
                        // endActionPane: ActionPane(
                        //   motion: const ScrollMotion(),
                        //   extentRatio: 0.001,
                        //   openThreshold: 0.5,
                        //   dismissible: DismissiblePane(onDismissed: ()=> controller.onDismissClicked(controller.notificationList[index])),
                        //   children: [
                        //     SlidableAction(
                        //       autoClose: true,
                        //       backgroundColor: Colors.transparent,
                        //       foregroundColor: red,
                        //       icon: Icons.delete,
                        //       onPressed: (BuildContext context) => null,
                        //     ),
                        //   ],
                        // ),
                        background: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(right: 16.0),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        child: notificationTile(
                            index,
                            controller.notificationList[index].title,
                            controller.notificationList[index].message,
                            controller.notificationList[index].time,
                            controller.notificationList[index]
                                .notificationType ==
                                "Success"
                                ? Image.asset(
                                AssetsImagePath
                                    .success_notification,
                                height: 36,
                                width: 36)
                                : Image.asset(
                                AssetsImagePath
                                    .warning_notification,
                                height: 36,
                                width: 36),
                            controller.notificationList[index].name,
                            controller.notificationList[index].isRead,
                            controller
                                .notificationList[index].isCleared,
                            controller
                                .notificationList[index].screenToOpen,
                            controller.notificationList[index].loan),
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
      ),
    );
  }

  Widget notificationTile(
      index,
      notificationTitle,
      notificationBody,
      notificationTime,
      notificationImage,
      name,
      isRead,
      isClear,
      screenToOpen,
      String? loan) {
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
                        Image.asset(AssetsImagePath.timer,
                            height: 15, width: 15),
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
      onTap: () => controller.notificationClicked(
          index, isRead, name, screenToOpen, loan),
    );
  }
}

Future<bool?> deleteDialog(
    String name, String isComingFor, NotificationController controller) {
  return Get.dialog<bool>(
      barrierDismissible: true,
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: Container(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  isComingFor == Strings.delete
                      ? Strings.delete_pop_up
                      : Strings.clear_all_pop_up,
                  style: regularTextStyle_16_dark),
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
                            borderRadius: BorderRadius.circular(35),
                            side: BorderSide(color: red)),
                        elevation: 1.0,
                        color: colorWhite,
                        child: MaterialButton(
                          minWidth: Get.width,
                          onPressed: () => controller.noClicked(),
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
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        elevation: 1.0,
                        color: appTheme,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          minWidth: Get.width,
                          onPressed: () =>
                              controller.yesClicked(name, isComingFor),
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
      ));
}
