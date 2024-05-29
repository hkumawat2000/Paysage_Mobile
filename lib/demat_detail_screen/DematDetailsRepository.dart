import 'package:lms/network/requestbean/DematDetailNewRequest.dart';
import 'package:lms/network/requestbean/DematDetailRequest.dart';
import 'package:lms/network/responsebean/DematAcResponse.dart';

import 'DematDetailsDao.dart';
import 'DematDetailsResponse.dart';

class DematDetailsRepository{
  final dematDetailsDao = DematDetailsDao();

  Future<DematDetailsResponse> dematDetails(DematDetailNewRequest dematDetailNewRequest) => dematDetailsDao.dematDetails(dematDetailNewRequest);

  Future<DematAcResponse> dematAcDetails() => dematDetailsDao.dematAcDetails();
}