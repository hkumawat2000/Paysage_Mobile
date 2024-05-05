import 'package:choice/network/requestbean/MyCartRequestBean.dart';
import 'package:choice/network/requestbean/SecuritiesRequest.dart';
import 'package:choice/network/responsebean/ApprovedListResponseBean.dart';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/ESignResponse.dart';
import 'package:choice/network/responsebean/MyCartResponseBean.dart';
import 'package:choice/network/responsebean/ProcessCartResponse.dart';
import 'package:choice/network/responsebean/SecuritiesResponseBean.dart';
import 'package:choice/util/base_dio.dart';
import 'package:choice/util/constants.dart';
import 'package:choice/util/strings.dart';
import 'package:dio/dio.dart';

class LoanApplicationDao with BaseDio {
  Future<ProcessCartResponse> createLoanApplication(cartName, otp, fileId, pledgorBoid) async {
    Dio dio = await getBaseDio();
    ProcessCartResponse wrapper = ProcessCartResponse();
    try {
      Response response = await dio.post(Constants.cartProcess,
          data: {"cart_name": cartName, "otp": otp, "file_id": fileId,"pledgor_boid":pledgorBoid});
      if (response.statusCode == 200) {
        wrapper = ProcessCartResponse.fromJson(response.data);
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
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }


  Future<ProcessCartResponse> mfCreateLoanApplication(cartName, otp)async {
    Dio dio = await getBaseDio();
    ProcessCartResponse wrapper = ProcessCartResponse();
    try {
      Response response = await dio.post(Constants.cartProcess,
          data: {"cart_name": cartName, "otp": otp});
      if (response.statusCode == 200) {
        wrapper = ProcessCartResponse.fromJson(response.data);
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
        if(e.response!.data !=null){
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<CommonResponse> createLoanRenewalApplication(loanRenewalName, otp)async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response = await dio.post(Constants.verifyOtpLoanRenewal,
          data: {"loan_renewal_application_name": loanRenewalName, "otp": otp});
      if (response.statusCode == 200) {
        wrapper = CommonResponse.fromJson(response.data);
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
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }


  Future<ApprovedListResponseBean> getUserSecurities(SecuritiesRequest securitiesRequest) async {
    Dio dio = await getBaseDio();
    ApprovedListResponseBean wrapper = ApprovedListResponseBean();
    try {
      Response response = await dio.get(
          Constants.getSecurities, queryParameters: securitiesRequest.toJson()
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
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else if(e.response!.statusCode == 500){
          wrapper.errorCode = e.response!.statusCode;
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<SecuritiesResponseBean> getSecurities(SecuritiesRequest securitiesRequest) async {
    Dio dio = await getBaseDio();
    SecuritiesResponseBean wrapper = SecuritiesResponseBean();
    try {
      Response response = await dio.get(
          Constants.getSharesSecurities, queryParameters: securitiesRequest.toJson()
      );
      if (response.statusCode == 200) {
        wrapper = SecuritiesResponseBean.fromJson(response.data);
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
        } else if(e.response!.statusCode == 500){
          wrapper.errorCode = e.response!.statusCode;
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<MyCartResponseBean> myCart(MyCartRequestBean requestBean) async {
    Dio dio = await getBaseDio();
    MyCartResponseBean wrapper = MyCartResponseBean();
    try {
      Response response = await dio.post(Constants.cartUpsert, data: requestBean.toJson());
      if (response.statusCode == 200) {
        wrapper = MyCartResponseBean.fromJson(response.data);
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
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data != null) {
          if(e.response!.statusCode == 422){
            wrapper.errorMessage = e.response!.data["errors"]["securities"];
          } else {
            wrapper.errorMessage = e.response!.data["message"];
          }
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;


  }

  Future<CommonResponse> pledgeOTP(instrumentType) async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response = await dio.post('api/method/lms.cart.request_pledge_otp', data: {"instrument_type": instrumentType});
      if (response.statusCode == 200) {
        wrapper = CommonResponse.fromJson(response.data);
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
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<CommonResponse> loanRenewalOTP(loanRenewalOTP) async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response = await dio.post(Constants.loanRenewalRequestOtp, data: {"loan_renewal_name": loanRenewalOTP});
      if (response.statusCode == 200) {
        wrapper = CommonResponse.fromJson(response.data);
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
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<ESignResponse> esignVerification(loanName) async {
    Dio dio = await getBaseDio();
    ESignResponse wrapper = ESignResponse();
    try {
      Response response =
      await dio.post(Constants.eSign, data: {ParametersConstants.loanNo: loanName, ParametersConstants.topUpApplicationName : "",ParametersConstants.loanRenewalApplicationName:""});
      if (response.statusCode == 200) {
        wrapper = ESignResponse.fromJson(response.data);
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
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else{
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<CommonResponse> createTopUp(loanName, fileId) async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response =
      await dio.post('api/method/lms.loan.create_topup', data: {"loan_name": loanName,"file_id": fileId});
      if (response.statusCode == 200) {
        wrapper = CommonResponse.fromJson(response.data);
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
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else{
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }

  Future<CommonResponse> esignSuccess(loanName, fileID) async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response =
      await dio.post(Constants.eSignSuccess, data: {
        ParametersConstants.loanNo: loanName,
        ParametersConstants.topUpApplicationName: "",
        ParametersConstants.loanRenewalApplicationName:"",
        ParametersConstants.fileId: fileID});
      if (response.statusCode == 200) {
        wrapper = CommonResponse.fromJson(response.data);
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
        wrapper.errorCode = e.response!.statusCode;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else{
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }
}
