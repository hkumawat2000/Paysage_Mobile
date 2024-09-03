// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/approved_shares_and_mf/domain/entities/demat_account_response_entity.dart';

class DematAcctResponseModel {
  String? message;
  List<DematAccount>? dematAc;
  
  DematAcctResponseModel({
    this.message,
    this.dematAc,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'message': message,
      'data': dematAc!.map((x) => x.toJson()).toList(),
    };
  }

  factory DematAcctResponseModel.fromJson(Map<String, dynamic> map) {
    return DematAcctResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      dematAc: map['data'] != null ? List<DematAccount>.from((map['data'] as List<int>).map<DematAccount?>((x) => DematAccount.fromJson(x as Map<String,dynamic>),),) : null,
    );
  }

  DematAccountResponseEntity toEntity() =>
  DematAccountResponseEntity(
      message: message,
      dematAc: dematAc?.map((x) => x.toEntity()).toList(),
  
  );
}

class DematAccount {
  String? customer;
  String? depository;
  String? dpid;
  String? clientId;
  int? isAtrina;
  String? stockAt;

  DematAccount({
    this.customer,
    this.depository,
    this.dpid,
    this.clientId,
    this.isAtrina,
    this.stockAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'customer': customer,
      'depository': depository,
      'dpid': dpid,
      'client_id': clientId,
      'is_choice': isAtrina,
      'stock_at': stockAt,
    };
  }

  factory DematAccount.fromJson(Map<String, dynamic> map) {
    return DematAccount(
      customer: map['customer'] != null ? map['customer'] as String : null,
      depository:
          map['depository'] != null ? map['depository'] as String : null,
      dpid: map['dpid'] != null ? map['dpid'] as String : null,
      clientId: map['client_id'] != null ? map['client_id'] as String : null,
      isAtrina: map['is_choice'] != null ? map['is_choice'] as int : null,
      stockAt: map['stock_at'] != null ? map['stock_at'] as String : null,
    );
  }

  DematAccountEntity toEntity() =>
  DematAccountEntity(
      customer: customer,
      depository: depository,
      dpid: dpid,
      clientId: clientId,
      isAtrina: isAtrina,
      stockAt: stockAt,
  
  );
}
