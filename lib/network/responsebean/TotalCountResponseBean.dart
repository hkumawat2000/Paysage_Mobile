import 'package:lms/network/ModelWrapper.dart';

class TotalCountResponseBean extends ModelWrapper<List<TotalCountModel>> {
  TotalCountResponseBean.fromJson(Map<String, dynamic> parsedJson) {
    List<TotalCountModel> temp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      TotalCountModel userInfoModel = TotalCountModel(parsedJson['data'][i]);
      temp.add(userInfoModel);
    }
    data = temp;
  }

  TotalCountResponseBean();
}

class TotalCountModel {
  int? totalCount;

  TotalCountModel(jsonMap) {
    this.totalCount = jsonMap['total_count'];
  }
}
