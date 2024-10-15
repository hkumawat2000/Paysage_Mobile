import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/modules/lender/domain/entities/lender_response_entity.dart';

abstract class LenderRepository {
  ResultFuture<LenderResponseEntity> getLendersList();
}
