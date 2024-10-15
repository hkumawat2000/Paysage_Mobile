import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/entity/request/contactus_request_entity.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/entity/response/contactus_response_entity.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/usecases/contact_us_usecase.dart';

import '../../../../core/constants/strings.dart';

class ContactUsController extends GetxController {

  TextEditingController? searchController = TextEditingController();
  TextEditingController? messageController = TextEditingController();

  RxString contactUsMessageTxt = "".obs;

  final ContactUsUsecase contactUsUsecase;

  ContactUsController(this.contactUsUsecase);

  contactUsAPI() async {
    showDialogLoading(Strings.please_wait);
    DataState<ContactUsResponseEntity> response = await contactUsUsecase.call(ContactUsParams(
        contactUsRequestEntity: ContactUsRequestEntity(
          message: contactUsMessageTxt.value
        )
    ));
    Get.back();
    if (response is DataSuccess) {
      Get.offNamed(contactUsThankYouView);
    } else if (response is DataFailed) {
      Utility.showToastMessage(response.error!.message);
    }
  }
}