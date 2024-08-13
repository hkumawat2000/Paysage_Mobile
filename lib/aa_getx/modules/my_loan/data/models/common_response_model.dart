import 'package:flutter/material.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';

class CommonResponseModel {
  String? message;
  CommonData? commonData;

  CommonResponseModel({this.message, this.commonData});

  CommonResponseModel.fromJson(Map<String, dynamic> json) {
    try {
      message = json['message'];
      commonData =
          json['data'] != null ? new CommonData.fromJson(json['data']) : null;
    } catch (e, s) {
      debugPrint(s.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message;
    }
    if (this.commonData != null) {
      data['data'] = this.commonData!.toJson();
    }
    return data;
  }

  CommonResponseEntity toEntity() => CommonResponseEntity(
        message: message,
        commonData: commonData?.toEntity(),
      );
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

  CommonDataEntity toEntity() => CommonDataEntity(
        loanTransactionName: loanTransactionName,
      );
}
