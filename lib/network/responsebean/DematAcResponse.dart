import 'package:lms/network/ModelWrapper.dart';

class DematAcResponse extends ModelWrapper<List<DematAc>>{
  String? message;
  List<DematAc>? dematAc;

  DematAcResponse({this.message, this.dematAc});

  DematAcResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      dematAc = <DematAc>[];
      json['data'].forEach((v) {
        dematAc!.add(new DematAc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.dematAc != null) {
      data['data'] = this.dematAc!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DematAc {
  String? customer;
  String? depository;
  String? dpid;
  String? clientId;
  int? isAtrina;
  String? stockAt;

  DematAc(
      {this.customer,
        this.depository,
        this.dpid,
        this.clientId,
        this.isAtrina,
        this.stockAt});

  DematAc.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    depository = json['depository'];
    dpid = json['dpid'];
    clientId = json['client_id'];
    isAtrina = json['is_choice'];
    stockAt = json['stock_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer'] = this.customer;
    data['depository'] = this.depository;
    data['dpid'] = this.dpid;
    data['client_id'] = this.clientId;
    data['is_choice'] = this.isAtrina;
    data['stock_at'] = this.stockAt;
    return data;
  }
}
