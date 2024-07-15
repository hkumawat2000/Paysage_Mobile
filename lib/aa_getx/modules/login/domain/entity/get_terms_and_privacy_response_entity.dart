
class GetTermsandPrivacyResponseEntity {
  String? message;
  TermsOfUseDataEntity? termsOfUseData;

  GetTermsandPrivacyResponseEntity({this.message, this.termsOfUseData});
}

class TermsOfUseDataEntity {
  String? termsOfUseUrl;
  String? privacyPolicyUrl;
  List<String>? dummyAccounts;

  TermsOfUseDataEntity(
      {this.termsOfUseUrl, this.privacyPolicyUrl, this.dummyAccounts});
}
