
import 'package:lms/aa_getx/modules/sell_collateral/domain/entities/request/sell_collateral_request_entity.dart';

class SellCollateralOtpArguments {
  String loanName, marginShortfallName;
  List<SellListEntity> sellList;
  String loanType;

  SellCollateralOtpArguments({required this.loanName,required this.sellList, required this.marginShortfallName, required this.loanType});
}