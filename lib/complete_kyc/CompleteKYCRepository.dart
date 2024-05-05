import 'package:choice/complete_kyc/CompleteKYCDao.dart';
import 'package:choice/network/requestbean/ConsentDetailRequestBean.dart';
import 'package:choice/network/requestbean/UserKYCRequest.dart';
import 'package:choice/network/responsebean/CkycDownloadResponse.dart';
import 'package:choice/network/responsebean/CkycSearchResponse.dart';
import 'package:choice/network/responsebean/ConsentDetailResponseBean.dart';
import 'package:choice/network/responsebean/PinCodeResponseBean.dart';
import 'package:choice/network/responsebean/UserCompleteKYCResponseBean.dart';
import 'package:choice/network/responsebean/UserKYCResponse.dart';


class CompleteKYCRepository {
  final completeKYCDao = CompleteKYCDao();

  Future<UserCompleteKYCResponseBean> saveUserKYC(UserKYCRequest userKYCRequest) =>
      completeKYCDao.saveUserKYC(userKYCRequest);

  Future<UserKYCResponseBean> editUserKYC(String userName, String userAddress, String userId) =>
      completeKYCDao.editUserKYC(userName,userAddress,userId);

  Future<CkycSearchResponse> getCKYC(panCard, acceptTerms) => completeKYCDao.getCKYC(panCard, acceptTerms);

  Future<CkycDownloadResponse> getDownloadApi(panCard, dob, ckycNo) => completeKYCDao.getDownloadApi(panCard, dob, ckycNo);

  Future<PinCodeResponseBean> getPinCodeDetails(String pinCode) => completeKYCDao.getPinCodeDetails(pinCode);

  Future<ConsentDetailResponseBean> consentDetails(ConsentDetailRequestBean consentDetailRequestBean) => completeKYCDao.consentDetails(consentDetailRequestBean);

  // Future<ConsentDetailResponse> getConsentInfo(ckycName, acceptTerms, addressList) => completeKYCDao.getConsentInfo(ckycName, acceptTerms, addressList);
}