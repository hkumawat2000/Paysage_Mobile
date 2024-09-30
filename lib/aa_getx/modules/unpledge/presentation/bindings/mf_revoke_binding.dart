
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/unpledge/data/data_source/unpledge_data_source.dart';
import 'package:lms/aa_getx/modules/unpledge/data/repositories/unpledge_repository_impl.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/get_unpledge_details_usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/request_unpledge_otp_usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/controllers/mf_revoke_controller.dart';

class MfRevokeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UnpledgeDataSourceImpl>(()=>UnpledgeDataSourceImpl());

    Get.lazyPut<UnpledgeRepositoryImpl>(()=>UnpledgeRepositoryImpl(Get.find<UnpledgeDataSourceImpl>()));

    Get.lazyPut<GetUnpledgeDetailsUseCase>(()=>GetUnpledgeDetailsUseCase(Get.find<UnpledgeRepositoryImpl>()));

    Get.lazyPut<RequestUnpledgeOtpUseCase>(()=>RequestUnpledgeOtpUseCase(Get.find<UnpledgeRepositoryImpl>()));

    Get.lazyPut<MfRevokeController>(() => MfRevokeController(
          Get.find<ConnectionInfo>(),
          Get.find<GetUnpledgeDetailsUseCase>(),
          Get.find<RequestUnpledgeOtpUseCase>(),
        ));
  }

}