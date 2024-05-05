class ContactUsRequestBean {
  // String? subject;
  // String? sender;
  String? message;

  ContactUsRequestBean({this.message});

  ContactUsRequestBean.fromJson(Map<String, dynamic> json) {
    // subject = json['subject'];
    // sender = json['sender'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['subject'] = this.subject;
    // data['sender'] = this.sender;
    data['message'] = this.message;
    return data;
  }
}
