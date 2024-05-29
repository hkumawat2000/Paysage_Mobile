import 'package:lms/network/requestbean/SellCollateralRequestBean.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/SellCollateralResponseBean.dart';
import 'package:lms/sell_collateral/SellCollateralDao.dart';

class SellCollateralRepository {
  final sellCollateralDao = SellCollateralDao();

  Future<CommonResponse> requestSellCollateralOTP() => sellCollateralDao.requestSellCollateralOTP();

  Future<SellCollateralResponseBean> requestSellCollateralSecurities(Securities securities, String loanName, String otp, String loanMarginShortfallName) =>
      sellCollateralDao.requestSellCollateralSecurities(securities, loanName, otp,loanMarginShortfallName);
}
