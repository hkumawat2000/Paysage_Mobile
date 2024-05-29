// import 'dart:io';
//
// import 'package:lms/network/responsebean/TDSListResponseBean.dart';
// import 'package:lms/network/responsebean/UploadTDSDaoResponseBean.dart';
// import 'package:lms/tds/UploadTDSDao.dart';
//
// class UploadTDSRepository {
//   final loanApplicationDao = UploadTDSDao();
//
//   Future<UploadTDSResponseBean> uploadTDS(String tdsAmount,String year,File tdsFileUpload) => loanApplicationDao.uploadTDS(tdsAmount,year,tdsFileUpload);
//
//   Future<TDSListResponseBean> getTDS()=>
//       loanApplicationDao.getTDS();
//
//   Future<TDSListResponseBean> loadMoreTDS()=>
//       loanApplicationDao.loadMoreTDS();
//
// }