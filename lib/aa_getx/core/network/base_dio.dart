import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:lms/FlavorConfig.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/alice.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

mixin BaseDio {
  //Get base dio for all api
  Future<Dio> getBaseDio() async {
    Preferences preferences = new Preferences();
    String token = await preferences.getToken();
    String? dummyUserNumber = await preferences.getDummyUserMobile();
    String baseURL = "";
    if (dummyUserNumber == null) {
      baseURL = await getBaseUrl();
    } else {
      var dummyAccountList = await preferences.getDummyAccountList();
      for( int i = 0; i < dummyAccountList.length; i++){
        if(dummyAccountList[i] == dummyUserNumber){
          baseURL = Constants.demoKavim;
          break;
        }
        baseURL = await getBaseUrl();
      }
    }
    preferences.setBaseURL(baseURL);
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: Duration(milliseconds: Constants.connectionTimeOut),
      responseType: ResponseType.json,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token
      },
    );

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = new PersistCookieJar(ignoreExpires: true, storage: FileStorage(tempPath +"/.cookies/"));
    Dio dio = new Dio(options);
    dio.interceptors.add(CookieManager(cj));
    dio.interceptors.add(LogInterceptor(
      request: FlavorConfig.instance.flavor == Flavor.PROD ? false : true,
      requestHeader: FlavorConfig.instance.flavor == Flavor.PROD ? false : true,
      requestBody: FlavorConfig.instance.flavor == Flavor.PROD ? false : true,
      responseHeader: FlavorConfig.instance.flavor == Flavor.PROD ? false : true,
      responseBody: FlavorConfig.instance.flavor == Flavor.PROD ? false : true,
    ));
    dio.interceptors.add(alice.getDioInterceptor());
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options,handler){
        print("app request data ${options.data}");
        return handler.next(options);
      },
      onResponse: (response,handler){
        if (kDebugMode) {
          print("app response data ${response.data}");
        }
        return handler.next(response);
    },
      onError: (DioException e, handler){
        if (kDebugMode) {
          print("app error data $e");
        }
        ErrorEntity eInfo = createErrorEntity(e);
        onError(eInfo);
        return handler.next(e);
      }
    ));
    return dio;
  }

  // get base dio for pass version and platform in headers
  Future<Dio> getBaseDioVersionPlatform() async {
    Preferences preferences = new Preferences();
    String? deviceInfo = await getDeviceInfo();
    String token = await preferences.getToken();
    String version = await Utility.getVersionInfo();
    String? dummyUserNumber = await preferences.getDummyUserMobile();
    String baseURL = "";
    if (dummyUserNumber == null) {
      baseURL = await getBaseUrl();
    } else {
      var dummyAccountList = await preferences.getDummyAccountList();
      for (int i = 0; i < dummyAccountList.length; i++) {
        if (dummyAccountList[i] == dummyUserNumber) {
          baseURL = Constants.oldUrlUat;
          break;
        }
        baseURL = await getBaseUrl();
      }
    }
    preferences.setBaseURL(baseURL);
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      connectTimeout: Duration(milliseconds: Constants.connectionTimeOut),
      responseType: ResponseType.json,
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: token,
        ParametersConstants.appVersion: version,
        ParametersConstants.platform: deviceInfo
      },
    );
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = new PersistCookieJar(ignoreExpires: true, storage: FileStorage(tempPath +"/.cookies/"));
    Dio dio = new Dio(options);
    dio.interceptors.add(CookieManager(cj));
    dio.interceptors.add(LogInterceptor(
      request: FlavorConfig.instance.flavor == Flavor.PROD ? false : true,
      requestHeader: FlavorConfig.instance.flavor == Flavor.PROD ? false : true,
      requestBody: FlavorConfig.instance.flavor == Flavor.PROD ? false : true,
      responseHeader: FlavorConfig.instance.flavor == Flavor.PROD ? false : true,
      responseBody: FlavorConfig.instance.flavor == Flavor.PROD ? false : true
    ));
    return dio;
  }

  //Get base dio for razorpay payment auth
  Future<Dio> getBaseDioAuth() async {
    Preferences preferences = new Preferences();
    String? baseURL = await preferences.getBaseURL();
    String username;
    String password;
    if (baseURL == Constants.baseUrlProd) {
      username = 'rzp_live_55JW5NYsUIguyM';
      password = 'J1px4sH9cxxdbY1SfBgIOly0';
    } else {
      username = 'rzp_test_PWqvSLj4rnBOaG';
      password = 'LIegmcvKBxxcxRqiV0H4sWmq';
    }
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    BaseOptions options = BaseOptions(
      baseUrl: Constants.payment,
      connectTimeout: Duration(milliseconds: Constants.connectionTimeOut),
      responseType: ResponseType.json,
      headers: <String, String>{'authorization': basicAuth},
    );
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = new PersistCookieJar(ignoreExpires: true, storage: FileStorage(tempPath +"/.cookies/"));
    Dio dio = new Dio(options);
    dio.interceptors.add(CookieManager(cj));
    dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(alice.getDioInterceptor());
    return dio;
  }

  //To get base URL
  Future<String> getBaseUrl() async {
    String baseURL = "";
    switch (FlavorConfig.instance.flavor) {
      case Flavor.PROD:
        baseURL = Constants.demoKavim;
        break;
      case Flavor.QA:
        baseURL = Constants.demoKavim;
        break;
      case Flavor.UAT:
        baseURL = Constants.demoKavim;
        break;
      case Flavor.DEV:
        baseURL = Constants.demoKavim;
        break;
      default:
        baseURL = Constants.oldUrlUat;
        break;
    }
    return baseURL;
  }
}
