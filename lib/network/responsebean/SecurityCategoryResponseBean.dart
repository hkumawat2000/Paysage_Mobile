import 'dart:convert';

import 'package:choice/network/ModelWrapper.dart';

class SecurityCategoryResponseBean extends ModelWrapper<List<SecurityCategoryModel>> {
  SecurityCategoryResponseBean.fromJson(Map<dynamic, dynamic> parsedJson) {
    List<SecurityCategoryModel> temp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      SecurityCategoryModel securityCategoryModel = SecurityCategoryModel(parsedJson['data'][i]);
      temp.add(securityCategoryModel);
    }
    var map = {"name": "All"};
    SecurityCategoryModel securityCategoryModel = SecurityCategoryModel(map);
    temp.insert(0, securityCategoryModel);
    data = temp;
  }

  SecurityCategoryResponseBean();
}

class SecurityCategoryModel {
  String? name;

  SecurityCategoryModel(jsonMap) {
    this.name = jsonMap['name'];
  }
}
