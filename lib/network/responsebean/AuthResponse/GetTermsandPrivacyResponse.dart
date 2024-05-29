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
}