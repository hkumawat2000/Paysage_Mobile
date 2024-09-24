import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/bank/data/data_source/bank_data_source.dart';
import 'package:lms/aa_getx/modules/bank/data/repository/bank_repository_impl.dart';
import 'package:lms/aa_getx/modules/bank/domain/usecases/get_bank_details_usecase.dart';
import 'package:lms/aa_getx/modules/bank/domain/usecases/get_ifsc_bank_details_usecase.dart';
import 'package:lms/aa_getx/modules/bank/domain/usecases/validate_bank_usecase.dart';
import 'package:lms/aa_getx/modules/bank/presentation/controllers/add_bank_controller.dart';

class AddBankBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<BankDataSourceImpl>(()=>BankDataSourceImpl());

    Get.lazyPut<BankRepositoryImpl>(()=>BankRepositoryImpl(Get.find<BankDataSourceImpl>()));

    Get.lazyPut<GetBankDetailsUseCase>(()=>GetBankDetailsUseCase(Get.find<BankRepositoryImpl>()));

    Get.lazyPut<GetIfscBankDetailsUseCase>(()=> GetIfscBankDetailsUseCase(Get.find<BankRepositoryImpl>()));

    Get.lazyPut<ValidateBankUseCase>(()=> ValidateBankUseCase(Get.find<BankRepositoryImpl>()));

    Get.lazyPut<AddBankController>(
          () => AddBankController(
        Get.find<ConnectionInfo>(),
        Get.find<GetBankDetailsUseCase>(),
        Get.find<GetIfscBankDetailsUseCase>(),
        Get.find<ValidateBankUseCase>(),
      ),
    );
  }

}