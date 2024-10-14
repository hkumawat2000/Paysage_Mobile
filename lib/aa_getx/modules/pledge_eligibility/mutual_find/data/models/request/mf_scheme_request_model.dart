// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/mf_scheme_request_entity.dart';

class MFSchemeRequestModel {
  String? schemeType;
  String? lender;
  String? level;

  MFSchemeRequestModel(this.schemeType, this.lender, this.level);

  MFSchemeRequestModel.fromJson(Map<String, dynamic> json) {
    schemeType = json['scheme_type'];
    lender = json['lender'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheme_type'] = this.schemeType;
    data['lender'] = this.lender;
    data['level'] = this.level;
    return data;
  }

  factory MFSchemeRequestModel.fromEntity(MFSchemeRequestEntity mfschemeRequestEntity) {
    return MFSchemeRequestModel(
      mfschemeRequestEntity.schemeType != null ? mfschemeRequestEntity.schemeType as String : null,
      mfschemeRequestEntity.lender != null ? mfschemeRequestEntity.lender as String : null,
      mfschemeRequestEntity.level != null ? mfschemeRequestEntity.level as String : null,
    );
  }
}
