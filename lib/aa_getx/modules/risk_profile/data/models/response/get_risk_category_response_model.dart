class GetRiskCategoryResponseModel {
  String? message;
  List<Data>? data;

  GetRiskCategoryResponseModel({this.message, this.data});

  GetRiskCategoryResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? category;
  List<String>? subCategoryList;

  Data({this.category, this.subCategoryList});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    subCategoryList = json['sub category list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['sub category list'] = this.subCategoryList;
    return data;
  }
}
