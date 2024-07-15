// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/login/domain/entity/get_terms_and_privacy_response_entity.dart';
import 'package:lms/network/ModelWrapper.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class GetTermsandPrivacyResponse extends ModelWrapper<TermsOfUseData> {
  String? message;
  TermsOfUseData? termsOfUseData;

  GetTermsandPrivacyResponse({this.message, this.termsOfUseData});

  GetTermsandPrivacyResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    termsOfUseData = json['data'] != null ? new TermsOfUseData.fromJson(json['data']) : null;
    data = termsOfUseData;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  GetTermsandPrivacyResponseEntity toEntity() =>
  GetTermsandPrivacyResponseEntity(
      message: message,
      termsOfUseData: termsOfUseData?.toEntity(),
  
  );

  factory GetTermsandPrivacyResponse.fromEntity(GetTermsandPrivacyResponseEntity getTermsandPrivacyResponse) {
    return GetTermsandPrivacyResponse(
      message: getTermsandPrivacyResponse.message != null ? getTermsandPrivacyResponse.message as String : null,
      termsOfUseData: getTermsandPrivacyResponse.termsOfUseData != null ? TermsOfUseData.fromEntity(getTermsandPrivacyResponse.termsOfUseData as TermsOfUseDataEntity) : null,
    );
  }
}

class TermsOfUseData {
  String? termsOfUseUrl;
  String? privacyPolicyUrl;
  List<String>? dummyAccounts;

  TermsOfUseData({this.termsOfUseUrl, this.privacyPolicyUrl, this.dummyAccounts});

  TermsOfUseData.fromJson(Map<String, dynamic> json) {
    termsOfUseUrl = json['terms_of_use_url'];
    privacyPolicyUrl = json['privacy_policy_url'];
    try {
      dummyAccounts = json['dummy_accounts'].cast<String>();
    } catch (e, s) {
      printLog(s.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['terms_of_use_url'] = this.termsOfUseUrl;
    data['privacy_policy_url'] = this.privacyPolicyUrl;
    try {
      data['dummy_accounts'] = this.dummyAccounts;
    } catch (e, s) {
      printLog(s.toString());
    }
    return data;
  }

  TermsOfUseDataEntity toEntity() =>
  TermsOfUseDataEntity(
      termsOfUseUrl: termsOfUseUrl,
      privacyPolicyUrl: privacyPolicyUrl,
      dummyAccounts: dummyAccounts,
  
  );

  factory TermsOfUseData.fromEntity(TermsOfUseDataEntity termsOfUseData) {
    return TermsOfUseData(
      termsOfUseUrl: termsOfUseData.termsOfUseUrl != null ? termsOfUseData.termsOfUseUrl as String : null,
      privacyPolicyUrl: termsOfUseData.privacyPolicyUrl != null ? termsOfUseData.privacyPolicyUrl as String : null,
      dummyAccounts: termsOfUseData.dummyAccounts != null ? List<String>.from(termsOfUseData.dummyAccounts as List<String>) : null,
    );
  }
}
