import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/entity/request/contactus_request_entity.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/entity/response/contactus_response_entity.dart';

import '../repositories/contact_us_repository.dart';

class ContactUsUsecase implements UsecaseWithParams<ContactUsResponseEntity, ContactUsParams>{

  final ContactUsRepository contactUsRepository;
  ContactUsUsecase(this.contactUsRepository);

  @override
  ResultFuture<ContactUsResponseEntity> call(params) async {
    return await contactUsRepository.contactUs(params.contactUsRequestEntity);
  }

}

class ContactUsParams {
  final ContactUsRequestEntity contactUsRequestEntity;
  ContactUsParams({
    required this.contactUsRequestEntity,
  });
}