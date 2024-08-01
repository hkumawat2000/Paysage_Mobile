// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/data/models/download_kyc_data_response_model.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/download_kyc_data_response_entity.dart';
import 'package:lms/aa_getx/modules/kyc/domain/entities/kyc_download_response_entity.dart';

class KYCDownloadResponseModel {
  String? message;
  DownloadDataResponseModel? downloadData;

  KYCDownloadResponseModel({this.message, this.downloadData});

  KYCDownloadResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    downloadData = json['data'] != null ? new DownloadDataResponseModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.downloadData != null) {
      data['data'] = this.downloadData!.toJson();
    }
    return data;
  }

  KycDownloadResponseEntity toEntity() =>
  KycDownloadResponseEntity(
      message: message,
      downloadData: downloadData?.toEntity(),
  
  );

  factory KYCDownloadResponseModel.fromEntity(KycDownloadResponseEntity kycdownloadResponseEntity) {
    return KYCDownloadResponseModel(
      message: kycdownloadResponseEntity.message != null ? kycdownloadResponseEntity.message as String : null,
      downloadData: kycdownloadResponseEntity.downloadData != null ? DownloadDataResponseModel.fromEntity(kycdownloadResponseEntity.downloadData as DownloadDataResponseEntity) : null,
    );
  }
}


