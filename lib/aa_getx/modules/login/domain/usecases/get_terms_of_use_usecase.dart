import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/get_terms_and_privacy_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/repositories/login_repository.dart';

class GetTermsOfUseUsecase
    extends UsecaseWithoutParams<GetTermsandPrivacyResponseEntity> {
  final LoginRepository loginRepository;

  GetTermsOfUseUsecase(this.loginRepository);

  @override
  ResultFuture<GetTermsandPrivacyResponseEntity> call() async {
    return await loginRepository.getTermsAndPrivacyUrl();
  }
}