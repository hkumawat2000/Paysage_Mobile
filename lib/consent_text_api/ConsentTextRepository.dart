import 'package:lms/network/responsebean/ConsentTextResponse.dart';
import 'package:lms/nsdl/BankDetailDao.dart';
import 'package:flutter/material.dart';

import 'ConsentTextDao.dart';

class ConsentTextRepository{

  final consentTextDao = ConsentTextDao();

  Future<ConsentTextResponse> getConsentText(consentFor) => consentTextDao.getConsentText(consentFor);

}