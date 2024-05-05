import 'package:choice/network/requestbean/UnpledgeRequestBean.dart';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/UnpledgeDetailsResponse.dart';
import 'package:choice/network/responsebean/UnpledgeRequestResponse.dart';
import 'package:choice/unpledge/UnpledgeRepository.dart';

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