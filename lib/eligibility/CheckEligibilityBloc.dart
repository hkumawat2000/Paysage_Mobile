import 'dart:async';

import 'package:choice/Eligibility/CheckEligibilityRepository.dart';
import 'package:choice/network/responsebean/CheckEligibilityResponseBean.dart';

class CheckEligibilityBloc {
  final checkEligibilityRepository = CheckEligibilityRepository();

  final _eligibilityController = StreamController<List<EligibilityData>>.broadcast();

  get eligibilityList => _eligibilityController.stream;

  Future<CheckEligibilityResponseBean> getEligibility(String lender, String searchData) async {
    CheckEligibilityResponseBean dropDownResponseModel =
        await checkEligibilityRepository.getEligibility(lender,searchData);
    if (dropDownResponseModel.isSuccessFull!) {
      _eligibilityController.sink.add(dropDownResponseModel.eligibilityData!);
    } else {
      _eligibilityController.sink.addError(dropDownResponseModel.errorMessage!);
    }
    return dropDownResponseModel;
  }

  Future<List<EligibilityData>> removeEligibilityList(List<EligibilityData> approvedList, EligibilityData data) async {
    List<EligibilityData> list = approvedList;
    list.removeWhere((element) => element.securityName == data.securityName);
    _eligibilityController.sink.add(list);
    return list;
  }

  Future<List<EligibilityData>> addEligibilityList(List<EligibilityData> approvedList, EligibilityData data) async {
    List<EligibilityData> list = approvedList;
    list.insert(0, data);
    _eligibilityController.sink.add(list);
    return list;
  }

  Future<CheckEligibilityResponseBean> getEligibilityForSearch(String lender, String searchData, List<EligibilityData> selectedList) async {
    CheckEligibilityResponseBean dropDownResponseModel = await checkEligibilityRepository.getEligibility(lender,searchData);
    if (dropDownResponseModel.isSuccessFull!) {
      for(int i=0; i<selectedList.length; i++) {
        dropDownResponseModel.eligibilityData!.removeWhere((element) => element.securityName == selectedList[i].securityName);
      }
      _eligibilityController.sink.add(dropDownResponseModel.eligibilityData!);
    } else {
      _eligibilityController.sink.addError(dropDownResponseModel.errorMessage!);
    }
    return dropDownResponseModel;
  }

  Future<CheckEligibilityResponseBean> getEligibilityWithKYC(String lender, String searchData, List<EligibilityData> selectedList) async {
    CheckEligibilityResponseBean dropDownResponseModel =
        await checkEligibilityRepository.getEligibilityWithKYC(lender,searchData);
    if (dropDownResponseModel.isSuccessFull!) {
      for(int i=0; i<selectedList.length; i++) {
        dropDownResponseModel.eligibilityData!.removeWhere((element) => element.securityName == selectedList[i].securityName);
      }
      _eligibilityController.sink.add(dropDownResponseModel.eligibilityData!);
    } else {
      _eligibilityController.sink.addError(dropDownResponseModel.errorMessage!);
    }
    return dropDownResponseModel;
  }

  Future<List<EligibilityData>> getEligibilityWithKYCForSearch(List<EligibilityData> list, List<EligibilityData> selectedList) async {
    List<EligibilityData> searchList = list;
    for(int i=0; i<selectedList.length; i++){
      searchList.removeWhere((element) => element.securityName == selectedList[i].securityName);
    }
    _eligibilityController.sink.add(searchList);
    return searchList;
  }

  void dispose() {
    _eligibilityController.close();
  }
}
