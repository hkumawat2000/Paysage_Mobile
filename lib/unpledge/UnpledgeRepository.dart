import 'package:choice/network/requestbean/UnpledgeRequestBean.dart';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/UnpledgeDetailsResponse.dart';
import 'package:choice/network/responsebean/UnpledgeRequestResponse.dart';
import 'package:choice/unpledge/UnpledgeDao.dart';

class UnpledgeRepository{
  final unpledgeDao = UnpledgeDao();

  Future<UnpledgeDetailsResponse> unpledgeDetails(loanName) => unpledgeDao.unpledgeDetails(loanName);

  Future<CommonResponse> requestUnpledgeOTP() => unpledgeDao.requestUnpledgeOTP();

  Future<UnpledgeRequestResponse> unpledgeRequest(UnpledgeRequestBean unpledgeRequestBean) =>
      unpledgeDao.unpledgeRequest(unpledgeRequestBean);

}