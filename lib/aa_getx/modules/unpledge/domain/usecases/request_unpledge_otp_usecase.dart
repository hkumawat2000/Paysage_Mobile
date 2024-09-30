
import 'package:lms/aa_getx/core/utils/type_def.dart';
import 'package:lms/aa_getx/core/utils/usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/repositories/unpledge_repository.dart';

class RequestUnpledgeOtpUseCase
    extends UsecaseWithoutParams<CommonResponseEntity> {
  final UnpledgeRepository unpledgeRepository;

  RequestUnpledgeOtpUseCase(this.unpledgeRepository);

  @override
  ResultFuture<CommonResponseEntity> call() async {
    return await unpledgeRepository.requestUnpledgeOtp();
  }
}