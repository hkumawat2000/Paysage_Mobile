import 'package:choice/network/requestbean/DematDetailNewRequest.dart';
import 'package:choice/network/requestbean/DematDetailRequest.dart';
import 'package:choice/network/responsebean/DematAcResponse.dart';

import 'DematDetailsDao.dart';
import 'DematDetailsResponse.dart';

class DematDetailsRepository{
  final dematDetailsDao = DematDetailsDao();

  Future<DematDetailsResponse> dematDetails(DematDetailNewRequest dematDetailNewRequest) => dematDetailsDao.dematDetails(dematDetailNewRequest);

  Future<DematAcResponse> dematAcDetails() => dematDetailsDao.dematAcDetails();
}