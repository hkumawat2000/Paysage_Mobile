import 'package:choice/my_loan/MyLoansDao.dart';
import 'package:choice/network/requestbean/MyCartRequestBean.dart';
import 'package:choice/network/responsebean/ApprovedListResponseBean.dart';
import 'package:choice/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:choice/network/responsebean/MarginShortfallCartResponse.dart';
import 'package:choice/network/responsebean/MyCartResponseBean.dart';
import 'package:choice/network/responsebean/MyLoansResponse.dart';

class MyLoansRepository{
  final myLoansDao = MyLoansDao();
  Future<MyLoansResponse> myActiveLoans() => myLoansDao.myActiveLoans();
  Future<ApprovedListResponseBean> getUserSecurities()=>
      myLoansDao.getUserSecurities();

  Future<MarginShortfallCartResponse> marginShortfallCart(MyCartRequestBean requestBean) => myLoansDao.marginShortfallCart(requestBean);
  Future<LoanDetailsResponse> getLoanDetails(loanName) => myLoansDao.getLoanDetails(loanName);
}