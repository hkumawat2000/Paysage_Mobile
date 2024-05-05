import 'package:choice/network/responsebean/ConsentTextResponse.dart';
import 'package:choice/nsdl/BankDetailDao.dart';
import 'package:flutter/material.dart';

import 'ConsentTextDao.dart';

class ConsentTextRepository{

  final consentTextDao = ConsentTextDao();

  Future<ConsentTextResponse> getConsentText(consentFor) => consentTextDao.getConsentText(consentFor);

}