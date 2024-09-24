import 'package:lms/aa_getx/modules/bank/domain/entities/request/bank_details_request_entity.dart';

class BankDetailsRequestModel {
  String? ifsc;

  BankDetailsRequestModel({this.ifsc});

  BankDetailsRequestModel.fromJson(Map<String, dynamic> json) {
    ifsc = json['ifsc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ifsc'] = this.ifsc;
    return data;
  }

  factory BankDetailsRequestModel.fromEntity(BankDetailsRequestEntity bankDetailsRequestEntity) {
    return BankDetailsRequestModel(
      ifsc: bankDetailsRequestEntity.ifsc != null ? bankDetailsRequestEntity.ifsc as String : null,
    );
  }
}
