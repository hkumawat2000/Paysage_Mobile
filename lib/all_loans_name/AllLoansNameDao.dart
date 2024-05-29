import 'package:lms/network/responsebean/AllLoanNamesResponse.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class AllLoansNameDao with BaseDio{

  Future<AllLoanNamesResponse> allLoansName() async {
    Dio dio = await getBaseDio();
    AllLoanNamesResponse wrapper = AllLoanNamesResponse();
    try {
      Response response = await dio.get(Constants.allLoanName);
      if (response.statusCode == 200) {
        wrapper = AllLoanNamesResponse.fromJson(response.data);
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
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }
}