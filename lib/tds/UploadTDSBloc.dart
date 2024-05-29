// import 'dart:async';
// import 'dart:io';
//
// import 'package:lms/network/responsebean/TDSListResponseBean.dart';
// import 'package:lms/network/responsebean/UploadTDSDaoResponseBean.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:rxdart/rxdart.dart';
//
// import 'UploadTDSRepository.dart';
//
// class UploadTDSBloc {
//   UploadTDSBloc();
//
//   final uploadTDSRepository = UploadTDSRepository();
//
//   final _tdslistController = StreamController<List<TDS>>.broadcast();
//
//   final _uploadTDSController = StreamController<UploadedData>.broadcast();
//
//   final _isLoadMoreComplete = BehaviorSubject<bool>();
//
//   get tdslist => _tdslistController.stream;
//
//   Future<UploadTDSResponseBean> uploadTDS(String tdsAmount,String year,File tdsFileUpload) async {
//     UploadTDSResponseBean wrapper =
//         await uploadTDSRepository.uploadTDS(tdsAmount,year,tdsFileUpload);
//     if (wrapper.isSuccessFull!) {
//       printLog("-----SUCESS-----");
//       _uploadTDSController.sink.add(wrapper.message!.data!);
//     } else {
//       printLog("-----FAIL-----");
//       _uploadTDSController.sink.addError(wrapper.errorMessage!);
//     }
//     return wrapper;
//   }
//
//   Future<TDSListResponseBean> getTDSList() async {
//     List<TDS> tds = [];
//     TDSListResponseBean wrapper = await uploadTDSRepository.getTDS();
//     if (wrapper.isSuccessFull!) {
//       printLog("-----SUCESS-----");
//
//       tds.addAll(wrapper.data!);
//       _tdslistController.sink.add(tds);
//     } else {
//       printLog("error:${wrapper.errorCode}");
//       if (wrapper.errorCode == 422) {
//         _tdslistController.sink.addError(wrapper.errorMessage!);
//       } else if (wrapper.errorCode == 502) {
//         printLog("-----FAIL-----");
//         _tdslistController.sink.addError(wrapper.errorMessage!);
//       } else {
//         printLog("-----FAIL-----");
//         _tdslistController.sink.addError(wrapper.errorMessage!);
//       }
//     }
//     return wrapper;
//   }
//
//   Future<TDSListResponseBean> loadMoreTDS() async {
//     List<TDS> tds = [];
//     TDSListResponseBean wrapper = await uploadTDSRepository.loadMoreTDS();
//     if (wrapper.isSuccessFull!) {
//       printLog("-----SUCESS-----");
//
//       tds.addAll(wrapper.data!);
//       _tdslistController.sink.add(tds);
//     } else {
//       printLog("error:${wrapper.errorCode}");
//       if (wrapper.errorCode == 422) {
//         _tdslistController.sink.addError(wrapper.errorMessage!);
//       } else if (wrapper.errorCode == 502) {
//         printLog("-----FAIL-----");
//         _tdslistController.sink.addError(wrapper.errorMessage!);
//       } else {
//         printLog("-----FAIL-----");
//         _tdslistController.sink.addError(wrapper.errorMessage!);
//       }
//     }
//     return wrapper;
//   }
//
//   dispose() {
//     _tdslistController.close();
//     _uploadTDSController.close();
//     _isLoadMoreComplete.drain();
//   }
// }