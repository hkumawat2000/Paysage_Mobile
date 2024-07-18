import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/login/presentation/arguments/terms_and_conditions_arguments.dart';
import 'package:lms/util/Preferences.dart';

class TermsAndConditionsWebviewController extends GetxController{
  final ConnectionInfo _connectionInfo;
  TermsAndConditionsWebviewController(this._connectionInfo);
  Preferences _preferences = Preferences();
  String? privacyUrl;
  String? url;
  String? isComingFor;
  PDFDocument? pdfDocument;
  final TermsAndConditionsWebViewArguments termsAndConditionsWebViewArguments = Get.arguments;


  @override
  void onInit() {
    // TODO: implement onInit
    checkNetwork();
    url = termsAndConditionsWebViewArguments.url;
    isComingFor = termsAndConditionsWebViewArguments.isComingFor;
    super.onInit();
  }

  void checkNetwork()async {
    if(await _connectionInfo.isConnected){
      privacyUrl = await _preferences.getPrivacyPolicyUrl();
      //TODO to get T&C arguments
      pdfDocument = await PDFDocument.fromURL(termsAndConditionsWebViewArguments.isForPrivacyPolicy! ? privacyUrl! :termsAndConditionsWebViewArguments.url!);
    }
  }

  
}