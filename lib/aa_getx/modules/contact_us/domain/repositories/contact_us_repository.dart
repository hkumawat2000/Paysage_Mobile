import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/entity/request/contactus_request_entity.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/entity/response/contactus_response_entity.dart';

abstract class ContactUsRepository {

  ResultFuture<ContactUsResponseEntity> contactUs(ContactUsRequestEntity contactUsRequestEntity);
}