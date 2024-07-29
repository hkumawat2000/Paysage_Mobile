class DeleteNotificationEntity {
  int? isForRead;
  int? isForClear;
  String? notificationName;

  DeleteNotificationEntity(
      {required this.isForRead,
      required this.isForClear,
      required this.notificationName});
}
