import 'package:choice/network/requestbean/LoanStatementRequestBean.dart';
import 'package:choice/network/responsebean/LoanStatementResponseBean.dart';
import 'package:choice/network/responsebean/PledgeSecurityTransactionResponseBean.dart';
import 'package:choice/util/base_dio.dart';
import 'package:choice/util/constants.dart';
import 'package:choice/util/strings.dart';
import 'package:dio/dio.dart';

class PledgeSecurityTransactionDao with BaseDio {
  Future<PledgeSecurityTransactionResponseBean> getPledgeSecurityTransaction(
      LoanStatementRequestBean loanStatementRequestBean) async {
    Dio dio = await getBaseDio();
    PledgeSecurityTransactionResponseBean wrapper = PledgeSecurityTransactionResponseBean();
    LoanStatementRequestBean statementRequestBean = LoanStatementRequestBean(
        loanName: loanStatementRequestBean.loanName,
        type: loanStatementRequestBean.type,
        duration: null,
        fileFormat: "pdf",
        fromDate: null,
        toDate: null,
        isEmail: 0,
        isDownload: 0);
    try {
      Response response = await dio.get("api/method/lms.loan.loan_statement",
          queryParameters: statementRequestBean.toJson()
      );
      if (response.statusCode == 200) {
        wrapper = PledgeSecurityTransactionResponseBean.fromJson(response.data);
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
        if (e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }
}
