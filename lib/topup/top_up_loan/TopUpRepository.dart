import 'package:choice/network/requestbean/TopUpRequest.dart';
import 'package:choice/network/responsebean/TopUpResponse.dart';
import 'package:choice/topup/top_up_loan/TopUpDao.dart';

class TopUpRepository{

  final topUpDao = TopUpDao();

  Future<TopUpResponse>submitTopUp(TopUpRequest topUpRequest) => topUpDao.submitTopUp(topUpRequest);
}