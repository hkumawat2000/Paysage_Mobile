import 'dart:convert';

import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_on_demand_request_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CibilOnDemandRequestModel {
  String? hitID;
  
  CibilOnDemandRequestModel({
    this.hitID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hit_id': hitID,
    };
  }

  factory CibilOnDemandRequestModel.fromMap(Map<String, dynamic> map) {
    return CibilOnDemandRequestModel(
      hitID: map['hit_id'] != null ? map['hit_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CibilOnDemandRequestModel.fromJson(String source) => CibilOnDemandRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CibilOnDemandRequestEntity toEntity() =>
  CibilOnDemandRequestEntity(
      hitID: hitID,
  
  );

  factory CibilOnDemandRequestModel.fromEntity(CibilOnDemandRequestEntity cibilOnDemandRequestEntity) {
    return CibilOnDemandRequestModel(
      hitID: cibilOnDemandRequestEntity.hitID != null ? cibilOnDemandRequestEntity.hitID as String : null,
    );
  }
}
