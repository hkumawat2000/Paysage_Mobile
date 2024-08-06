import 'package:dio/dio.dart';
import 'package:lms/aa_getx/core/error/dio_error_handler.dart';
import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/network/apis.dart';
import 'package:lms/aa_getx/core/network/base_dio.dart';
import 'package:lms/aa_getx/modules/my_loan/data/models/all_loan_names_response_model.dart';

abstract class MyLoansApi{
  Future<AllLoanNamesResponseModel> getAllLoansNames();
}

class MyLoansApiImpl with BaseDio implements MyLoansApi{
  @override
  Future<AllLoanNamesResponseModel> getAllLoansNames() async{
    Dio dio = await  getBaseDio();
    try {
      final response = await dio.get(Apis.allLoanName);
      if(response.statusCode == 200) {
        return AllLoanNamesResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.statusMessage);
      }
    } on DioException catch (e){
      throw handleDioClientError(e);
    }
  }
}