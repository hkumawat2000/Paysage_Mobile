import 'package:choice/network/ModelWrapper.dart';

class BankMasterResponse extends ModelWrapper<List<BankData>>{
  String? message;
  List<BankData>? bankList;


  BankMasterResponse({this.message, this.bankList});

  BankMasterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      bankList = <BankData>[];
      json['data'].forEach((v) {
        bankList!.add(new BankData.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.bankList != null) {
      data['data'] = this.bankList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankData {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  int? idx;
  String? bank;
  String? ifsc;
  String? branch;
  String? address;
  String? district;
  String? city;
  String? state;
  int? isActive;

  BankData(
      {this.name,
        this.creation,
        this.modified,
        this.modifiedBy,
        this.owner,
        this.docstatus,
        this.idx,
        this.bank,
        this.ifsc,
        this.branch,
        this.address,
        this.district,
        this.city,
        this.state,
        this.isActive});

  BankData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    idx = json['idx'];
    bank = json['bank'];
    ifsc = json['ifsc'];
    branch = json['branch'];
    address = json['address'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['idx'] = this.idx;
    data['bank'] = this.bank;
    data['ifsc'] = this.ifsc;
    data['branch'] = this.branch;
    data['address'] = this.address;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['is_active'] = this.isActive;
    return data;
  }
}