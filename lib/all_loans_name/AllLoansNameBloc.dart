import 'package:lms/all_loans_name/AllLoansNameRepository.dart';
import 'package:lms/network/responsebean/AllLoanNamesResponse.dart';
import 'package:lms/widgets/WidgetCommon.dart';

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