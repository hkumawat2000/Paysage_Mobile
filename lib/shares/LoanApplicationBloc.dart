import 'dart:async';

import 'package:lms/network/requestbean/MyCartRequestBean.dart';
import 'package:lms/network/requestbean/SecuritiesRequest.dart';
import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/ESignResponse.dart';
import 'package:lms/network/responsebean/LoanApplicationResponseBean.dart';
import 'package:lms/network/responsebean/MyCartResponseBean.dart';
import 'package:lms/network/responsebean/ProcessCartResponse.dart';
import 'package:lms/network/responsebean/SecuritiesResponseBean.dart';
import 'package:lms/network/responsebean/UserInformation.dart';
import 'package:lms/shares/LoanApplicationRepository.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:rxdart/rxdart.dart';

class LoanApplicationBloc {
  final loanApplicationRepository = LoanApplicationRepository();
  final loanAppController = StreamController<LoanApplicationData>.broadcast();

  get loanApplication => loanAppController.stream;
  int? totalCount;
  int? listCount;
  final _listUserSecController = StreamController<List<ShareListData>>.broadcast();
  final _listMyCartController = StreamController<MyCartData>.broadcast();
  final _listUserInfoController = StreamController<UserInformation>.broadcast();

  final _isLoadMoreComplete = BehaviorSubject<bool>();

  get listUserSecurity => _listUserSecController.stream;

  get loadMore => _isLoadMoreComplete.stream;

  get myCartList => _listMyCartController.stream;

  PublishSubject<bool> get _progressStateSubject => new PublishSubject();

  //the listener are streaming on changes
  get progressStateStream => _progressStateSubject.stream;

  //to change your progress state
  // void changeProgressState({bool? state}) => _progressStateSubject.sink.add(state!);

  Future<ProcessCartResponse> createLoanApplication(cartName, otp, fileId, pledgorBoid) async {
    ProcessCartResponse wrapper = await loanApplicationRepository.createLoanApplication(cartName, otp, fileId, pledgorBoid);
    return wrapper;
  }

  Future<ProcessCartResponse> mfCreateLoanApplication(cartName, otp) async {
    ProcessCartResponse wrapper = await loanApplicationRepository.mfCreateLoanApplication(cartName, otp);
    return wrapper;
  }

  Future<CommonResponse> createLoanRenewalApplication(loanRenewalName, otp) async {
    CommonResponse wrapper = await loanApplicationRepository.createLoanRenewalApplication(loanRenewalName, otp);
    return wrapper;
  }


  final schemeControllerList = StreamController<SecuritiesResponseBean>.broadcast();
  get getSchemesList => schemeControllerList.stream;

  Future<SecuritiesResponseBean> getSecurities(SecuritiesRequest securitiesRequest) async {
    SecuritiesResponseBean wrapper =
    await loanApplicationRepository.getSecurities(securitiesRequest);
    if (wrapper.isSuccessFull!) {
      schemeControllerList.sink.add(wrapper);
    } else {
      schemeControllerList.sink.addError(wrapper.errorCode.toString());
    }
    return wrapper;
  }

  securitySearch(List<SecuritiesListData> securityListFilter, String query, forSearch) async {
    if (query.isNotEmpty) {
      List<SecuritiesListData> dummyListData = <SecuritiesListData>[];
      securityListFilter.forEach((item) {
        if (item.scripName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      schemeControllerList.sink.add(SecuritiesResponseBean(securityData: SecurityData(securities: dummyListData)));
    } else {
      schemeControllerList.sink.add(SecuritiesResponseBean(securityData: SecurityData(securities: securityListFilter)));
    }
  }


  Future<MyCartResponseBean> myCart(MyCartRequestBean requestBean) async {
    MyCartResponseBean wrapper = await loanApplicationRepository.myCart(requestBean);
    if (wrapper.isSuccessFull!) {
      _listMyCartController.sink.add(wrapper.data!);
    }
    return wrapper;
  }

  Future<CommonResponse> pledgeOTP(instrumentType) async {
    CommonResponse wrapper = await loanApplicationRepository.pledgeOTP(instrumentType);
    if (wrapper.isSuccessFull!) {
    } else {
      if (wrapper.errorCode == 422) {
        Utility.showToastMessage(Strings.fail);
      }
    }
    return wrapper;
  }

  Future<CommonResponse> loanRenewalOTP(loanRenewalName) async {
    CommonResponse wrapper = await loanApplicationRepository.loanRenewalOTP(loanRenewalName);
    return wrapper;
  }

  Future<ESignResponse> esignVerification(loanName) async {
    ESignResponse wrapper = await loanApplicationRepository.esignVerification(loanName);
    return wrapper;
  }

  Future<CommonResponse> esignSuccess(loanName, fileId) async {
    CommonResponse wrapper = await loanApplicationRepository.esignSuccess(loanName,fileId);
    return wrapper;
  }

  Future<CommonResponse> createTopUp(loanName, fileId) async {
    CommonResponse wrapper = await loanApplicationRepository.createTopUp(loanName, fileId);
    return wrapper;
  }

  dispose() {
    loanAppController.close();
    _listMyCartController.close();
    _listUserSecController.close();
    _listUserInfoController.close();
    _isLoadMoreComplete.close();
    _isLoadMoreComplete.drain();
  }
}
