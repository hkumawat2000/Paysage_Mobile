import 'package:choice/additional_account_detail/AdditionalAccountResponse.dart';

import 'AdditionalAccountRepository.dart';

class AdditionalAccountBloc{

  final additionalAccountRepository = AdditionalAccountRepository();

  Future<AdditionalAccountResponse> camsAccountAPI(emailID) async {
    AdditionalAccountResponse wrapper = await additionalAccountRepository.camsAccountAPI(emailID);
    return wrapper;
  }
}