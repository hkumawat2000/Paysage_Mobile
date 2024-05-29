import 'package:lms/network/responsebean/IsinDetailResponseBean.dart';
import 'package:lms/pledge_eligibility/mutual_fund/IsinDetailDao.dart';

class IsinDetailRepository{
  final isinDetailDao = IsinDetailDao();

  Future<IsinDetailResponseBean> isinDetails(isin) => isinDetailDao.isinDetails(isin);
}
