
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/unpledge_request_usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/controllers/unpledge_otp_verification_controller.dart';
import 'package:lms/aa_getx/modules/unpledge/data/data_source/unpledge_data_source.dart';
import 'package:lms/aa_getx/modules/unpledge/data/repositories/unpledge_repository_impl.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/get_unpledge_details_usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/request_unpledge_otp_usecase.dart';

class UnpledgeOtpVerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UnpledgeDataSourceImpl>(()=>UnpledgeDataSourceImpl());

    Get.lazyPut<UnpledgeRepositoryImpl>(()=>UnpledgeRepositoryImpl(Get.find<UnpledgeDataSourceImpl>()));

    Get.lazyPut<GetUnpledgeDetailsUseCase>(()=>GetUnpledgeDetailsUseCase(Get.find<UnpledgeRepositoryImpl>()));

    Get.lazyPut<RequestUnpledgeOtpUseCase>(()=>RequestUnpledgeOtpUseCase(Get.find<UnpledgeRepositoryImpl>()));

    Get.lazyPut<UnpledgeRequestUsecase>(()=>UnpledgeRequestUsecase(Get.find<UnpledgeRepositoryImpl>()));

    Get.lazyPut<UnpledgeOtpVerificationController>(() => UnpledgeOtpVerificationController(
      Get.find<ConnectionInfo>(),
      Get.find<RequestUnpledgeOtpUseCase>(),
      Get.find<UnpledgeRequestUsecase>(),
    ));
  }

}