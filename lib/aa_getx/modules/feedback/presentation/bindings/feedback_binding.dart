import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/feedback/data/data_source/feedback_data_source.dart';
import 'package:lms/aa_getx/modules/feedback/data/repositories/feedback_repository_impl.dart';
import 'package:lms/aa_getx/modules/feedback/domain/usecases/feedback_usecase.dart';
import 'package:lms/aa_getx/modules/feedback/presentation/controllers/feedback_controller.dart';

class FeedbackBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<FeedbackDataSourceImpl>(
          () => FeedbackDataSourceImpl(),
    );

    Get.lazyPut<FeedbackRepositoryImpl>(
          () => FeedbackRepositoryImpl(
        Get.find<FeedbackDataSourceImpl>(),
      ),
    );

    Get.lazyPut<FeedbackUsecase>(
            () => FeedbackUsecase(Get.find<FeedbackRepositoryImpl>()));

    Get.lazyPut<FeedbackController>(() => FeedbackController(
        Get.find<FeedbackUsecase>()
    ));
  }

}