import 'package:lms/additional_account_detail/AdditionalAccountResponse.dart';

import 'AdditionalAccountDao.dart';

class AdditionalAccountRepository{
  final additionalAccountDao = AdditionalAccountDao();

  Future<AdditionalAccountResponse> camsAccountAPI(emailID) => additionalAccountDao.camsAccountAPI(emailID);
}