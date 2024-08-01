// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/domain/entities/search_data_response_entity.dart';

class SearchDataResponseModel {
  String? ckycNo;

  SearchDataResponseModel({this.ckycNo});

  SearchDataResponseModel.fromJson(Map<String, dynamic> json) {
    ckycNo = json['ckyc_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ckyc_no'] = this.ckycNo;
    return data;
  }

  SearchDataResponseEntity toEntity() =>
  SearchDataResponseEntity(
      ckycNo: ckycNo,
  
  );

  factory SearchDataResponseModel.fromEntity(SearchDataResponseEntity searchDataResponseEntity) {
    return SearchDataResponseModel(
      ckycNo: searchDataResponseEntity.ckycNo != null ? searchDataResponseEntity.ckycNo as String : null,
    );
  }
}
