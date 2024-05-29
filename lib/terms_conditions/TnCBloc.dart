import 'dart:async';

import 'package:lms/network/requestbean/TermsConditionRequestBean.dart';
import 'package:lms/network/responsebean/TermsConditionResponse.dart';
import 'package:lms/network/responsebean/TncResponseBean.dart';
import 'package:lms/terms_conditions/TnCRepository.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class TnCBloc {
  TnCBloc();

  final tncRepository = TnCRepository();
  final tncListController = StreamController<List<TnCData>>.broadcast();
  final tncDataController = StreamController<TermsConditionResponse>.broadcast();

  get tncList => tncListController.stream;

  get tncData => tncDataController.stream;

  Future<TnCResponseBean> getTncList() async {
    TnCResponseBean wrapper = await tncRepository.getTnCList();
    if (wrapper.isSuccessFull!) {
      tncListController.sink.add(wrapper.data!);
    } else {
      tncListController.sink.addError(wrapper.errorMessage!);
    }
    return wrapper;
  }

  Future<TermsConditionResponse> saveTnCList(TermsConditionRequestBean termsConditionRequestBean) async {
    TermsConditionResponse wrapper = await tncRepository.setTnCList(termsConditionRequestBean);
    if (wrapper.isSuccessFull!) {
      tncDataController.sink.add(wrapper);
    }
    return wrapper;
  }

  dispose() {
    tncListController.close();
    tncDataController.close();
  }
}
