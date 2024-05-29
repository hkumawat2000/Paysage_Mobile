import 'package:lms/network/responsebean/ConsentTextResponse.dart';
import 'ConsentTextRepository.dart';

class ConsentTextBloc{
  final consentTextRepository = ConsentTextRepository();

  Future<ConsentTextResponse> getConsentText(consentFor) async{
    ConsentTextResponse wrapper = await consentTextRepository.getConsentText(consentFor);
    return wrapper;
  }
}