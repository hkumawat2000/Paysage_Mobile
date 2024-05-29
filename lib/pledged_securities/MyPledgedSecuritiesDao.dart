import 'package:lms/network/responsebean/MyPledgedSecuritiesDetailsRespones.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class MyPledgedSecuritiesDao with BaseDio{
  Future<MyPledgedSecuritiesDetailsRespones> myPledgedSecuritiesDetails(loanName) async {
    Dio dio = await getBaseDio();
    MyPledgedSecuritiesDetailsRespones wrapper = MyPledgedSecuritiesDetailsRespones();
    try {
      Response response = await dio.get(Constants.myPledgeSecurities,
          queryParameters: {ParametersConstants.loanName: loanName});
      if (response.statusCode == 200) {
        wrapper = MyPledgedSecuritiesDetailsRespones.fromJson(response.data);
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
        wrapper.errorMessage = e.response!.statusMessage;

      }
    }
    return wrapper;
  }
}