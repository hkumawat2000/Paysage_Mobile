import 'dart:async';
import 'dart:io';

import 'package:lms/FlavorConfig.dart';
import 'package:lms/splash/SplashScreen.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/MyHttp.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uni_links/uni_links.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  //Config the flavor
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String packageName = packageInfo.packageName;
  if(packageName == Strings.android_prod_package || packageName == Strings.ios_prod_package){
    FlavorConfig(flavor: Flavor.PROD);
  } else if(packageName == Strings.android_uat_package || packageName == Strings.ios_uat_package){
    FlavorConfig(flavor: Flavor.UAT);
  } else if(packageName == Strings.android_qa_package || packageName == Strings.ios_qa_package){
    FlavorConfig(flavor: Flavor.QA);
  } else {
    FlavorConfig(flavor: Flavor.DEV);
  }

  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides(); //for badCertificateCallback
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colorLightBlue, statusBarIconBrightness: Brightness.dark // status bar color
  ));


  Function originalOnError = FlutterError.onError!;
  FlutterError.onError = (FlutterErrorDetails errorDetails) async {
    await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    originalOnError(errorDetails);
  };

  runZoned(() {
    runApp(MyApp()
      //DevicePreview(enabled: false, builder: (context) => MyApp())
      ); // used device preview
  }, onError: FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Preferences preferences = Preferences();

  @override
  void initState() {
    initUniLinks();
    super.initState();
  }

  //Deep Linking
  Future<void> initUniLinks() async {
    try {
      String? initialLink = await getInitialLink();
      preferences.setSmsRedirection("");
      if(initialLink != null){
        var uri = Uri.parse(initialLink);
        if(uri.queryParameters['id'] != null){
          preferences.setSmsRedirection(uri.queryParameters['id'].toString().toLowerCase());
        }
      }
    } on PlatformException {
      printLog("====> PlatformException <====");
    }
  }

  @override
  Widget build(BuildContext context) {
    //Restrict app to change device orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{}
    );
  }
}


