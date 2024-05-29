import 'package:lms/my_loan/MyLoansDao.dart';
import 'package:lms/network/requestbean/MyCartRequestBean.dart';
import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:lms/network/responsebean/MarginShortfallCartResponse.dart';
import 'package:lms/network/responsebean/MyCartResponseBean.dart';
import 'package:lms/network/responsebean/MyLoansResponse.dart';

class MyLoansRepository{
  final myLoansDao = MyLoansDao();
  Future<MyLoansResponse> myActiveLoans() => myLoansDao.myActiveLoans();
  Future<ApprovedListResponseBean> getUserSecurities()=>
      myLoansDao.getUserSecurities();

  Future<MarginShortfallCartResponse> marginShortfallCart(MyCartRequestBean requestBean) => myLoansDao.marginShortfallCart(requestBean);
  Future<LoanDetailsResponse> getLoanDetails(loanName) => myLoansDao.getLoanDetails(loanName);
}