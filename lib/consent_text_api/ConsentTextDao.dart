import 'package:choice/network/responsebean/ConsentTextResponse.dart';
import 'package:choice/util/base_dio.dart';
import 'package:choice/util/constants.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:dio/dio.dart';

class ConsentTextDao with BaseDio {
  Future<ConsentTextResponse> getConsentText(consentFor) async {
    Dio dio = await getBaseDio();
    ConsentTextResponse wrapper = ConsentTextResponse();
    try {
      Response response =
      await dio.get(Constants.consentText, queryParameters: {ParametersConstants.consentName: consentFor});
      if (response.statusCode == 200) {
        wrapper = ConsentTextResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        if (e.response!.data["message"] != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }
}
