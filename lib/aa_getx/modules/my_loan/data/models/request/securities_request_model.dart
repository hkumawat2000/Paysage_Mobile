import 'package:lms/aa_getx/modules/my_loan/domain/entities/request/securities_request_entity.dart';

class SecuritiesRequestModel {
  String? lender;
  String? level;
  String? demat;

  SecuritiesRequestModel({this.lender, this.level, this.demat});

  SecuritiesRequestModel.fromJson(Map<String, dynamic> json) {
    lender = json['lender'];
    level = json['level'];
    demat = json['demat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lender'] = this.lender;
    data['level'] = this.level;
    data['demat'] = this.demat;
    return data;
  }

  SecuritiesRequestEntity toEntity() =>
      SecuritiesRequestEntity(
        lender: lender,
        level: level,
        demat: demat,
      );

  factory SecuritiesRequestModel.fromEntity(SecuritiesRequestEntity securitiesRequestEntity) {
    return SecuritiesRequestModel(
      lender: securitiesRequestEntity.lender != null ? securitiesRequestEntity.lender as String : null,
      level: securitiesRequestEntity.level != null ? securitiesRequestEntity.level as String : null,
      demat: securitiesRequestEntity.demat != null ? securitiesRequestEntity.demat as String : null,
    );
  }
}