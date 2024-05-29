import 'package:lms/network/requestbean/UnpledgeRequestBean.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/UnpledgeDetailsResponse.dart';
import 'package:lms/network/responsebean/UnpledgeRequestResponse.dart';
import 'package:lms/unpledge/UnpledgeDao.dart';

class UnpledgeRepository{
  final unpledgeDao = UnpledgeDao();

  Future<UnpledgeDetailsResponse> unpledgeDetails(loanName) => unpledgeDao.unpledgeDetails(loanName);

  Future<CommonResponse> requestUnpledgeOTP() => unpledgeDao.requestUnpledgeOTP();

  Future<UnpledgeRequestResponse> unpledgeRequest(UnpledgeRequestBean unpledgeRequestBean) =>
      unpledgeDao.unpledgeRequest(unpledgeRequestBean);

}