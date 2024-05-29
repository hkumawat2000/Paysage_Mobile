import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/ESignResponse.dart';
import 'package:lms/topup/top_up_esign/TopUpEsignDao.dart';

class TopUpEsignRepository {
  final topUpEsignDao = TopUpEsignDao();

  Future<ESignResponse> topUpEsignVerification(String topUpApplicationName) =>
      topUpEsignDao.topUpEsignVerification(topUpApplicationName);

  Future<CommonResponse> topUpEsignSuccess(String topUpApplicationName, fileId) =>
      topUpEsignDao.topUpEsignSuccess(topUpApplicationName, fileId);
}
