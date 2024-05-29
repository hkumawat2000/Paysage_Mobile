import 'package:lms/network/requestbean/TopUpRequest.dart';
import 'package:lms/network/responsebean/TopUpResponse.dart';
import 'package:lms/topup/top_up_loan/TopUpDao.dart';

class TopUpRepository{

  final topUpDao = TopUpDao();

  Future<TopUpResponse>submitTopUp(TopUpRequest topUpRequest) => topUpDao.submitTopUp(topUpRequest);
}