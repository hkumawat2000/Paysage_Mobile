import 'package:choice/network/requestbean/SellCollateralRequestBean.dart';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/SellCollateralResponseBean.dart';
import 'package:choice/sell_collateral/SellCollateralRepository.dart';

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
