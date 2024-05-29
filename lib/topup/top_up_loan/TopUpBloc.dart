import 'package:lms/network/requestbean/TopUpRequest.dart';
import 'package:lms/network/responsebean/TopUpResponse.dart';
import 'package:lms/topup/top_up_loan/TopUpRepository.dart';

class TopUpBloc {
  final topUpRepository = TopUpRepository();

  Future<TopUpResponse> submitTopUp(TopUpRequest topUpRequest) async {
    TopUpResponse wrapper = await topUpRepository.submitTopUp(topUpRequest);
    return wrapper;
  }
}
