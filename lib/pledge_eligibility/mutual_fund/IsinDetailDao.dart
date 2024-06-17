import 'package:lms/network/responsebean/IsinDetailResponseBean.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class IsinDetailDao extends BaseDio {
  Future<IsinDetailResponseBean> isinDetails(isin) async {
    Dio dio = await getBaseDio();
    IsinDetailResponseBean wrapper = IsinDetailResponseBean();
    try {
      Response response = await dio.get(Constants.isinDetails, queryParameters: {ParametersConstants.isin: isin});
      if (response.statusCode == 200) {
        wrapper = IsinDetailResponseBean.fromJson(response.data);
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
        wrapper.errorMessage = e.response!.data["message"];
      }
    }
    return wrapper;
  }}
