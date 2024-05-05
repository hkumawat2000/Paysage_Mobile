import 'package:choice/network/requestbean/SellCollateralRequestBean.dart';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/SellCollateralResponseBean.dart';
import 'package:choice/sell_collateral/SellCollateralDao.dart';

class SellCollateralRepository {
  final sellCollateralDao = SellCollateralDao();

  Future<CommonResponse> requestSellCollateralOTP() => sellCollateralDao.requestSellCollateralOTP();

  Future<SellCollateralResponseBean> requestSellCollateralSecurities(Securities securities, String loanName, String otp, String loanMarginShortfallName) =>
      sellCollateralDao.requestSellCollateralSecurities(securities, loanName, otp,loanMarginShortfallName);
}
