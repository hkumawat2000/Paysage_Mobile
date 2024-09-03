// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/demat_details_response_model.dart';

class DematDetailsResponseModel {
  String? message;
  DematDataResponseModel? dematData;
  
  DematDetailsResponseModel({
    this.message,
    this.dematData,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'data': dematData?.toJson(),
    };
  }

  factory DematDetailsResponseModel.fromMap(Map<String, dynamic> map) {
    return DematDetailsResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      dematData: map['data'] != null ? DematDataResponseModel.fromJson(map['data'] as Map<String,dynamic>) : null,
    );
  }

  DematDetailsResponseEntity toEntity() =>
  DematDetailsResponseEntity(
      message: message,
      dematData: dematData?.toEntity(),
  
  );
}

class DematDataResponseModel {
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
  
  DematDataResponseModel({
    this.name,
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
    this.doctype,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'owner': owner,
      'creation': creation,
      'modified': modified,
      'modified_by': modifiedBy,
      'idx': idx,
      'docstatus': docstatus,
      'customer': customer,
      'depository': depository,
      'dpid': dpid,
      'client_id': clientId,
      'doctype': doctype,
    };
  }

  factory DematDataResponseModel.fromJson(Map<String, dynamic> map) {
    return DematDataResponseModel(
      name: map['name'] != null ? map['name'] as String : null,
      owner: map['owner'] != null ? map['owner'] as String : null,
      creation: map['creation'] != null ? map['creation'] as String : null,
      modified: map['modified'] != null ? map['modified'] as String : null,
      modifiedBy: map['modified_by'] != null ? map['modified_by'] as String : null,
      idx: map['idx'] != null ? map['idx'] as int : null,
      docstatus: map['docstatus'] != null ? map['docstatus'] as int : null,
      customer: map['customer'] != null ? map['customer'] as String : null,
      depository: map['depository'] != null ? map['depository'] as String : null,
      dpid: map['dpid'] != null ? map['dpid'] as String : null,
      clientId: map['client_id'] != null ? map['client_id'] as String : null,
      doctype: map['doctype'] != null ? map['doctype'] as String : null,
    );
  }

  DematDataResponseEntity toEntity() =>
  DematDataResponseEntity(
      name: name,
      owner: owner,
      creation: creation,
      modified: modified,
      modifiedBy: modifiedBy,
      idx: idx,
      docstatus: docstatus,
      customer: customer,
      depository: depository,
      dpid: dpid,
      clientId: clientId,
      doctype: doctype,
  
  );
}
