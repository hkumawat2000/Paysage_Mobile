import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/aml_check/domain/entity/aml_check_response_entity.dart';

abstract class AmlCheckRepository {
  ResultFuture<AmlCheckResponseEntity> amlCheck();

}