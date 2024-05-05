import 'dart:async';

import 'package:choice/network/requestbean/TermsConditionRequestBean.dart';
import 'package:choice/network/responsebean/TermsConditionResponse.dart';
import 'package:choice/network/responsebean/TncResponseBean.dart';
import 'package:choice/terms_conditions/TnCRepository.dart';
import 'package:choice/widgets/WidgetCommon.dart';

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
