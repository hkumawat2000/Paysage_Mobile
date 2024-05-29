import 'dart:async';

import 'package:lms/network/responsebean/TermsConditionResponse.dart';
import 'package:lms/topup/top_up_terms_conditions/TopUpTermsConditionsRepository.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class TopUpTermsConditionsBloc {
  TopUpTermsConditionsBloc();

  final topUpTermsConditionsRepository = TopUpTermsConditionsRepository();
  final tncDataController = StreamController<TermsConditionResponse>.broadcast();

  get tncData => tncDataController.stream;

  Future<TermsConditionResponse> getTopUpTermsCondition(loan_name, topup_amount) async {
    TermsConditionResponse wrapper =
        await topUpTermsConditionsRepository.getTopUpTermsCondition(loan_name, topup_amount);
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
      tncDataController.sink.add(wrapper);
    } else {
      printLog("-----FAIL-----");
    }
    return wrapper;
  }

  dispose() {
    tncDataController.close();
  }
}
