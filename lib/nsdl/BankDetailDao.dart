import 'package:lms/network/requestbean/ValidateBankRequestBean.dart';
import 'package:lms/network/responsebean/AtrinaBankResponseBean.dart';
import 'package:lms/network/responsebean/FundAccValidationResponseBean.dart';
import 'package:lms/nsdl/BankMasterResponse.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class BankDetailDao extends BaseDio {
  Future<BankMasterResponse> getBankDetails(ifsc) async {
    Dio dio = await getBaseDio();
    BankMasterResponse wrapper = BankMasterResponse();
    try {
      Response response =
      await dio.get(Constants.bankMaster, queryParameters: {ParametersConstants.ifsc: ifsc});
      if (response.statusCode == 200) {
        wrapper = BankMasterResponse.fromJson(response.data);
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

  Future<FundAccValidationResponseBean> validateBank(ValidateBankRequestBean validateBankRequestBean) async {
    Dio dio = await getBaseDio();
    FundAccValidationResponseBean wrapper = FundAccValidationResponseBean();
    try{
      Response response = await dio.post(Constants.auPennyDrop, data: validateBankRequestBean.toJson());
      if(response.statusCode == 200){
        wrapper = FundAccValidationResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = true;
      }else{
        wrapper = FundAccValidationResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = false;
        wrapper.errorCode = response.statusCode;
        wrapper.errorMessage = response.statusMessage;
      }
    }on DioError catch (e){
      if(e.response == null) {
        wrapper.isSuccessFull =false;
        wrapper.errorMessage = Strings.server_error;
        wrapper.errorCode = Constants.noInternet;
      }else{
        wrapper.isSuccessFull =false;
        wrapper.errorCode = e.response!.statusCode;
        if (e.response!.data["message"] != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }

    return wrapper;
  }

  // Future<CreateContactResponse> createContactAPI() async{
  //   Dio dio = await getBaseDio();
  //   CreateContactResponse wrapper = CreateContactResponse();
  //   try{
  //     Response response = await dio.post(Constants.CREATE_ACCOUNT);
  //     if(response.statusCode == 200){
  //       wrapper = CreateContactResponse.fromJson(response.data);
  //       wrapper.isSuccessFull = true;
  //     }else{
  //       wrapper.isSuccessFull = false;
  //     }
  //   }on DioError catch (e){
  //     if(e.response == null) {
  //       wrapper.isSuccessFull =false;
  //       wrapper.errorMessage = Strings.server_error;
  //       wrapper.errorCode = Constants.NO_INTERNET;
  //     }else{
  //       wrapper.isSuccessFull =false;
  //       wrapper.errorCode = e.response!.statusCode;
  //       wrapper.errorMessage = e.response!.statusMessage!;
  //     }
  //   }
  //
  //   return wrapper;
  // }

  // Future<CreateFundAccountResponseBean> createFundAccountAPI(CreateFundAccountRequestBean createFundAccountRequestBean) async {
  //   Dio dio = await getBaseDio();
  //   CreateFundAccountResponseBean wrapper = CreateFundAccountResponseBean();
  //   try{
  //     Response response = await dio.post(Constants.CREATE_FUND_ACCOUNT, data: createFundAccountRequestBean.toJson());
  //     if(response.statusCode == 200){
  //       wrapper = CreateFundAccountResponseBean.fromJson(response.data);
  //       wrapper.isSuccessFull = true;
  //     }else{
  //       wrapper.isSuccessFull = false;
  //     }
  //   }on DioError catch (e){
  //     if(e.response == null) {
  //       wrapper.isSuccessFull =false;
  //       wrapper.errorMessage = Strings.server_error;
  //       wrapper.errorCode = Constants.NO_INTERNET;
  //     }else{
  //       wrapper.isSuccessFull =false;
  //       wrapper.errorCode = e.response!.statusCode;
  //       if (e.response!.data != null) {
  //         wrapper.errorMessage = e.response!.data["message"];
  //       } else {
  //         wrapper.errorMessage = e.response!.statusMessage!;
  //       }
  //     }
  //   }
  //
  //   return wrapper;
  // }

  // Future<FundAccValidationResponseBean> fundAccValidationAPI(FundAccValidationRequestBean fundAccValidationRequestBean) async {
  //   Dio dio = await getBaseDio();
  //   FundAccValidationResponseBean wrapper = FundAccValidationResponseBean();
  //   try{
  //     Response response = await dio.post(Constants.CREATE_ACCOUNT_VALIDATION, data: fundAccValidationRequestBean.toJson());
  //     if(response.statusCode == 200){
  //       wrapper = FundAccValidationResponseBean.fromJson(response.data);
  //       wrapper.isSuccessFull = true;
  //     // } else if(response.statusCode == 500){
  //     //   wrapper = FundAccValidationResponseBean.fromJson(response.data);
  //     //   wrapper.isSuccessFull = true;
  //     } else{
  //       wrapper.isSuccessFull = false;
  //     }
  //   }on DioError catch (e){
  //     if(e.response == null) {
  //       wrapper.isSuccessFull =false;
  //       wrapper.errorMessage = Strings.server_error;
  //       wrapper.errorCode = Constants.NO_INTERNET;
  //     // }else if(e.response!.statusCode == 417){
  //     //   wrapper = FundAccValidationResponseBean.fromJson(e.response!.data);
  //     //   wrapper.isSuccessFull = true;
  //     //   wrapper.errorCode = e.response!.statusCode;
  //     } else{
  //       wrapper.isSuccessFull =false;
  //       wrapper.errorCode = e.response!.statusCode;
  //       if (e.response!.data != null) {
  //         wrapper.errorMessage = e.response!.data["message"];
  //       } else {
  //         wrapper.errorMessage = e.response!.statusMessage!;
  //       }
  //     }
  //   }
  //
  //   return wrapper;
  // }

  // Future<FundAccValidationResponseBean> fundAccValidationByIdAPI(favId, chequeByteImageString) async {
  //   Dio dio = await getBaseDio();
  //   FundAccValidationResponseBean wrapper = FundAccValidationResponseBean();
  //   try {
  //     Response response = await dio.post(
  //         Constants.CREATE_ACCOUNT_VALIDATION_BY_ID,
  //         data: {ParametersConstants.FAV_ID: favId, ParametersConstants.PERSONALIZED_CHEQUE: chequeByteImageString });
  //     if (response.statusCode == 200) {
  //       wrapper = FundAccValidationResponseBean.fromJson(response.data);
  //       wrapper.isSuccessFull = true;
  //     // } else if(response.statusCode == 417){
  //     //   wrapper = FundAccValidationResponseBean.fromJson(response.data);
  //     //   wrapper.isSuccessFull = true;
  //     } else {
  //       wrapper.isSuccessFull = false;
  //     }
  //   } on DioError catch (e) {
  //     if (e.response == null) {
  //       wrapper.isSuccessFull = false;
  //       wrapper.errorMessage = Strings.server_error;
  //       wrapper.errorCode = Constants.NO_INTERNET;
  //     // } else if (e.response!.statusCode == 417) {
  //     //   wrapper = FundAccValidationResponseBean.fromJson(e.response!.data);
  //     //   wrapper.isSuccessFull = true;
  //     //   wrapper.errorCode = e.response!.statusCode;
  //     } else {
  //       wrapper.isSuccessFull = false;
  //       wrapper.errorCode = e.response!.statusCode;
  //       if (e.response!.data != null) {
  //         wrapper.errorMessage = e.response!.data["message"];
  //       } else {
  //         wrapper.errorMessage = e.response!.statusMessage!;
  //       }
  //     }
  //   }
  //   return wrapper;
  // }

  Future<AtrinaBankResponseBean> getAtrinaBankKYC() async {
    Dio dio = await getBaseDio();
    AtrinaBankResponseBean wrapper = AtrinaBankResponseBean();
    try {
      Response response = await dio.post(Constants.atrinaBank );
      if (response.statusCode == 200) {
        wrapper = AtrinaBankResponseBean.fromJson(response.data);
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
        wrapper.errorMessage = e.response!.statusMessage!;
        // printLog("error${e.response.data["message"]}");
        // wrapper.isSuccessFull = false;
        // wrapper.errorCode = e.response.statusCode;
        // if(e.response.data !=null) {
        //   wrapper.errorMessage = e.response.data["error"]["message"];
        // }else{
        //   wrapper.errorMessage = e.response.statusMessage;
        // }
      }
    }
    return wrapper;
  }

}
