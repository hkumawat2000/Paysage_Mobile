import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/get_terms_and_privacy_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';

/// LoginRepository is an abstract class defining the contract for operations
/// related to data within the domain layer.
/// Concrete implementations of this repository interface will be provided
/// in the data layer to interact with specific data sources (e.g., API, database).
abstract class LoginRepository {

ResultFuture<GetTermsandPrivacyResponseEntity> getTermsAndPrivacyUrl();
ResultFuture<AuthLoginResponseEntity> loginSubmit(LoginSubmitResquestEntity loginSubmitResquestEntity);


}