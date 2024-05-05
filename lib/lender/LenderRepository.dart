import 'package:choice/lender/LenderDao.dart';
import 'package:choice/network/responsebean/LenderResponseBean.dart';

class LenderRepository{

  final lenderDao = LenderDao();

  Future<LenderResponseBean> getLenders() => lenderDao.getLenders();
}