import 'dart:async';

import 'package:lms/network/requestbean/MFSchemeRequest.dart';
import 'package:lms/network/responsebean/MFSchemeResponse.dart';
import 'package:lms/pledge_eligibility/mutual_fund/MFSchemeRepository.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class MFSchemeBloc {
  MFSchemeBloc();

  final mFSchemeRepository = MFSchemeRepository();
  final schemeController = StreamController<MFSchemeResponse>.broadcast();
  get getSchemes => schemeController.stream;

  Future<MFSchemeResponse> getSchemesList(MFSchemeRequest requestBean) async {
    MFSchemeResponse wrapper =
        await mFSchemeRepository.getSchemesList(requestBean);
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
      schemeController.sink.add(wrapper);
    } else {
      printLog("-----FAIL-----");
      if (wrapper.errorCode == 403) {
        schemeController.sink.addError(wrapper.errorCode.toString());
      }
    }
    return wrapper;
  }


  schemeSearch(List<SchemesList> schemesListFilter, String query) async {

    if (query.isNotEmpty) {
      List<SchemesList> dummyListData = <SchemesList>[];
      schemesListFilter.forEach((item) {
        if (item.schemeName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      schemeController.sink.add(MFSchemeResponse(mFSchemeData: MFSchemeData(schemesList: dummyListData)));
    } else {
      schemeController.sink.add(MFSchemeResponse(mFSchemeData: MFSchemeData(schemesList: schemesListFilter)));
    }
  }
}
