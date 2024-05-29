import 'package:lms/network/responsebean/MyPledgedSecuritiesDetailsRespones.dart';
import 'package:lms/pledged_securities/MyPledgedSecuritiesDao.dart';

class MyPledgedSecuritiesRepository {
  final myPledgedSecuritiesDao = MyPledgedSecuritiesDao();

  Future<MyPledgedSecuritiesDetailsRespones> myPledgedSecuritiesDetails(loanName) =>
      myPledgedSecuritiesDao.myPledgedSecuritiesDetails(loanName);



}