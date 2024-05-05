import 'package:choice/network/ModelWrapper.dart';
import 'package:choice/widgets/WidgetCommon.dart';

class CommonResponse extends ModelWrapper<CommonData>{
  String? message;
  CommonData? data;

  CommonResponse({this.message, this.data});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    try {
      message = json['message'];
      data = json['data'] != null ? new CommonData.fromJson(json['data']) : null;
    } catch (e, s) {
      printLog(s.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message;
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CommonData {
  String? loanTransactionName;

  CommonData({this.loanTransactionName});

  CommonData.fromJson(Map<String, dynamic> json) {
    loanTransactionName = json['loan_transaction_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loan_transaction_name'] = this.loanTransactionName;
    return data;
  }
}
