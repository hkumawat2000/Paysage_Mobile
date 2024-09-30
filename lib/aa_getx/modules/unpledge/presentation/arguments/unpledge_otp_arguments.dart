
import 'package:lms/aa_getx/modules/unpledge/domain/entities/request/unpledge_request_req_entity.dart';

class UnpledgeOtpArguments{
  List<UnPledgeListEntity> unpledgeListItem;
  String loanName;
  String maxAllowable;
  String loanType;

  UnpledgeOtpArguments({required this.unpledgeListItem,required this.loanName, required this.maxAllowable, required this.loanType});
}