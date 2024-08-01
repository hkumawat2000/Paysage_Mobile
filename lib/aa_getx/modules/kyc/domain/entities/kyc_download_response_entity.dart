import 'package:lms/aa_getx/modules/kyc/domain/entities/download_kyc_data_response_entity.dart';

class KycDownloadResponseEntity  {
  String? message;
  DownloadDataResponseEntity? downloadData;

  KycDownloadResponseEntity({this.message, this.downloadData});
}