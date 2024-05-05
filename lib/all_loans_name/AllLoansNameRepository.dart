import 'package:choice/all_loans_name/AllLoansNameDao.dart';
import 'package:choice/network/responsebean/AllLoanNamesResponse.dart';

class AllLoansNameRepository {
  final allLoansNameDao = AllLoansNameDao();

  Future<AllLoanNamesResponse> allLoansName() => allLoansNameDao.allLoansName();
}