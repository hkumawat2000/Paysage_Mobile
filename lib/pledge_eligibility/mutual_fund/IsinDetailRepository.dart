import 'package:choice/network/responsebean/IsinDetailResponseBean.dart';
import 'package:choice/pledge_eligibility/mutual_fund/IsinDetailDao.dart';

class IsinDetailRepository{
  final isinDetailDao = IsinDetailDao();

  Future<IsinDetailResponseBean> isinDetails(isin) => isinDetailDao.isinDetails(isin);
}
