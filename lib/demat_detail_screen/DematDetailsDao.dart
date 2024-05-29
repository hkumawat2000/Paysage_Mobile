import 'package:lms/demat_detail_screen/DematDetailsResponse.dart';
import 'package:lms/network/requestbean/DematDetailNewRequest.dart';
import 'package:lms/network/responsebean/DematAcResponse.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class DematDetailsDao with BaseDio{
  Future<DematDetailsResponse> dematDetails(DematDetailNewRequest dematDetailNewRequest) async{
    Dio dio = await getBaseDio();
    DematDetailsResponse wrapper = DematDetailsResponse();
    try{
      Response response = await dio.post(Constants.dematDetails, data: dematDetailNewRequest.toJson());
      if (response.statusCode == 200) {
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        wrapper.errorMessage = e.response!.statusMessage!;
      }
    }
    return wrapper;
  }

  Future<DematAcResponse> dematAcDetails() async{
    Dio dio = await getBaseDio();
    DematAcResponse wrapper = DematAcResponse();
    try{
      Response response = await dio.get(Constants.dematAcDetails);
      if (response.statusCode == 200) {
        wrapper = DematAcResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        if (e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }

}