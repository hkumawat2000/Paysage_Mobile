import 'package:lms/network/ModelWrapper.dart';

class TermsConditionResponse extends ModelWrapper<TermsConditionData> {
  String? message;
  TermsConditionData? termsConditionData;

  TermsConditionResponse({this.message, this.termsConditionData});

  TermsConditionResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    termsConditionData =
        json['data'] != null ? new TermsConditionData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.termsConditionData != null) {
      data['data'] = this.termsConditionData!.toJson();
    }
    return data;
  }
}

class TermsConditionData {
  String? tncHtml;
  String? tncHeader;
  String? tncFooter;
  List<String>? tncCheckboxes;
  String? tncFile;

  TermsConditionData(
      { this.tncHtml, this.tncHeader, this.tncFooter, this.tncCheckboxes,this.tncFile});

  TermsConditionData.fromJson(Map<String, dynamic> json) {
    tncHtml = json['tnc_html'];
    tncHeader = json['tnc_header'];
    tncFooter = json['tnc_footer'];
    tncCheckboxes = json['tnc_checkboxes'].cast<String>();
    tncFile = json['tnc_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tnc_html'] = this.tncHtml;
    data['tnc_header'] = this.tncHeader;
    data['tnc_footer'] = this.tncFooter;
    data['tnc_checkboxes'] = this.tncCheckboxes;
    data['tnc_file'] = this.tncFile;
    return data;
  }
}
