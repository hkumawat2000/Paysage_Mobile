  import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/FlavorConfig.dart';
import 'package:lms/aa_getx/config/initial_bindings.dart';
import 'package:lms/aa_getx/core/network/alice.dart';
import 'package:lms/aa_getx/core/network/global_network_controller.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/MyHttp.dart';
import 'package:lms/util/strings.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'config/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   /// Global Network Controller
  DependencyInjection.init();

  /// Config the flavor
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

  ///Firebase initializer
  await Firebase.initializeApp();

  /// Firebase Crashlytics
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  HttpOverrides.global = MyHttpOverrides(); //for badCertificateCallback

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colorBg,
      statusBarIconBrightness: Brightness.dark // status bar color
  ));

  runApp(Root());
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return OverlaySupport.global(
      child: GetMaterialApp(
         builder: (context, child) {
          // Execute code during app initialization
          DependencyInjection.init(); // Initialize dependencies
          NetworkController networkController = Get.find();
          networkController.checkConnection(); // Check connection status
          return child!;
        },
        title: Strings.lms,
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        theme: ThemeData(
          fontFamily: 'Montserrat',
        ),
        navigatorKey: aliceRef.getNavigatorKey(),
        initialBinding: InitialBinding(),
        initialRoute: splashView,
        getPages: routes,
      ),
    );
  }
}
