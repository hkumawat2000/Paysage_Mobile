// import 'dart:io';
//
// import 'package:choice/network/responsebean/TDSListResponseBean.dart';
// import 'package:choice/network/responsebean/UploadTDSDaoResponseBean.dart';
// import 'package:choice/tds/UploadTDSDao.dart';
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