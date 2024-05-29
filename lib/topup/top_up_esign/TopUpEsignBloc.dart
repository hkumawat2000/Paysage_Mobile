import 'dart:async';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/ESignResponse.dart';
import 'package:lms/topup/top_up_esign/TopUpEsignRepository.dart';

class TopUpEsignBloc {
  TopUpEsignBloc();

  final topUpEsignRepository = TopUpEsignRepository();

  Future<ESignResponse> topUpEsignVerification(String topUpApplicationName) async {
    ESignResponse wrapper = await topUpEsignRepository.topUpEsignVerification(topUpApplicationName);
    return wrapper;
  }

  Future<CommonResponse> esignSuccess(loanName, fileId) async {
    CommonResponse wrapper = await topUpEsignRepository.topUpEsignSuccess(loanName, fileId);
    return wrapper;
  }
}
