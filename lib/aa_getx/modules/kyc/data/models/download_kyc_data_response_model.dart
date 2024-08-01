// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/modules/kyc/domain/entities/download_kyc_data_response_entity.dart';

class DownloadDataResponseModel {
  String? userKycName;

  DownloadDataResponseModel({this.userKycName});

  DownloadDataResponseModel.fromJson(Map<String, dynamic> json) {
    userKycName = json['user_kyc_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_kyc_name'] = this.userKycName;
    return data;
  }

  DownloadDataResponseEntity toEntity() =>
  DownloadDataResponseEntity(
      userKycName: userKycName,
  
  );

  factory DownloadDataResponseModel.fromEntity(DownloadDataResponseEntity downloadDataResponseEntity) {
    return DownloadDataResponseModel(
      userKycName: downloadDataResponseEntity.userKycName != null ? downloadDataResponseEntity.userKycName as String : null,
    );
  }
}
