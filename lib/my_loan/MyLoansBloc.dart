import 'dart:async';
import 'dart:convert';

import 'package:lms/my_loan/MyLoansRepository.dart';
import 'package:lms/network/requestbean/MyCartRequestBean.dart';
import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:lms/network/responsebean/MarginShortfallCartResponse.dart';
import 'package:lms/network/responsebean/MyLoansResponse.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class MyLoansBloc{
  MyLoansBloc();
  final myLoansRepository = MyLoansRepository();
//  final myActiveLoanController = StreamController<MyLoansData>.broadcast();
//  get myActiveLoan => myActiveLoanController.stream;
  final myActiveLoanController = StreamController<LoanDetailData>.broadcast();
  get myActiveLoan => myActiveLoanController.stream;
  final loanLoanController = StreamController<MyLoansData>.broadcast();
  get loanDetails => loanLoanController.stream;
  final _listUserSecController = StreamController<List<ShareListData>>.broadcast();
  final _listMyCartController = StreamController<MarginShortfallCartData>.broadcast();

  get myCart => _listMyCartController.stream;



  Future<MyLoansResponse> myActiveLoans() async {
    MyLoansResponse wrapper = await myLoansRepository.myActiveLoans();
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
      if(wrapper.message!.data!.loans != null) {
        loanLoanController.sink.add(wrapper.message!.data!);
      }
    } else {
      printLog("-----FAIL-----");
    }
    return wrapper;
  }

  Future<ApprovedListResponseBean> getUserDetailsSecurities(loan_name) async {
    ApprovedListResponseBean wrapper = await myLoansRepository.getUserSecurities();
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
      List<ShareListData> securities = [];
      for (var i = 0; i < wrapper.data!.length; i++) {
        if (wrapper.data![i].isEligible == true) {
          var temp = wrapper.data![i];
          temp.pledge_qty = temp.quantity;
          securities.add(wrapper.data![i]);
        }
      }

      List<SecuritiesList> securitiesListItems = [];
      Securities securitiesObj = new Securities();
      for (int i = 0; i < securities.length; i++) {
        securitiesListItems.add(new SecuritiesList(
            quantity: securities[i].pledge_qty,
            isin: securities[i].iSIN,
            price: securities[i].price));
      }
      printLog("List :$securitiesListItems");
      securitiesObj.list = securitiesListItems;
      MyCartRequestBean myCartRequestBean = MyCartRequestBean();
      myCartRequestBean.securities = securitiesObj;
      myCartRequestBean.loamName = loan_name;
      myCartRequestBean.pledgor_boid = wrapper.data![0].stockAt;
      myCartRequestBean.cartName = "";
      myCartRequestBean.loan_margin_shortfall_name = "";
      myCartRequestBean.lender = "";
      printLog("Loan::${myCartRequestBean.loamName}");
      printLog("request::${json.encode(myCartRequestBean)}");
      await marginShortfallCart(myCartRequestBean);
      _listUserSecController.sink.add(securities);
      wrapper.data = securities;
    } else {
      printLog("-----FAIL-----");
    }
    return wrapper;
  }

  Future<MarginShortfallCartResponse> marginShortfallCart(MyCartRequestBean requestBean) async {
    MarginShortfallCartResponse wrapper = await myLoansRepository.marginShortfallCart(requestBean);
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
      _listMyCartController.sink.add(wrapper.data!);
    } else {
      printLog("-----FAIL-----");
    }
    return wrapper;
  }

  void dispose() {

  }

  Future<LoanDetailsResponse> getLoanDetails(loanName) async {
    LoanDetailsResponse wrapper = await myLoansRepository.getLoanDetails(loanName);
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
      myActiveLoanController.sink.add(wrapper.data!);
    } else {
      printLog("-----FAIL-----");
    }
    return wrapper;
  }

}