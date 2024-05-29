import 'package:lms/network/ModelWrapper.dart';

class DematDetailsResponse extends ModelWrapper<DematDetailsResponse>{
  String? message;
  DematData? dematData;

  DematDetailsResponse({this.message, this.dematData});

  DematDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    dematData = json['data'] != null ? new DematData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.dematData != null) {
      data['data'] = this.dematData!.toJson();
    }
    return data;
  }
}

class DematData {
  String? name;
  String? owner;
  String? creation;
  String? modified;
  String? modifiedBy;
  int? idx;
  int? docstatus;
  String? customer;
  String? depository;
  String? dpid;
  String? clientId;
  String? doctype;

  DematData(
      {this.name,
        this.owner,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.idx,
        this.docstatus,
        this.customer,
        this.depository,
        this.dpid,
        this.clientId,
        this.doctype});

  DematData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    owner = json['owner'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    idx = json['idx'];
    docstatus = json['docstatus'];
    customer = json['customer'];
    depository = json['depository'];
    dpid = json['dpid'];
    clientId = json['client_id'];
    doctype = json['doctype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['owner'] = this.owner;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['idx'] = this.idx;
    data['docstatus'] = this.docstatus;
    data['customer'] = this.customer;
    data['depository'] = this.depository;
    data['dpid'] = this.dpid;
    data['client_id'] = this.clientId;
    data['doctype'] = this.doctype;
    return data;
  }
}
