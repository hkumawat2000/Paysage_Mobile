import 'package:lms/lender/LenderDao.dart';
import 'package:lms/network/responsebean/LenderResponseBean.dart';

class LenderRepository{

  final lenderDao = LenderDao();

  Future<LenderResponseBean> getLenders() => lenderDao.getLenders();
}