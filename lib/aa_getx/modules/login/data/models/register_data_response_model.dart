import 'package:lms/aa_getx/modules/login/data/models/customer_response_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/pending_esign_response_model.dart';
import 'package:lms/aa_getx/modules/login/data/models/user_kyc_response_model.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/register_data_entity.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class RegisterData {
  String? token;
  Customer? customer;
  UserKyc? userKyc;
  List<PendingEsigns>? pendingEsigns;

  RegisterData({this.token, this.customer, this.userKyc,this.pendingEsigns});

  RegisterData.fromJson(Map<String, dynamic> json) {
    try {
      token = json['token'];
      if(json['customer'] != null && json['customer'] != ""){
        customer = new Customer.fromJson(json['customer']);
      }
      userKyc = json['user_kyc'] != null
          ? new UserKyc.fromJson(json['user_kyc'])
          : null;
      if (json['pending_esigns'] != null && json['pending_esigns'] != "") {
        pendingEsigns = <PendingEsigns>[];
        json['pending_esigns'].forEach((v) {
          pendingEsigns!.add(new PendingEsigns.fromJson(v));
        });
      }
    } catch (e, s) {
      printLog(s.toString());
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.userKyc != null) {
      data['user_kyc'] = this.userKyc!.toJson();
    }
    if (this.pendingEsigns != null) {
      data['pending_esigns'] =
          this.pendingEsigns!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  RegisterDataEntity toEntity() =>
  RegisterDataEntity(
      token:token != null ? token : null,
      customer: customer != null ? customer?.toEntity() : null,
      userKyc:userKyc !=null ?  userKyc?.toEntity() : null,
      pendingEsigns:pendingEsigns != null ? pendingEsigns?.map((x) => x.toEntity()).toList() :[] ,
  
  );
}