import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/modules/more/data/data_sources/more_api.dart';
import 'package:lms/aa_getx/modules/more/data/repositories/more_repository_impl.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/notification/data/data_source/notification_api.dart';
import 'package:lms/aa_getx/modules/notification/data/repositories/notification_repository_impl.dart';
import 'package:lms/aa_getx/modules/notification/domain/usecases/delete_clear_notification_usecase.dart';
import 'package:lms/aa_getx/modules/notification/domain/usecases/get_notification_usecase.dart';
import 'package:lms/aa_getx/modules/notification/presentation/controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationApiImpl>(
      () => NotificationApiImpl(),
    );

    Get.lazyPut<NotificationRepositoryImpl>(
      () => NotificationRepositoryImpl(Get.find<NotificationApiImpl>()),
    );

    Get.lazyPut<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(Get.find<NotificationRepositoryImpl>()),
    );

    Get.lazyPut<DeleteOrClearNotificationUseCase>(() =>
        DeleteOrClearNotificationUseCase(
            Get.find<NotificationRepositoryImpl>()));

    Get.lazyPut<MoreApiImpl>(()=>MoreApiImpl());

    Get.lazyPut<MoreRepositoryImpl>(()=>MoreRepositoryImpl(Get.find<MoreApiImpl>()));

    Get.lazyPut<GetLoanDetailsUseCase>(()=> GetLoanDetailsUseCase(Get.find<MoreRepositoryImpl>()));

    Get.lazyPut<NotificationController>(() => NotificationController(
        Get.find<GetNotificationsUseCase>(),
        Get.find<ConnectionInfo>(),
        Get.find<DeleteOrClearNotificationUseCase>(),
        Get.find<GetLoanDetailsUseCase>(),
    ));
  }
}
