// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/auto_login_response_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/entity/request/login_submit_request_entity.dart';
import 'package:lms/aa_getx/modules/login/domain/repositories/login_repository.dart';

/// use case is a class responsible for encapsulating a specific piece of business logic or 
/// a particular operation that your application needs to perform.
/// It acts as a bridge between the presentation
/// layer and the data layer.
class LoginUseCase implements UsecaseWithParams<AuthLoginResponseEntity,LoginSubmitParams>{
	  
   final LoginRepository loginRepository;
   LoginUseCase(this.loginRepository);

  @override
  ResultFuture<AuthLoginResponseEntity> call(params)async {
    return await loginRepository.loginSubmit(params.loginSubmitResquestEntity);
  }
}




class LoginSubmitParams {
  final LoginSubmitResquestEntity loginSubmitResquestEntity;
  LoginSubmitParams({
    required this.loginSubmitResquestEntity,
  });
}
