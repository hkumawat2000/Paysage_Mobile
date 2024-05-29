import 'package:lms/all_loans_name/AllLoansNameDao.dart';
import 'package:lms/network/responsebean/AllLoanNamesResponse.dart';

class AllLoansNameRepository {
  final allLoansNameDao = AllLoansNameDao();

  Future<AllLoanNamesResponse> allLoansName() => allLoansNameDao.allLoansName();
}