import 'dart:async';
import 'dart:io';

import 'package:alice/alice.dart';
import 'package:flutter/foundation.dart';
import 'package:lms/FlavorConfig.dart';
import 'package:lms/splash/SplashScreen.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/MyHttp.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/alice.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
//import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
// The following assertion was thrown during runApp:
// Zone mismatch.
// The Flutter bindings were initialized in a different zone than is now being used. This will likely
// cause confusion and bugs as any zone-specific configuration will inconsistently use the
// configuration of the original binding initialization zone or this zone based on hard-to-predict
// factors such as which zone was active when a particular callback was set.
// It is important to use the same zone when calling `ensureInitialized` on the binding as when calling
// `runApp` later.
// To make this warning fatal, set BindingBase.debugZoneErrorsAreFatal to true before the bindings are
// initialized (i.e. as the first statement in `void main() { }`).
  BindingBase.debugZoneErrorsAreFatal = true; // Make zone errors fatal

  // runZoned captures errors and exceptions but does not prevent the app from crashing.
  // On the other hand, runZonedGuarded captures errors, allows you to handle them gracefully,
  // and then prevents the app from crashing.
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: colorLightBlue,
        statusBarIconBrightness: Brightness.dark // status bar color
        ));

    //Config the flavor
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    if (packageName == Strings.android_prod_package ||
        packageName == Strings.ios_prod_package) {
      FlavorConfig(flavor: Flavor.PROD);
    } else if (packageName == Strings.android_uat_package ||
        packageName == Strings.ios_uat_package) {
      FlavorConfig(flavor: Flavor.UAT);
    } else if (packageName == Strings.android_qa_package ||
        packageName == Strings.ios_qa_package) {
      FlavorConfig(flavor: Flavor.QA);
    } else {
      FlavorConfig(flavor: Flavor.DEV);
    }

    HttpOverrides.global = MyHttpOverrides(); //for badCertificateCallback
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    Function originalOnError = FlutterError.onError!;
    FlutterError.onError = (FlutterErrorDetails errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      catchUnhandledExceptions(errorDetails.exception, errorDetails.stack);
      originalOnError(errorDetails);
    };

    runApp(MyApp());
  }, catchUnhandledExceptions);
}

void catchUnhandledExceptions(Object error, StackTrace? stack) {
  FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  debugPrintStack(stackTrace: stack, label: error.toString());
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
      if (initialLink != null) {
        var uri = Uri.parse(initialLink);
        if (uri.queryParameters['id'] != null) {
          preferences.setSmsRedirection(
              uri.queryParameters['id'].toString().toLowerCase());
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
        navigatorKey: alice.getNavigatorKey(),
        //FlavorConfig.isDevelopment() ? alice.getNavigatorKey() : null,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: <String, WidgetBuilder>{});
  }
}
