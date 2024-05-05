import 'package:choice/all_loans_name/AllLoansNameRepository.dart';
import 'package:choice/network/responsebean/AllLoanNamesResponse.dart';
import 'package:choice/widgets/WidgetCommon.dart';

class AllLoansNameBloc{

  AllLoansNameBloc();
  final allLoansNameRepository = AllLoansNameRepository();

  Future<AllLoanNamesResponse> allLoansName() async {
    AllLoanNamesResponse wrapper = await allLoansNameRepository.allLoansName();
    if(wrapper.isSuccessFull!){
      printLog("sucess");
    }else{
      printLog("fail");
    }
    return wrapper;
  }
}