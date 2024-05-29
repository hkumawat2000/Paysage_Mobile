import 'package:lms/network/requestbean/SellCollateralRequestBean.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/SellCollateralResponseBean.dart';
import 'package:lms/sell_collateral/SellCollateralRepository.dart';

class SellCollateralBloc {
  SellCollateralBloc();

  final sellCollateralRepository = SellCollateralRepository();

  Future<CommonResponse> requestSellCollateralOTP() async {
    CommonResponse wrapper = await sellCollateralRepository.requestSellCollateralOTP();
    return wrapper;
  }

  Future<SellCollateralResponseBean> requestSellCollateralSecurities(
      Securities securities, String loanName, String otp, String loanMarginShortfallName) async {
    SellCollateralResponseBean wrapper = await sellCollateralRepository
        .requestSellCollateralSecurities(securities, loanName, otp, loanMarginShortfallName);
    return wrapper;
  }
}
