import 'package:lms/network/requestbean/UnpledgeRequestBean.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/UnpledgeDetailsResponse.dart';
import 'package:lms/network/responsebean/UnpledgeRequestResponse.dart';
import 'package:lms/unpledge/UnpledgeRepository.dart';

class UnpledgeBloc {
  UnpledgeBloc();

  final unpledgeRepository = UnpledgeRepository();

  Future<UnpledgeDetailsResponse> unpledgeDetails(loanName) async {
    UnpledgeDetailsResponse wrapper = await unpledgeRepository.unpledgeDetails(loanName);
    return wrapper;
  }


  Future<CommonResponse> requestUnpledgeOTP() async {
    CommonResponse wrapper = await unpledgeRepository.requestUnpledgeOTP();
    return wrapper;
  }


  Future<UnpledgeRequestResponse> unpledgeRequest(UnpledgeRequestBean unpledgeRequestBean) async {
    UnpledgeRequestResponse wrapper = await unpledgeRepository.unpledgeRequest(unpledgeRequestBean);
    return wrapper;
  }
}