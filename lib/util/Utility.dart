import 'dart:io';

import 'package:choice/util/strings.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class Utility {
  static Future<bool> isNetworkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      printLog('Connectivity ==> Mobile Network');
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      printLog('Connectivity ==> Wifi Network');
      return true;
    }
    return false;
  }

  static showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Future<String> getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }

  // 1. created object of local authentication class
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  // 2. variable for track whether your device support local authentication means have fingerprint or face recognization sensor or not
  bool hasFingerPrintSupport = false;

  Future<bool> getBiometricsSupport() async {
    // this method checks whether your device has biometric support or not
    try {
      hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      printLog(e.toString());
    }
    return hasFingerPrintSupport;
  }

  Future<List<BiometricType>> getAvailableSupport() async {
    // this method fetches all the available biometric supports of the device
    List<BiometricType> availableBuimetricType = <BiometricType>[];
    try {
      availableBuimetricType = await _localAuthentication.getAvailableBiometrics();
    } catch (e) {
      printLog(e.toString());
    }
    return availableBuimetricType;
  }

  Future<bool> authenticateMe() async {
    try {
      return await _localAuthentication.authenticate(
        localizedReason: 'Touch your finger on sensor to login',
        options: AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: false,
            useErrorDialogs: false
        ),
      );
    } on PlatformException catch (e) {
      if(e.code == auth_error.lockedOut){
        Utility.showToastMessage("Too many attempts. Try again after 30 seconds");
      } else if(e.code == auth_error.permanentlyLockedOut) {
        Utility.showToastMessage("Too many incorrect attempts. Biometric authentication is disabled,until the user unlocks with strong authentication.");
      } else {
        Utility.showToastMessage(e.message.toString());
      }
      return false;
    }
  }


  Future showFingerDialog(String message, BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }


  static const platform = const MethodChannel('samples.flutter.io/email');
  static openJiffy(context) async {
    String jiffyPackage = "com.choiceequitybroking.jiffy";
    String url = "https://play.google.com/store/apps/details?id=$jiffyPackage";
    Uri uri = Uri.parse(url);

    /// Using Kotlin
    try {
      var res = await platform.invokeMethod("openJiffy");
      if (res) {
        printLog("Navigated :: $res");
      } else {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        } else {
          throw 'Could not launch $url';
        }
      }
    } catch (e) {
      printLog(e.toString());
    }
  }

  static launchURL(url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  showPhotoPermissionDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Text(Strings.photo_permission),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            child: Text('Settings'),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
          ),
        ],
      ),
    );
  }

  //Main logic for app update
  Future<bool> canUpdateVersion(storeVersion, localVersion) async {
    final local = localVersion.split('.').map(int.parse).toList();
    final store = storeVersion.split('.').map(int.parse).toList();
    for (var i = 0; i < store.length; i++) {
      if (store[i] > local[i]) {
        return true;
      }
      if (local[i] > store[i]) {
        return false;
      }
    }
    return false;
  }

  //Force/Manual update dialog
 forceUpdatePopUp(BuildContext context, bool isForceUpdate, String storeURL, String storeWhatsNew) async {
   return showDialog(
     context: context,
     barrierDismissible: isForceUpdate ? false : true,
     builder: (context) {
       return WillPopScope(
         onWillPop: () async {
           if(isForceUpdate) {
             SystemNavigator.pop();
             return false;
           } else {
             return true;
           }
         },
         child: Platform.isAndroid ? AlertDialog(
           title: Text('Update Available!'),
           content:Text("New version of the app is available; Kindly update the app to continue.\n\nWhat's New: \n$storeWhatsNew"),
           actions: <Widget>[
             isForceUpdate ? SizedBox() : FlatButton(
               child: new Text('Not Now', style: TextStyle(color:Colors.blue),),
               onPressed: () => Navigator.pop(context),
             ),
             FlatButton(
               child: new Text(isForceUpdate ? 'Update Now' : 'Update', style: TextStyle(color:Colors.blue),),
               onPressed: () {
                 Utility.isNetworkConnection().then((isNetwork) async {
                   if (isNetwork) {
                     Utility.launchURL(storeURL);
                   } else {
                     Utility.showToastMessage(Strings.no_internet_message);
                   }
                 });
               },
             )
           ],
         ) : CupertinoAlertDialog(
           title: Text('Update Available!'),
           content:Text("New version of the app is available; Kindly update the app to continue.\n\nWhat's New: \n$storeWhatsNew"),
           actions: <Widget>[
             isForceUpdate ? Column(
               children: [
                 CupertinoDialogAction(
                   child: Text("Update Now", style: TextStyle(color:Colors.blue),),
                   onPressed: () {
                     Utility.isNetworkConnection().then((isNetwork) async {
                       if (isNetwork) {
                         Utility.launchURL(storeURL);
                       } else {
                         Utility.showToastMessage(Strings.no_internet_message);
                       }
                     });
                   },
                 ),
               ],
             ) : Column(
               children: [
                 CupertinoDialogAction(
                   child: Text("Not Now", style: TextStyle(color:Colors.blue),),
                   onPressed: () => Navigator.pop(context),
                 ),
                 CupertinoDialogAction(
                   child: Text("Update Now", style: TextStyle(color:Colors.blue),),
                   onPressed: () {
                     Utility.isNetworkConnection().then((isNetwork) async {
                       if (isNetwork) {
                         Utility.launchURL(storeURL);
                       } else {
                         Utility.showToastMessage(Strings.no_internet_message);
                       }
                     });
                   },
                 ),
               ],
             ),
           ],
         ),
       );
     },
   );
 }
}
