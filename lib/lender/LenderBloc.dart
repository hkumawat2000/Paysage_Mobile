import 'dart:async';

import 'package:lms/lender/LenderRepository.dart';
import 'package:lms/network/responsebean/LenderResponseBean.dart';

class LenderBloc {
  final lenderRepository = LenderRepository();

  final _dropDownLenderController = StreamController<List<LenderData>>.broadcast();

  get dropDownLenderList => _dropDownLenderController.stream;

  Future<LenderResponseBean> getLenders() async {
    LenderResponseBean dropDownResponseModel = await lenderRepository.getLenders();
    if (dropDownResponseModel.isSuccessFull!) {
      _dropDownLenderController.sink.add(dropDownResponseModel.lenderData!);
    } else {
      if (dropDownResponseModel.errorCode == 403) {
        _dropDownLenderController.sink.addError(dropDownResponseModel.errorCode.toString());
      } else {
        _dropDownLenderController.sink.addError(dropDownResponseModel.errorMessage!);
      }
    }
    return dropDownResponseModel;
  }

  void dispose() {
    _dropDownLenderController.close();
  }
}
