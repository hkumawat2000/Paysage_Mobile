import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/aml_check/domain/entity/aml_check_response_entity.dart';
import 'package:lms/aa_getx/modules/aml_check/domain/repositories/aml_check_repository.dart';


class AmlCheckUsecase extends UsecaseWithoutParams<AmlCheckResponseEntity> {

  final AmlCheckRepository amlCheckRepository;
  AmlCheckUsecase(this.amlCheckRepository);

  @override
  ResultFuture<AmlCheckResponseEntity> call() async {
    return await amlCheckRepository.amlCheck();
  }

}
