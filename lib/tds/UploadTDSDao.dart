// import 'dart:io';
//
// import 'package:lms/network/responsebean/TDSListResponseBean.dart';
// import 'package:lms/network/responsebean/UploadTDSDaoResponseBean.dart';
// import 'package:lms/util/base_dio.dart';
// import 'package:lms/util/constants.dart';
// import 'package:lms/util/strings.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:dio/dio.dart';
//
// class UploadTDSDao with BaseDio {
//   int limitPageLength = 20;
//   Future<UploadTDSResponseBean> uploadTDS(String tdsAmount,String year,File tdsFileUpload) async {
//     Dio dio = await getBaseDio();
//     UploadTDSResponseBean wrapper = UploadTDSResponseBean();
//     try {
//       FormData formData = FormData.fromMap({
//         "tds_amount": tdsAmount, "year": year, "tds_file_upload": await MultipartFile.fromFile(tdsFileUpload.path, filename: "TDS")
//     });
//       Response response = await dio.post(Constants.uploadTds,
//           data: formData);
//       if (response.statusCode == 200) {
//         wrapper = UploadTDSResponseBean.fromJson(response.data);
//         wrapper.isSuccessFull = true;
//       } else if (response.statusCode == 401) {
//         wrapper.isSuccessFull = false;
//       } else if (response.statusCode == 504) {
//         wrapper.isSuccessFull = false;
//       } else {
//         wrapper.isSuccessFull = false;
//       }
//     } on DioError catch (e) {
//       if (e.response == null) {
//         wrapper.isSuccessFull = false;
//         wrapper.errorMessage = Strings.server_error_message;
//         wrapper.errorCode = Constants.noInternet;
//       } else {
//         wrapper.isSuccessFull = false;
//         wrapper.errorCode = e.response!.statusCode!;
//         wrapper.errorMessage = e.response!.statusMessage!;
//       }
//     }
//     return wrapper;
//   }
//
//   Future<TDSListResponseBean> loadMoreTDS() async {
//     Dio dio = await getBaseDio();
//     TDSListResponseBean wrapper = TDSListResponseBean();
//     limitPageLength += 20;
//     try {
//       Response response = await dio.get(Constants.getTds,
//       queryParameters: {
//           "fields": '["*"]',
//           //"filters": '$filterValue',
//           //"limit_start": '100',
//           "limit_page_length": '200',
//         },
//       );
//       if (response.statusCode == 200) {
//         printLog("response $response");
//         try {
//           wrapper = TDSListResponseBean.fromJson(response.data);
//           wrapper.isSuccessFull = true;
//           printLog("status security:: ${wrapper.data}");
//           // if (response.statusCode == 200) {
//           //   wrapper.isSuccessFull = true;
//           // } else if (response.statusCode == 422) {
//           //   wrapper.errorCode = 422;
//           //   wrapper.isSuccessFull = false;
//           // } else if (response.statusCode == 502) {
//           //   wrapper.isSuccessFull = false;
//           //   wrapper.errorCode = 502;
//           // }
//         } catch (e) {
//           printLog("crasssshhh==>$e");
//           wrapper.isSuccessFull = false;
//         }
//       } else {
// //        wrapper.errorCode = 422;
//         //wrapper.isSuccessFull = false;
//       }
//     } on DioError catch (e) {
//       if (e.response == null) {
//         wrapper.isSuccessFull = false;
//         wrapper.errorMessage = Strings.server_error_message;
//         wrapper.errorCode = Constants.noInternet;
//       } else {
//         wrapper.isSuccessFull = false;
//         wrapper.errorCode = e.response!.statusCode;
//         wrapper.errorMessage = e.response!.statusMessage;
//       }
//     }
//     return wrapper;
//   }
//
//   Future<TDSListResponseBean> getTDS() async {
//     Dio dio = await getBaseDio();
//     TDSListResponseBean wrapper = TDSListResponseBean();
//     limitPageLength += 20;
//     try {
//       Response response = await dio.get(Constants.getTds,
//       queryParameters: {
//           "fields": '["*"]',
//         },
//       );
//       if (response.statusCode == 200) {
//         printLog("response $response");
//         try {
//           wrapper = TDSListResponseBean.fromJson(response.data);
//           wrapper.isSuccessFull = true;
//           printLog("status security:: ${wrapper.data}");
//           // if (response.statusCode == 200) {
//           //   wrapper.isSuccessFull = true;
//           // } else if (response.statusCode == 422) {
//           //   wrapper.errorCode = 422;
//           //   wrapper.isSuccessFull = false;
//           // } else if (response.statusCode == 502) {
//           //   wrapper.isSuccessFull = false;
//           //   wrapper.errorCode = 502;
//           // }
//         } catch (e) {
//           printLog("crasssshhh==>$e");
//           wrapper.isSuccessFull = false;
//         }
//       } else {
// //        wrapper.errorCode = 422;
//         //wrapper.isSuccessFull = false;
//       }
//     } on DioError catch (e) {
//       if (e.response == null) {
//         wrapper.isSuccessFull = false;
//         wrapper.errorMessage = Strings.server_error_message;
//         wrapper.errorCode = Constants.noInternet;
//       } else {
//         wrapper.isSuccessFull = false;
//         wrapper.errorCode = e.response!.statusCode;
//         wrapper.errorMessage = e.response!.statusMessage;
//       }
//     }
//     return wrapper;
//   }
//   }