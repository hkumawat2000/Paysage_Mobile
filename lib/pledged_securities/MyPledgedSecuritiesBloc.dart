import 'package:choice/network/responsebean/MyPledgedSecuritiesDetailsRespones.dart';

import 'MyPledgedSecuritiesRepository.dart';

class MyPledgedSecuritiesBloc {
  MyPledgedSecuritiesBloc();
  final myPledgedSecuritiesRepository = MyPledgedSecuritiesRepository();

  Future<MyPledgedSecuritiesDetailsRespones> myPledgedSecuritiesDetails(loanName) async{
    MyPledgedSecuritiesDetailsRespones wrapper = await myPledgedSecuritiesRepository.myPledgedSecuritiesDetails(loanName);
    return wrapper;
  }
}