import 'package:choice/network/ModelWrapper.dart';

class CreateContactResponse extends ModelWrapper{
  String? message;

  CreateContactResponse({this.message});

  CreateContactResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}
