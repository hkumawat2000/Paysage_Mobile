import 'package:lms/network/requestbean/MyCartRequestBean.dart';
import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:lms/network/responsebean/MarginShortfallCartResponse.dart';
import 'package:lms/network/responsebean/MyLoansResponse.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:dio/dio.dart';

class MyLoansDao extends BaseDio {
  Future<MyLoansResponse> myActiveLoans() async {
    Dio dio = await getBaseDio();
    MyLoansResponse wrapper = MyLoansResponse();
    try {
      Response response = await dio.get(Constants.myLoan);
      if (response.statusCode == 200) {
        wrapper = MyLoansResponse.fromJson(response.data);
        if (wrapper.message!.status == 200) {
          wrapper.isSuccessFull = true;
        } else {
          if (wrapper.message!.status == 401) {
            wrapper.isSuccessFull = false;
          } else if (wrapper.message!.status == 422) {
            wrapper.isSuccessFull = false;
          }
        }
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
        wrapper.errorMessage = e.response!.statusMessage!;
      }
    }
    return wrapper;
  }

  Future<ApprovedListResponseBean> getUserSecurities() async {
    Dio dio = await getBaseDio();
    ApprovedListResponseBean wrapper = ApprovedListResponseBean();
    try {
      Response response = await dio.get(
        Constants.securitiesList, queryParameters: {"lender" : ""}
      );
      if (response.statusCode == 200) {
        wrapper = ApprovedListResponseBean.fromJson(response.data);
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
        if (e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }

  Future<MarginShortfallCartResponse> marginShortfallCart(MyCartRequestBean requestBean) async {
    Dio dio = await getBaseDio();
    MarginShortfallCartResponse wrapper = MarginShortfallCartResponse();
    try {
      Response response = await dio.post(Constants.cartUpsert, data: requestBean.toJson());
      if (response.statusCode == 200) {
        wrapper = MarginShortfallCartResponse.fromJson(response.data);
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
        if (e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }

  Future<LoanDetailsResponse> getLoanDetails(loanName) async {
    Dio dio = await getBaseDio();
    LoanDetailsResponse wrapper = LoanDetailsResponse();
    try {
      Response response = await dio.get(Constants.loanDetails, queryParameters: {
        ParametersConstants.loanName: loanName,
        "transactions_per_page": 15,
        "transactions_start": 0
      });
      printLog("loanNameloanNameloanName${loanName}");
      if (response.statusCode == 200) {
        wrapper = LoanDetailsResponse.fromJson(response.data);
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
        printLog("error${e.response!.data}");
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
