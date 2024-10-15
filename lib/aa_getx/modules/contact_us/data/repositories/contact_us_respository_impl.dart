import 'package:lms/aa_getx/core/error/exception.dart';
import 'package:lms/aa_getx/core/error/failure.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/cibil/domain/entities/request/cibil_otp_verification_request_entity.dart';
import 'package:lms/aa_getx/modules/contact_us/data/data_source/contact_us_data_source.dart';
import 'package:lms/aa_getx/modules/contact_us/data/models/request/contactus_request_model.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/entity/request/contactus_request_entity.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/entity/response/contactus_response_entity.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/repositories/contact_us_repository.dart';

import '../../../../core/constants/strings.dart';

class ContactUsRepositoryImpl implements ContactUsRepository {
  final ContactUsDataSource contactUsDataSource;
  ContactUsRepositoryImpl(this.contactUsDataSource);


  @override
  ResultFuture<ContactUsResponseEntity> contactUs(ContactUsRequestEntity contactUsRequestEntity) async {
    try {
      ContactUsRequestModel contactUsRequestModel =
      ContactUsRequestModel.fromEntity(contactUsRequestEntity);
      final contactUsResponseModel = await contactUsDataSource.contactUs(contactUsRequestModel);
      return DataSuccess(contactUsResponseModel.toEntity());
    } on ServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, 0));
    } on ApiServerException catch (e) {
      return DataFailed(ServerFailure(e.message ?? Strings.defaultErrorMsg, e.statusCode!));
    } catch (e) {
      return DataFailed(ServerFailure(e.toString(), 0));
    }
  }
}