import 'package:choice/network/responsebean/MyPledgedSecuritiesDetailsRespones.dart';
import 'package:choice/pledged_securities/MyPledgedSecuritiesDao.dart';

class MyPledgedSecuritiesRepository {
  final myPledgedSecuritiesDao = MyPledgedSecuritiesDao();

  Future<MyPledgedSecuritiesDetailsRespones> myPledgedSecuritiesDetails(loanName) =>
      myPledgedSecuritiesDao.myPledgedSecuritiesDetails(loanName);



}