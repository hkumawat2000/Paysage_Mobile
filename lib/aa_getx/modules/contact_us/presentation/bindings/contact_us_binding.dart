import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/contact_us/data/data_source/contact_us_data_source.dart';
import 'package:lms/aa_getx/modules/contact_us/data/repositories/contact_us_respository_impl.dart';
import 'package:lms/aa_getx/modules/contact_us/domain/usecases/contact_us_usecase.dart';
import 'package:lms/aa_getx/modules/contact_us/presentation/controllers/contact_us_controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {


    Get.lazyPut<ContactUsDataSourceImpl>(
          () => ContactUsDataSourceImpl(),
    );

    Get.lazyPut<ContactUsRepositoryImpl>(
          () => ContactUsRepositoryImpl(
        Get.find<ContactUsDataSourceImpl>(),
      ),
    );

    Get.lazyPut<ContactUsUsecase>(
            () => ContactUsUsecase(Get.find<ContactUsRepositoryImpl>()));

    Get.lazyPut<ContactUsController>(() => ContactUsController(
      Get.find<ContactUsUsecase>()
    ));

  }

}