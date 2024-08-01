// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/data/models/search_data_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_search_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/search_data_response_entity.dart';

class KYCSearchResponseModel {
  String? message;
  SearchDataResponseModel? searchData;

  KYCSearchResponseModel({this.message, this.searchData});

  KYCSearchResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    searchData = json['data'] != null ? new SearchDataResponseModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.searchData != null) {
      data['data'] = this.searchData!.toJson();
    }
    return data;
  }
  
  KYCSearchResponseEntity toEntity() =>
  KYCSearchResponseEntity(
      message: message,
      searchData: searchData?.toEntity(),
  );

  factory KYCSearchResponseModel.fromEntity(KYCSearchResponseEntity kycsearchResponseEntity) {
    return KYCSearchResponseModel(
      message: kycsearchResponseEntity.message != null ? kycsearchResponseEntity.message as String : null,
      searchData: kycsearchResponseEntity.searchData != null ? SearchDataResponseModel.fromEntity(kycsearchResponseEntity.searchData as SearchDataResponseEntity) : null,
    );
  }
}


