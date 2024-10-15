// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/isin_details_request_entity.dart';

class IsinDetailsRequestModel {
  String? isin;

  IsinDetailsRequestModel({this.isin});

  IsinDetailsRequestModel.fromJson(Map<String, dynamic> json) {
    isin = json['isin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isin'] = this.isin;
    return data;
  }

  factory IsinDetailsRequestModel.fromEntity(IsinDetailsRequestEntity isinDetailsRequestEntity) {
    return IsinDetailsRequestModel(
      isin: isinDetailsRequestEntity.isin != null ? isinDetailsRequestEntity.isin as String : null,
    );
  }
}
