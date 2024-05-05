import 'dart:async';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/ESignResponse.dart';
import 'package:choice/topup/top_up_esign/TopUpEsignRepository.dart';

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
