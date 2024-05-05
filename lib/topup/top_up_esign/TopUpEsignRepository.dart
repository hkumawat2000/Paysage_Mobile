import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/ESignResponse.dart';
import 'package:choice/topup/top_up_esign/TopUpEsignDao.dart';

class TopUpEsignRepository {
  final topUpEsignDao = TopUpEsignDao();

  Future<ESignResponse> topUpEsignVerification(String topUpApplicationName) =>
      topUpEsignDao.topUpEsignVerification(topUpApplicationName);

  Future<CommonResponse> topUpEsignSuccess(String topUpApplicationName, fileId) =>
      topUpEsignDao.topUpEsignSuccess(topUpApplicationName, fileId);
}
