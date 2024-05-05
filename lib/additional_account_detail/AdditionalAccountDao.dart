import 'package:choice/additional_account_detail/AdditionalAccountResponse.dart';
import 'package:choice/util/base_dio.dart';
import 'package:choice/util/constants.dart';
import 'package:choice/util/strings.dart';
import 'package:dio/dio.dart';

class AdditionalAccountDao with BaseDio{
  Future<AdditionalAccountResponse> camsAccountAPI(emailID) async{
    Dio dio = await getBaseDio();
    AdditionalAccountResponse wrapper = AdditionalAccountResponse();
    try{
      Response response = await dio.post(Constants.camsDetails, data: {ParametersConstants.emailId: emailID});
      if (response.statusCode == 200) {
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    }on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        wrapper.errorMessage = e.response!.data["message"];
      }
    }
    return wrapper;
  }
}